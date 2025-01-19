//
//  InfiniteScroll.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//


import SwiftUI
import Combine

class InfiniteScroll: ObservableObject {
    @Published var rideCards: [RideCard] = [RideCard(id:1, name: "Lin Jin", rating:5.0, numRatings: 19, bookmarked: false, price: 15, departureTime: "1:00 PM", arrivalTime: "5:00 PM", meetingLocation: "161 Ho Plaza, Ithaca, NY", destination: "So Ho, New York, NY", gender_preference: "All females", availableSeats: 2, totalSeats: 4, profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a"),
                                            RideCard(id:2, name: "Lin Jin", rating:5.0, numRatings: 19, bookmarked: false, price: 15, departureTime: "1:00 PM", arrivalTime: "5:00 PM", meetingLocation: "161 Ho Plaza, Ithaca, NY", destination: "So Ho, New York, NY", gender_preference: "All females", availableSeats: 2, totalSeats: 4, profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a"),
                                            RideCard(id:3, name: "Lin Jin", rating:5.0, numRatings: 19, bookmarked: false, price: 15, departureTime: "1:00 PM", arrivalTime: "5:00 PM", meetingLocation: "161 Ho Plaza, Ithaca, NY", destination: "So Ho, New York, NY", gender_preference: "All females", availableSeats: 2, totalSeats: 4, profilePicURL: "https://i.scdn.co/image/ab67616100005174bcb1c184c322688f10cdce7a")]
    @Published var isLoading: Bool = false
    @Published var hasMoreData: Bool = true
    private var currentPage = 1
    private var totalPages = 1
    
    // Example API call
    func fetchRideCards() {
        guard !isLoading && hasMoreData else { return } // Prevent fetching if already loading or no more data
        
        isLoading = true
        let url = URL(string: "https://your-api-endpoint.com/rides?page=\(currentPage)")! // Update with your API
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                return
            }
            
            do {
                // Assuming JSON response
                let newRides = try JSONDecoder().decode([RideCard].self, from: data)
                DispatchQueue.main.async {
                    self.rideCards.append(contentsOf: newRides)
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
    
    // Trigger the data load when reaching the bottom
    func checkIfNeedMoreData() {
        if !isLoading && hasMoreData {
            fetchRideCards()
        }
    }
}
