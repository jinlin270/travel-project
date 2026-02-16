//
//  ScrollCardsView.swift
//  travel
//
//  Created by Lin Jin on 1/18/25.
import SwiftUI

struct ScrollCardsView: View {
    @Binding var isRideOffer: Bool
    @Binding var isRideInfo: Bool
    @Binding var isMyGroup: Bool
    @StateObject var viewModel: InfiniteScroll
    var onTripSelected: (TripInfo) -> Void

    init(isRideOffer: Binding<Bool>, isRideInfo: Binding<Bool>, isMyGroup: Binding<Bool>, onTripSelected: @escaping (TripInfo) -> Void = { _ in }) {
        _isRideOffer = isRideOffer
        _isRideInfo = isRideInfo
        _isMyGroup = isMyGroup
        _viewModel = StateObject(wrappedValue: InfiniteScroll(isRideOffer: isRideOffer, isRideInfo: isRideInfo))
        self.onTripSelected = onTripSelected // Direct assignment
    }

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.rideCards.isEmpty && viewModel.communityGroups.isEmpty {
                loadingView
            } else if !viewModel.isLoading && isRideInfo && viewModel.rideCards.isEmpty {
                emptyStateView(
                    icon: "car.fill",
                    title: isRideOffer ? "No rides available" : "No ride requests yet",
                    subtitle: isRideOffer ? "Check back later for available rides." : "Be the first to post a ride request!"
                )
            } else if !viewModel.isLoading && !isRideInfo && viewModel.communityGroups.isEmpty {
                emptyStateView(
                    icon: "person.3.fill",
                    title: "No groups yet",
                    subtitle: "Communities will appear here once they're created."
                )
            } else {
                ScrollView {
                    LazyVStack {
                        if isRideInfo {
                            rideInfoView
                        } else {
                            communityGroupsView
                        }
                    }
                }

                if viewModel.isLoading {
                    loadingMoreView
                }
            }
        }
        .onAppear(perform: onAppear)
        .onChange(of: isRideInfo, perform: onRideInfoChanged)
        // Step 5a: When the Offers ↔ Requests toggle flips, the old ride list
        // belongs to a different query. Reset page state and fetch fresh.
        .onChange(of: isRideOffer) { _ in
            viewModel.resetRides()
            viewModel.fetchRideCards()
        }
    }

    // Subviews for readability

    private var loadingView: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
    }

    private var loadingMoreView: some View {
        ProgressView("Loading more...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }

    private func emptyStateView(icon: String, title: String, subtitle: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.gray.opacity(0.5))
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 80)
    }

    private var rideInfoView: some View {
        Group {
            if isRideOffer {
                ForEach(viewModel.rideCards, id: \.id) { rideCard in
                    RideCardView(ride_card: rideCard, onReserve: onTripSelected)
                        .padding()
                        .onAppear {
                            loadMoreDataIfNeeded(rideCard: rideCard)
                        }
                }
            } else {
                ForEach(viewModel.rideCards, id: \.id) { rideCard in
                    RequestRideCardView(ride_card: rideCard)
                        .padding()
                        .onAppear {
                            loadMoreDataIfNeeded(rideCard: rideCard)
                        }
                }
            }
        }
    }

    private var communityGroupsView: some View {
        Group {
            if isMyGroup {
                ForEach(viewModel.communityGroups, id: \.id) { group in
                    MyGroupCardView(group: group)
                        .padding(.vertical, 12)
                        .onAppear {
                            loadMoreDataIfNeeded(group: group)
                        }
                }
            } else {
                ForEach(viewModel.communityGroups, id: \.id) { group in
                    CommunityGroupCardView(group: group)
                        .padding(.vertical, 12)
                        .onAppear {
                            loadMoreDataIfNeeded(group: group)
                        }
                }
            }
        }
        
       
    }

    // Helper functions to avoid code duplication
    private func loadMoreDataIfNeeded(rideCard: TripInfo) {
        if rideCard == viewModel.rideCards.last {
            viewModel.checkIfNeedMoreData()
        }
    }

    private func loadMoreDataIfNeeded(group: GroupModel) {
        if group == viewModel.communityGroups.last {
            viewModel.checkIfNeedMoreData()
        }
    }

    private func onAppear() {
        if isRideInfo && viewModel.rideCards.isEmpty {
            viewModel.fetchRideCards() // Initial load for rides
        } else if !isRideInfo && viewModel.communityGroups.isEmpty {
            viewModel.fetchCommunityGroups() // Initial load for community groups
        }
    }

    private func onRideInfoChanged(newValue: Bool) {
        // Step 5b: Use the ViewModel's reset helpers so that the page counter
        // is also zeroed out — not just the data array. Without this, the next
        // fetch would start at the wrong page.
        if newValue {
            viewModel.resetRides()
            viewModel.fetchRideCards()
        } else {
            viewModel.resetGroups()
            viewModel.fetchCommunityGroups()
        }
    }
}

//
//struct ScrollCardsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollCardsViewPreview()
//    }
//}

//struct ScrollCardsViewPreview: View {
//    @State private var isRideOffer = true
//    @State private var isRideInfo = true
//    @State private var isMyGroup = true
//
//    var body: some View {
//        ScrollCardsView(isRideOffer: $isRideOffer, isRideInfo: $isRideInfo, isMyGroup: $isMyGroup)
//    }
//}
