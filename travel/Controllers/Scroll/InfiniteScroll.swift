//
//  InfiniteScroll.swift
//  travel
//
//  ViewModel for paginated fetching of TripInfo and GroupModel.
//
//  Pagination contract (Spring Boot):
//    GET /trips?isOffer={bool}&page={n}&size=10
//    GET /groups?page={n}&size=10
//    Response envelope: { "content": [...], "last": true/false, "totalPages": N }
//

import SwiftUI

// MARK: - Spring Boot Page<T> envelope

/// Matches the Spring Boot Page<T> JSON shape.
/// Only decodes the fields InfiniteScroll actually needs.
private struct Page<T: Decodable>: Decodable {
    let content: [T]
    let last: Bool
}

// MARK: - InfiniteScroll ViewModel

/// @MainActor ensures all @Published mutations happen on the main thread.
/// Individual async fetch methods suspend off-main during the network call
/// (URLSession suspension) and resume on main automatically.
@MainActor
class InfiniteScroll: ObservableObject {

    // MARK: Outputs

    @Published var rideCards: [TripInfo] = []
    @Published var communityGroups: [GroupModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    // MARK: Bindings from parent

    @Binding var isRideOffer: Bool   // true = ride offers, false = ride requests
    @Binding var isRideInfo: Bool    // true = rides tab,   false = groups tab

    // MARK: Pagination state — separate per data type so switching tabs doesn't corrupt page counters

    private var rideCurrentPage = 0
    private var rideHasMore = true

    private var groupCurrentPage = 0
    private var groupHasMore = true

    private let pageSize = 10

    // MARK: Init

    init(isRideOffer: Binding<Bool>, isRideInfo: Binding<Bool>) {
        _isRideOffer = isRideOffer
        _isRideInfo = isRideInfo
    }

    // MARK: - Public API

    /// Call from ScrollCardsView when a ride card is about to disappear off the bottom.
    func fetchRideCards() {
        guard !isLoading && rideHasMore else { return }
        Task { await loadRideCards() }
    }

    /// Call from ScrollCardsView when a group card is about to disappear off the bottom.
    func fetchCommunityGroups() {
        guard !isLoading && groupHasMore else { return }
        Task { await loadCommunityGroups() }
    }

    /// Dispatched by ScrollCardsView's `.onAppear` / trigger logic.
    func checkIfNeedMoreData() {
        if isRideInfo {
            fetchRideCards()
        } else {
            fetchCommunityGroups()
        }
    }

    // MARK: - Reset helpers (call before re-fetching after a toggle change)

    /// Clears ride data and resets the ride page counter.
    /// Must be called when isRideOffer flips (Offers ↔ Requests)
    /// or when switching back to the rides tab.
    func resetRides() {
        rideCards = []
        rideCurrentPage = 0
        rideHasMore = true
        errorMessage = nil
    }

    /// Clears group data and resets the group page counter.
    /// Must be called when switching to the groups tab.
    func resetGroups() {
        communityGroups = []
        groupCurrentPage = 0
        groupHasMore = true
        errorMessage = nil
    }

    // MARK: - Private fetch logic

    /// Ride offers:  GET /trips/offers?page=N&size=10           → Page<TripInfo>
    /// Ride requests: GET /trips/requests/paginated?page=N&size=10 → Page<TripInfo>
    /// isRideOffer selects which endpoint to call.
    private func loadRideCards() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let path: String
        if isRideOffer {
            path = "/trips/offers?page=\(rideCurrentPage)&size=\(pageSize)"
        } else {
            path = "/trips/requests/paginated?page=\(rideCurrentPage)&size=\(pageSize)"
        }
        do {
            let page: Page<TripInfo> = try await APIClient.shared.request(path)
            rideCards.append(contentsOf: page.content)
            rideCurrentPage += 1
            rideHasMore = !page.last
        } catch is DecodingError {
            // Backend returned empty or unexpected format — treat as no results
            rideHasMore = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    /// Groups: GET /groups → List<CommunityGroup> (not paginated on the backend).
    /// Fetches all groups in one call and marks groupHasMore = false afterwards.
    private func loadCommunityGroups() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let groups: [GroupModel] = try await APIClient.shared.request("/groups")
            communityGroups = groups
            groupHasMore = false   // single-page response — no more data to load
        } catch is DecodingError {
            // Backend returned empty or unexpected format — treat as no results
            groupHasMore = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
