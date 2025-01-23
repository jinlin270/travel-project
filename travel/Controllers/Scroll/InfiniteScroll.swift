//
//  InfiniteScroll.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//

import SwiftUI
import Combine

enum FetchType {
    case rideCards
    case communityGroups
}

class InfiniteScroll: ObservableObject {
    let user1: User
    @Published var rideCards: [TripInfo] = []
    @Published var communityGroups: [GroupModel] = []
    @Binding var isRideOffer: Bool
    @Binding var isRideInfo: Bool
    
    @Published var isLoading: Bool = false
    @Published var hasMoreData: Bool = true
    private var currentPage = 1
    private var totalPages = 1
    
    init(isRideOffer: Binding<Bool>, isRideInfo: Binding<Bool>) {
        self.user1 = User(
            id: 2,
            name: "Lin Jin",
            rating: 5.0,
            numRatings: 5,
            profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a",
            loudness: 5,
            musicPreference: "ROCK AND ROLLLL",
            funFact: "pokemon :)",
            phoneNumber: "xxx-xxx-xxxx",
            pronouns: "She/Her",
            grade: "Senior",
            location: "Cornell University",
            email: "linjin@gmail.com"
        )
        rideCards = [TripInfo(
            id: 1,
            driver: user1,
            bookmarked: false,
            price: 15,
            departureTime: Date(),
            arrivalTime: Date(),
            meetingLocation: "161 Ho Plaza, Ithaca, NY",
            destination: "So Ho, New York, NY",
            gender_preference: "All females",
            availableSeats: 2,
            totalSeats: 4
        ),
            TripInfo(
                            id: 2,
                            driver: user1,
                            bookmarked: false,
                            price: 15,
                            departureTime: Date(),
                            arrivalTime: Date(),
                            meetingLocation: "161 Ho Plaza, Ithaca, NY",
                            destination: "So Ho, New York, NY",
                            gender_preference: "All females",
                            availableSeats: 2,
                            totalSeats: 4
                        ),
             TripInfo(
                             id: 3,
                             driver: user1,
                             bookmarked: false,
                             price: 15,
                             departureTime: Date(),
                             arrivalTime: Date(),
                             meetingLocation: "161 Ho Plaza, Ithaca, NY",
                             destination: "So Ho, New York, NY",
                             gender_preference: "All females",
                             availableSeats: 2,
                             totalSeats: 4
                         )]
        communityGroups = [GroupModel(id: 1, groupName: "Cornell 2025", profilePicture: "https://cdn.britannica.com/08/235008-050-C82C6C44/Cornell-University-Uris-Library-Ithaca-New-York.jpg", isPublic: true, numMembers: 15, filterTags: Set(arrayLiteral: "Popular"), latitude: Double(42.4534), longitude: Double(76.4735))]
        
        _isRideOffer = isRideOffer
        _isRideInfo = isRideInfo
    }
    
    // Generalized API call function
    func fetchData<T: Decodable>(urlString: String, page: Int, completion: @escaping ([T]) -> Void) {
        guard !isLoading && hasMoreData else { return }
        
        isLoading = true
        let url = URL(string: urlString + "?page=\(page)")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                return
            }
            
            do {
                let newItems = try JSONDecoder().decode([T].self, from: data)
                DispatchQueue.main.async {
                    completion(newItems)
                    self.isLoading = false
                    
                    // Update pagination state
                    self.currentPage += 1
                    if self.currentPage > self.totalPages {
                        self.hasMoreData = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    // Fetch data for rides or community groups
    func fetchDataForType<T: Decodable>(type: FetchType, completion: @escaping ([T]) -> Void) {
        let urlString: String
        switch type {
        case .rideCards:
            urlString = "https://your-api-endpoint.com/rides/is_requestblabla\(isRideOffer)"
        case .communityGroups:
            urlString = "https://your-api-endpoint.com/communityGroups"
        }
        
        fetchData(urlString: urlString, page: currentPage) { newItems in
            completion(newItems)
        }
    }
    
    // Fetch ride cards
    func fetchRideCards() {
        fetchDataForType(type: .rideCards) { [weak self] (newRides: [TripInfo]) in
            self?.rideCards.append(contentsOf: newRides)
        }
    }
    
    // Fetch community groups
    func fetchCommunityGroups() {
        fetchDataForType(type: .communityGroups) { [weak self] (newGroups: [GroupModel]) in
            self?.communityGroups.append(contentsOf: newGroups)
        }
    }
    
    // Trigger data load based on `isRideInfo`
    func checkIfNeedMoreData() {
        if !isLoading && hasMoreData {
            if isRideInfo {
                fetchRideCards()
            } else {
                fetchCommunityGroups()
            }
        }
    }
}
