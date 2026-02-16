//
//  APIClient.swift
//  travel
//
//  Centralized networking layer. All requests go through here so that:
//    - The Bearer token is injected in one place
//    - Date decoding (Spring Boot 3 ISO 8601 with fractional seconds) is configured once
//    - Error handling is uniform across the app
//

import Foundation

// MARK: - Error type

enum APIError: LocalizedError {
    case unauthorized               // 401 — token expired or invalid
    case notFound                   // 404
    case serverError(Int)           // 4xx/5xx other than above
    case decodingError(Error)       // JSON → model mismatch
    case networkError(Error)        // URLSession transport failure
    case invalidURL

    var errorDescription: String? {
        switch self {
        case .unauthorized:         return "Session expired. Please sign in again."
        case .notFound:             return "Resource not found."
        case .serverError(let code): return "Server error (\(code))."
        case .decodingError(let e): return "Response format error: \(e.localizedDescription)"
        case .networkError(let e):  return "Network error: \(e.localizedDescription)"
        case .invalidURL:           return "Invalid URL."
        }
    }
}

// MARK: - APIClient

struct APIClient {

    static let shared = APIClient()
    private init() {}

    // One JSONDecoder for the whole app.
    // Spring Boot 3 serialises java.util.Date as ISO 8601 with fractional seconds:
    //   e.g. "2026-02-18T02:10:43.453+00:00"
    // Standard .iso8601 strategy doesn't handle fractional seconds, so we use
    // ISO8601DateFormatter with .withFractionalSeconds.
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        d.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let str = try container.decode(String.self)
            if let date = iso.date(from: str) { return date }
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date: \(str)"
            )
        }
        return d
    }()

    private let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.dateEncodingStrategy = .millisecondsSince1970
        return e
    }()

    // MARK: - Core request

    /// Perform an authenticated request and decode the response body into `T`.
    func request<T: Decodable>(
        _ path: String,
        method: String = "GET",
        body: Encodable? = nil
    ) async throws -> T {
        guard let url = URL(string: Constants.baseURL + path) else {
            throw APIError.invalidURL
        }

        var req = URLRequest(url: url)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = AuthManager.shared.token {
            req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            req.httpBody = try encoder.encode(AnyEncodable(body))
        }

        let (data, response) = try await URLSession.shared.data(for: req)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.networkError(URLError(.badServerResponse))
        }

        switch http.statusCode {
        case 200...299:
            break
        case 401:
            // Token rejected — sign the user out so the auth gate re-appears
            await MainActor.run { AuthManager.shared.signOut() }
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        default:
            throw APIError.serverError(http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            // Print raw JSON so decode mismatches are visible in the Xcode console
            #if DEBUG
            print("⚠️ APIClient decode error for \(T.self):\n\(error)")
            if let raw = String(data: data, encoding: .utf8) {
                print("⚠️ Raw response (\(path)):\n\(raw.prefix(2000))")
            }
            #endif
            throw APIError.decodingError(error)
        }
    }

    /// Perform an authenticated request that returns no body (204 No Content).
    func requestVoid(
        _ path: String,
        method: String,
        body: Encodable? = nil
    ) async throws {
        guard let url = URL(string: Constants.baseURL + path) else {
            throw APIError.invalidURL
        }

        var req = URLRequest(url: url)
        req.httpMethod = method
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = AuthManager.shared.token {
            req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            req.httpBody = try encoder.encode(AnyEncodable(body))
        }

        let (_, response) = try await URLSession.shared.data(for: req)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.networkError(URLError(.badServerResponse))
        }

        if http.statusCode == 401 {
            await MainActor.run { AuthManager.shared.signOut() }
            throw APIError.unauthorized
        }

        guard (200...299).contains(http.statusCode) else {
            throw APIError.serverError(http.statusCode)
        }
    }
}

// MARK: - AnyEncodable helper

/// Wraps any Encodable so it can be passed to encoder.encode(_:) generically.
private struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void

    init(_ value: Encodable) {
        _encode = value.encode
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
