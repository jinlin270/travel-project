//
//  GroupView.swift
//  travel
//
//  Community page — single scrollable layout:
//    [Fixed] Community title, CommunityBar, DropdownMenu + SearchBar
//    [Scroll] "Filter" header + See all toggle → community groups → "Your Group" header → user groups
//
//  "See all" expands the filtered section inline, pushing "Your Group" down.
//  Both sections use separate InfiniteScroll ViewModels so pagination is independent.
//

import SwiftUI
import Foundation

struct GroupView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var NavHome = false
    @State private var NavCommunity = false
    @State private var NavProfile = false

    @State private var selectedOption: String = "Filter"
    @State private var isMenuOpen: Bool = false
    @State private var showAllFiltered = false

    // Two independent ViewModels — filtered/community groups and the user's own groups.
    // Both fetch from /groups for now; swap myGroupVM to /groups/my when that endpoint exists.
    @StateObject private var filteredVM: InfiniteScroll
    @StateObject private var myGroupVM: InfiniteScroll

    private let collapsedCount = 3

    init() {
        _filteredVM = StateObject(wrappedValue: InfiniteScroll(
            isRideOffer: .constant(true),
            isRideInfo: .constant(false)
        ))
        _myGroupVM = StateObject(wrappedValue: InfiniteScroll(
            isRideOffer: .constant(true),
            isRideInfo: .constant(false)
        ))
    }

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Fixed header (does not scroll)

            Text("Community")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .padding(.top, 8)
                .padding(.horizontal, 24)

            Spacer().frame(height: 8)

            CommunityBar()

            // DropdownMenu + SearchBar stay fixed so the user can filter while scrolling.
            // zIndex ensures the dropdown overlay renders above the ScrollView.
            HStack(spacing: 8) {
                DropdownMenu(selectedOption: $selectedOption, isMenuOpen: $isMenuOpen)
                SearchBar()
            }
            .padding(.horizontal, 24)
            .padding(.top, 12)
            .zIndex(1)

            // MARK: Single scrollable body

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // ── Section 1: Filtered / community groups ────────────────
                    HStack {
                        Text(selectedOption)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                        Spacer()
                        Button(showAllFiltered ? "Collapse" : "See all") {
                            showAllFiltered.toggle()
                        }
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Constants.blue)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                    filteredGroupsSection

                    // ── Separator ─────────────────────────────────────────────
                    Spacer().frame(height: 24)

                    // ── Section 2: User's own groups ──────────────────────────
                    Text("Your Group")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 8)

                    myGroupsSection
                }
            }

            // MARK: Bottom navigation

            BottomNavigationBar(
                NavHome: $NavHome,
                NavCommunity: $NavCommunity,
                NavProfile: $NavProfile
            )
        }
        .frame(maxWidth: .infinity)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            filteredVM.fetchCommunityGroups()
            myGroupVM.fetchCommunityGroups()
        }
        .onChange(of: NavHome) { newValue in
            if newValue { router.popToRoot() }
        }
        .navigationDestination(isPresented: $NavProfile) {
            ProfilePageView()
        }
    }

    // MARK: - Filtered groups section

    @ViewBuilder
    private var filteredGroupsSection: some View {
        if filteredVM.isLoading && filteredVM.communityGroups.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
        } else if filteredVM.communityGroups.isEmpty {
            emptyGroupsView
        } else {
            ForEach(
                showAllFiltered
                    ? filteredVM.communityGroups
                    : Array(filteredVM.communityGroups.prefix(collapsedCount))
            ) { group in
                CommunityGroupCardView(group: group)
                    .padding(.vertical, 8)
                    .onAppear {
                        // Only load more when expanded and near the end
                        if showAllFiltered && group == filteredVM.communityGroups.last {
                            filteredVM.fetchCommunityGroups()
                        }
                    }
            }

            if filteredVM.isLoading && showAllFiltered {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
        }
    }

    // MARK: - User's groups section

    @ViewBuilder
    private var myGroupsSection: some View {
        if myGroupVM.isLoading && myGroupVM.communityGroups.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
        } else if myGroupVM.communityGroups.isEmpty {
            emptyGroupsView
        } else {
            ForEach(myGroupVM.communityGroups) { group in
                MyGroupCardView(group: group)
                    .padding(.vertical, 8)
                    .onAppear {
                        if group == myGroupVM.communityGroups.last {
                            myGroupVM.fetchCommunityGroups()
                        }
                    }
            }

            if myGroupVM.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            }
        }
    }

    // MARK: - Shared empty state

    private var emptyGroupsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.3.fill")
                .font(.system(size: 48))
                .foregroundColor(.gray.opacity(0.5))
            Text("No groups yet")
                .font(.headline)
                .foregroundColor(.primary)
            Text("Communities will appear here once they're created.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}


struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
