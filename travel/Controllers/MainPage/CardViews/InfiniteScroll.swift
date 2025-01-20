//
//  InfiniteScroll.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//


import SwiftUI
import Combine

class InfiniteScroll: ObservableObject {
    let user1: User
    @Published var rideCards: [TripInfo]
    @Binding var isRideOffer: Bool
    
    init(isRideOffer: Binding<Bool>) {
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
        let user2 = User(
            id: 3,
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
        let user3 = User(
            id: 4,
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
        
        self.rideCards = [
            TripInfo(
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
            )
        ]
        _isRideOffer = isRideOffer
    }
    
    @Published var isLoading: Bool = false
    @Published var hasMoreData: Bool = true
    private var currentPage = 1
    private var totalPages = 1
    
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
    
    // Fetch ride cards
    func fetchRideCards() {
        fetchData(urlString: "https://your-api-endpoint.com/rides/is_requestblabla\(isRideOffer)", page: currentPage) { [weak self] (newRides: [TripInfo]) in
            self?.rideCards.append(contentsOf: newRides)
        }
    }
    
    
    // Trigger the data load when reaching the bottom
    func checkIfNeedMoreData() {
        if !isLoading && hasMoreData {
                fetchRideCards()
        }
    }
}
