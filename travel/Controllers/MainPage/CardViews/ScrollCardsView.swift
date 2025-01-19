//
//  ScrollCardsView.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
//

import SwiftUI

struct ScrollCardsView: View {
    @Binding var isRideOffer : Bool
    @StateObject var viewModel: InfiniteScroll
    
    init(isRideOffer: Binding<Bool>) {
        _isRideOffer = isRideOffer
        _viewModel = StateObject(wrappedValue: InfiniteScroll(isRideOffer: isRideOffer))
    }


    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.rideCards.isEmpty {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.rideCards, id: \.id) { rideCard in
                            RideCardView(ride_card: rideCard)
                                .padding()
                                .onAppear {
                                    // Trigger data fetching when the last item appears
                                    if rideCard == viewModel.rideCards.last {
                                        viewModel.checkIfNeedMoreData()
                                    }
                                }
                        }
                    }
                }
                
                // Optionally, show a loading indicator at the bottom
                if viewModel.isLoading {
                    ProgressView("Loading more...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
            }
        }
        .onAppear {
            if viewModel.rideCards.isEmpty {
                viewModel.fetchRideCards() // Initial load when the view appears
            }
        }
    }
}
