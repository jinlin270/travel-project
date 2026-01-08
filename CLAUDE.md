# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**StuGo**: iOS ride-sharing app for college students built with SwiftUI. This is the frontend iOS application.

- **Bundle ID**: `com.Lin.travel`
- **Platform**: iOS (SwiftUI + UIKit hybrid)
- **Entry Point**: `AppDelegate.swift` → `SceneDelegate.swift` → `OnboardingProfile()`

## Building and Running

### Build the Project
```bash
# Open in Xcode
open travel.xcodeproj

# Build from command line (requires xcodebuild)
xcodebuild -project travel.xcodeproj -scheme travel -configuration Debug
```

### Run on Simulator
```bash
# List available simulators
xcrun simctl list devices

# Run on specific simulator
xcodebuild -project travel.xcodeproj -scheme travel -destination 'platform=iOS Simulator,name=iPhone 15' -configuration Debug
```

**Note**: No external dependencies (CocoaPods/SPM). Project uses standard Xcode project structure.

## Architecture Overview

### Pattern: Hybrid MVC/MVVM with SwiftUI

**Important**: The "Controllers" directory contains **SwiftUI Views**, not UIKit ViewControllers. This is a naming convention artifact from the project's evolution from UIKit to SwiftUI.

### Directory Structure

```
travel/
├── AppDelegate.swift              # App entry point
├── SceneDelegate.swift            # Sets initial view (OnboardingProfile)
├── Controllers/                   # SwiftUI Views organized by feature
│   ├── MainPage/                  # Home/Explore feature
│   │   ├── Explore.swift          # Main hub view
│   │   ├── CardViews/            # RideCardView, RequestRideCardView
│   │   └── Bars/                 # CalendarBar, RideRequestBar
│   ├── Scroll/                    # Infinite scroll components
│   │   ├── ScrollCardsView.swift  # Reusable scrolling container
│   │   └── InfiniteScroll.swift   # Pagination ViewModel
│   ├── ReserveRide/               # Booking flow (DetailsPage, Checkout, etc.)
│   ├── RequestRide/               # Ride request forms
│   ├── CommunityGroups/           # Groups feature
│   ├── ProfilePage/               # User profile
│   ├── Onboarding/                # SwiftUI onboarding screens
│   └── Welcome/                   # Legacy UIKit welcome screens
├── Models/                        # Data models + ViewModels
│   ├── User.swift                 # User model + UserManager singleton
│   ├── TripInfo.swift             # Ride data model
│   ├── *ViewModel.swift           # MVVM ViewModels (FilterViewModel, etc.)
│   ├── Constants.swift            # Color palette (blue, warmYellow, etc.)
│   └── tempData.swift             # Mock data for development
└── Views/                         # Reusable UI components
    ├── NavigationBar.swift        # Bottom tab bar
    ├── RadioButtons/              # Radio button variants
    └── *.swift                    # Other shared components
```

### Navigation Architecture

**Pattern**: SwiftUI NavigationStack with declarative, binding-based navigation

```swift
// Standard navigation pattern used throughout:
@State private var NavHome = false
@State private var NavProfile = false

.navigationDestination(isPresented: $NavHome) {
    ExploreRides()
}
.navigationBarBackButtonHidden(true)  // Manual back button hiding
```

**Main Navigation Flow**:
- **Bottom Tab Bar** (`NavigationBar.swift`): Bindings for Home/Community/Profile
- **No centralized router**: Each view manages its own navigation state
- **No stack accumulation**: Manual control prevents UIKit nav bar overlap

### State Management

#### 1. Singleton Pattern - Global User State
```swift
// UserManager.swift:35-40
class UserManager: ObservableObject {
    static let shared = UserManager()
    @Published var user: User
    private init() {}
}

// Usage in views:
@StateObject var userManager = UserManager.shared
```

#### 2. View-Owned ViewModels
```swift
// Each view creates its own ViewModel
@StateObject var viewModel: InfiniteScroll
@StateObject var filterViewModel = FilterViewModel()
```

#### 3. Parent-Child Communication via Callbacks
```swift
// Explore.swift passes callback to child:
ScrollCardsView(
    onTripSelected: { trip in
        selectedTrip = trip
        isNavigatingToDetails = true
    }
)
```

#### 4. Local @State for UI
```swift
@State private var showCalendar = false
@State private var selectedDate = Date()
```

### Main Page (Explore) Architecture

**Component Hierarchy**:
```
ExploreRides
├── ToggleView                    # Ride Offers ⇄ Requests toggle
├── CalendarBar / RideRequestBar  # Conditional based on toggle
├── SearchButton → SearchRidesView (modal overlay)
└── ScrollCardsView               # Infinite scroll container
    ├── InfiniteScroll ViewModel  # Pagination + API calls
    └── Card rendering:
        ├── RideCardView (if isRideOffer)
        └── RequestRideCardView (else)
```

**Key Files**:
- `Explore.swift:46-50`: Main ZStack with modal overlay pattern
- `ScrollCardsView.swift:12`: Owns InfiniteScroll ViewModel
- `InfiniteScroll.swift`: Pagination logic + generic `fetchData<T: Decodable>()`

### API Integration

**Current State**: Placeholder API calls using URLSession with async/await

```swift
// Pattern used throughout (e.g., Explore.swift:205-224):
func fetchRideCount(for selectedDate: Date) async -> Int {
    guard let url = URL(string: "http://something/date?date=...") else {
        return 0
    }
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try? JSONDecoder().decode(Int.self, from: data) ?? 0
    } catch {
        return 0
    }
}
```

- **No centralized networking layer**: Each ViewModel handles its own API calls
- **Mock URLs**: `http://something/...`, `https://blabla/...`
- **Graceful degradation**: All API errors return default values (0, empty arrays, etc.)
- **Mock data**: `tempData.swift` provides sample TripInfo/GroupModel objects

### Common UI Patterns

#### 1. Card Design System
All cards follow this structure:
```swift
ZStack {
    Rectangle()
        .fill(Color.white)
        .overlay(RoundedRectangle().stroke(Color.black, lineWidth: 1.5))
    VStack { /* Content */ }
}
```

#### 2. Color Constants
```swift
// Constants.swift - use these throughout the app
Constants.blue              // Primary action color
Constants.warmYellow        // Profile background
Constants.highlighterYellow // CTA buttons
```

#### 3. Reusable Components
- **NavigationBar**: Bottom tab bar with binding-based navigation
- **CustomTextFieldStyle**: Consistent form input styling
- **ImageFetcher**: Async image loading with `@Published var image: UIImage?`
- **Radio Buttons**: RegularRadioButton, SwappedRadioButton, FancyRadioButton

## Key Implementation Notes

1. **Naming Convention**: "Controllers" = SwiftUI Views (not UIKit ViewControllers)
2. **UIKit Legacy**: `Welcome/` directory contains old UIKit screens; rest is SwiftUI
3. **No Navigation Stack Accumulation**: `.navigationBarBackButtonHidden(true)` prevents UIKit nav bar overlay
4. **Mock Data for Development**: `tempData.swift` + fallback values in API calls
5. **Conditional Rendering**: Single views toggle content (e.g., ScrollCardsView renders different card types based on bindings)
6. **ViewModels Not Injected**: Each view creates `@StateObject` ViewModels directly (no DI pattern)

## Common Development Tasks

### Adding a New Feature View

1. Create SwiftUI View in appropriate `Controllers/` subdirectory
2. Add navigation binding in parent view:
   ```swift
   @State private var showNewFeature = false
   .navigationDestination(isPresented: $showNewFeature) {
       NewFeatureView()
   }
   ```
3. Use `Constants.swift` for colors to maintain design consistency
4. Follow card design pattern for consistency

### Working with API Calls

- Add new fetch methods to relevant ViewModel (or create new one)
- Follow async/await pattern with graceful error handling
- Return sensible defaults on error (0, [], nil)
- Test with mock data from `tempData.swift` first

### Modifying ScrollCardsView Behavior

ScrollCardsView is **reusable** across ExploreRides and GroupView:
- Use bindings (`isRideOffer`, `isRideInfo`, `isMyGroup`) to control rendering
- InfiniteScroll ViewModel handles pagination automatically
- Modify `fetchData<T>()` in `InfiniteScroll.swift` to add new data types

### User State Management

- Access global user via `UserManager.shared`
- Modify user data: `UserManager.shared.user.name = "New Name"`
- Persistence handled via UserDefaults in UserManager
- Local storage key: `"storedUser"`

## Implementing New Features from Designs

When implementing features from design files (PNGs, Figma exports, mockups), follow this comprehensive workflow to create pixel-perfect, production-ready SwiftUI views.

### Step 1: Analyze the Design

**Before writing any code, thoroughly analyze the design:**

1. **Read all design files** using the Read tool
2. **Extract design specifications**:
   - Colors (backgrounds, text, buttons, borders)
   - Typography (font sizes, weights, styles)
   - Spacing (margins, padding between elements)
   - Layout structure (VStack, HStack, ZStack arrangements)
   - Corner radius values
   - Shadow properties (if any)
   - Icon/image sizes
3. **Identify UI components**:
   - Buttons (primary, secondary, text buttons)
   - Text fields (search bars, input fields)
   - Cards/containers (check if matches existing card pattern)
   - Lists/grids
   - Navigation elements
   - Custom components

### Step 2: Plan Your Implementation

**Create a component breakdown before coding:**

```
Screen: RideDetailsPage
├── Background (Color.white)
├── Header
│   ├── Back Button
│   └── Title (Text, font: .title, weight: .bold)
├── Driver Info Card (ZStack with Rectangle border)
│   ├── Profile Image (AsyncImage, 60x60, circle)
│   ├── Name & Rating
│   └── Contact Button
├── Route Information
│   ├── From Location (HStack with icon)
│   └── To Location (HStack with icon)
├── Price Display (Constants.highlighterYellow background)
└── Reserve Button (Primary action)
```

### Step 3: Check for Existing Components

**BEFORE creating new components, check these locations:**

- `Models/Constants.swift` - Color palette, spacing constants
- `Views/` folder - Reusable buttons, text fields, cards, navigation components
- `Controllers/` subdirectories - Feature-specific components that might be reusable
- `Models/CustomTextFieldStyle.swift` - Text field styling
- `Views/RadioButtons/` - Radio button variants

**Existing Components to Reuse:**
- `NavigationBar` - Bottom tab navigation
- `CustomTextFieldStyle` - Form input styling
- `ImageFetcher` - Async image loading
- `Radio Buttons` - RegularRadioButton, SwappedRadioButton, FancyRadioButton
- `NavigationButtons` - Back/Next button patterns
- Card pattern - ZStack with Rectangle border (see existing card views)

**If component doesn't exist**: Create it in the appropriate location:
- Feature-specific: `Controllers/[FeatureName]/Components/`
- Reusable across features: `Views/`

### Step 4: Implement the Views

#### File Organization

**Create files in the appropriate Controllers/ subdirectory:**

```
Controllers/
└── [FeatureName]/
    ├── [MainFeature]View.swift          # Main screen view
    ├── [SubFeature]View.swift           # Secondary screens
    ├── Components/                      # Feature-specific components
    │   └── [Component]View.swift
    ├── CardViews/                       # Card components (if applicable)
    │   └── [Card]View.swift
    └── Bars/                            # Bar components (if applicable)
        └── [Bar]View.swift
```

#### View Decomposition Best Practices

**Keep views under 150 lines** - Extract subviews for clarity and reusability:

```swift
struct RideDetailsPage: View {
    @State private var selectedTrip: TripInfo
    @State private var showReservation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    driverInfoSection
                    routeSection
                    priceSection
                    actionSection
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // Extract each section as computed property
    private var driverInfoSection: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1.5))
            VStack(alignment: .leading, spacing: 12) {
                // Driver info content
            }
            .padding()
        }
    }

    private var routeSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            RoutePoint(icon: "location.fill", location: selectedTrip.from)
            RoutePoint(icon: "mappin", location: selectedTrip.to)
        }
    }

    private var priceSection: some View {
        HStack {
            Text("Total Price")
                .font(.headline)
            Spacer()
            Text("$\(selectedTrip.price, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Constants.blue)
        }
        .padding()
        .background(Constants.highlighterYellow.opacity(0.3))
        .cornerRadius(10)
    }

    private var actionSection: some View {
        Button("Reserve Ride") {
            showReservation = true
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Constants.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

// Extract complex subviews into separate structs
struct RoutePoint: View {
    let icon: String
    let location: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Constants.blue)
            Text(location)
                .font(.body)
        }
    }
}
```

#### State Management - Choose the Right Property Wrapper

| Wrapper | Use Case | Example in This Project |
|---------|----------|-------------------------|
| `@State` | Local UI state | `@State private var showCalendar = false` |
| `@Binding` | Child receives parent's state | `init(isRideOffer: Binding<Bool>)` |
| `@StateObject` | View owns ViewModel lifecycle | `@StateObject var viewModel = InfiniteScroll()` |
| `@ObservedObject` | Observe external object | `@ObservedObject var userManager: UserManager` |

**State Management Example:**
```swift
struct ExploreRides: View {
    // Local UI state - always private
    @State private var showCalendar = false
    @State private var selectedDate = Date()

    // View owns this ViewModel
    @StateObject private var viewModel = InfiniteScroll()

    // Access singleton (don't recreate it!)
    @StateObject var userManager = UserManager.shared

    var body: some View {
        VStack {
            // Pass bindings to children
            CalendarBar(
                selectedDate: $selectedDate,
                showCalendar: $showCalendar
            )

            ScrollCardsView(
                isRideOffer: $isRideOffer,
                isRideInfo: $isRideInfo
            )
        }
    }
}
```

#### Design System Usage

**Always use Constants.swift for colors:**

```swift
// ✅ GOOD: Using project color constants
Button("Reserve") {
    handleReservation()
}
.foregroundColor(.white)
.background(Constants.blue)

Text("Welcome")
    .foregroundColor(Constants.warmYellow)

// CTA buttons
Button("Book Now") { }
    .background(Constants.highlighterYellow)

// ❌ BAD: Hardcoded colors
Button("Reserve") { }
    .background(Color(red: 0.2, green: 0.4, blue: 0.8))  // Don't do this!
```

**Typography patterns:**
```swift
// Heading
Text("Welcome Back")
    .font(.system(size: 28, weight: .bold))
    .foregroundColor(.black)

// Body text
Text("Find your ride")
    .font(.system(size: 16, weight: .regular))
    .foregroundColor(.black)

// Subtext
Text("Last updated 2h ago")
    .font(.system(size: 14, weight: .regular))
    .foregroundColor(.gray)
```

#### Follow Card Design Pattern

**All cards must follow this consistent structure:**

```swift
// Standard card pattern (used throughout project)
ZStack {
    Rectangle()
        .fill(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1.5)
        )

    VStack(alignment: .leading, spacing: 12) {
        // Card content here
    }
    .padding(16)
}
.frame(width: 350, height: 220)  // Adjust dimensions as needed
```

**Example: Custom info card**
```swift
struct InfoCard: View {
    let title: String
    let content: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1.5)
                )

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                Text(content)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
}
```

#### Navigation Implementation

**Follow project's binding-based navigation pattern:**

```swift
struct ParentView: View {
    @State private var NavDetails = false
    @State private var NavProfile = false
    @State private var selectedTrip: TripInfo?

    var body: some View {
        NavigationStack {
            VStack {
                // Main content
                RideCardView(ride: trip) {
                    selectedTrip = trip
                    NavDetails = true
                }
            }
            .navigationDestination(isPresented: $NavDetails) {
                DetailsPage(trip: selectedTrip!)
            }
            .navigationDestination(isPresented: $NavProfile) {
                ProfilePageView()
            }
            .navigationBarBackButtonHidden(true)  // Always hide default back button
        }
    }
}
```

#### Image Handling

**Use ImageFetcher for async profile images:**

```swift
struct ProfileImage: View {
    @StateObject private var imageFetcher = ImageFetcher()
    let url: String

    var body: some View {
        Group {
            if let image = imageFetcher.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(Circle())
        .onAppear {
            imageFetcher.loadImage(from: url)
        }
    }
}
```

**SF Symbols for icons:**
```swift
Image(systemName: "person.circle.fill")
    .font(.system(size: 24))
    .foregroundColor(Constants.blue)

// Asset images
Image("logo")
    .resizable()
    .scaledToFit()
    .frame(width: 100, height: 100)
```

#### Lists and ScrollViews

**Use LazyVStack for performance:**

```swift
ScrollView {
    LazyVStack(spacing: 16) {
        ForEach(viewModel.rideCards) { ride in
            RideCardView(ride: ride, onReserve: handleReservation)
                .onAppear {
                    // Infinite scroll: load more when reaching this card
                    viewModel.loadMoreIfNeeded(currentItem: ride)
                }
        }
    }
    .padding()
}
```

### Step 5: Create Comprehensive Previews

**CRITICAL: Add previews to EVERY view you create**

```swift
// Basic preview
#Preview("Default State") {
    RideDetailsPage(trip: mockTrip)
}

// Different states
#Preview("Loading State") {
    RideDetailsPage(trip: mockTrip, isLoading: true)
}

#Preview("Dark Mode") {
    RideDetailsPage(trip: mockTrip)
        .preferredColorScheme(.dark)
}

// Different device sizes
#Preview("iPhone SE") {
    RideDetailsPage(trip: mockTrip)
        .previewDevice("iPhone SE (3rd generation)")
}

#Preview("iPhone 15 Pro Max") {
    RideDetailsPage(trip: mockTrip)
        .previewDevice("iPhone 15 Pro Max")
}

// Use mock data from tempData.swift
let mockTrip = TripInfo(
    id: 1,
    driver: User(id: 1, name: "Test Driver", rating: 5.0, ...),
    from: "Campus",
    to: "Airport",
    date: Date(),
    price: 25.0
)
```

### Step 6: Visual Verification

**Verify your implementation matches the design:**

**In Xcode:**
1. Open your Swift file in Xcode
2. Enable Canvas: `Editor > Canvas` or `⌥⌘↵`
3. Click "Resume" if preview is paused
4. Use preview selectors to test different states
5. Compare side-by-side with design file

**Verification Checklist:**
- [ ] All colors match the design (use Constants.swift)
- [ ] Font sizes and weights are correct
- [ ] Spacing between elements matches
- [ ] Corner radius values match (usually 10 for cards)
- [ ] Border widths match (1.5 for cards)
- [ ] Layout looks correct on iPhone SE (small screen)
- [ ] Layout looks correct on iPhone 15 Pro Max (large screen)
- [ ] Dark mode works if supported
- [ ] Interactive elements are tappable (minimum 44x44 tap target)
- [ ] Navigation flows work correctly
- [ ] Text is not truncated unexpectedly
- [ ] Images display correctly
- [ ] Scrolling works smoothly

### Step 7: Code Quality and Documentation

**Code organization:**
```swift
struct RideDetailsPage: View {
    // 1. Property wrappers and state
    @State private var showReservation = false
    @StateObject private var viewModel = DetailsViewModel()
    let trip: TripInfo

    // 2. Computed properties
    var formattedDate: String {
        trip.date.formatted()
    }

    // 3. Body
    var body: some View {
        NavigationStack {
            mainContent
        }
    }

    // 4. View builders for sections
    @ViewBuilder
    private var mainContent: some View {
        ScrollView {
            VStack(spacing: 24) {
                headerSection
                detailsSection
            }
        }
    }

    private var headerSection: some View {
        // Header content
    }

    // 5. Helper methods
    private func handleReservation() {
        showReservation = true
    }
}
```

**Add documentation to main view files:**
```swift
//
//  RideDetailsPage.swift
//  StuGo - travel
//
//  Feature: Ride Details and Booking
//
//  Displays detailed information about a selected ride including:
//  - Driver information with profile and rating
//  - Route details (from/to locations)
//  - Date and time
//  - Price breakdown
//  - Reserve/booking action
//
//  Dependencies:
//  - Models/TripInfo.swift (ride data model)
//  - Models/User.swift (driver information)
//  - Models/Constants.swift (color palette)
//  - Views/NavigationBar.swift (if bottom nav present)
//
//  Navigation:
//  - Navigates to CheckoutView on reserve button tap
//  - Back navigation to ExploreRides
//

import SwiftUI

struct RideDetailsPage: View {
    // Implementation
}
```

### Step 8: Performance Considerations

**Avoid expensive operations in body:**
```swift
// ✅ GOOD: Computed property or cached
@State private var formattedPrice: String = ""

var body: some View {
    Text(formattedPrice)
        .onAppear {
            formattedPrice = formatPrice(trip.price)
        }
}

// ❌ BAD: Heavy computation every render
var body: some View {
    Text(performComplexCalculation())  // Called every SwiftUI refresh!
}
```

**Use lazy loading:**
```swift
// ✅ GOOD: LazyVStack for large lists
ScrollView {
    LazyVStack {
        ForEach(items) { item in
            ItemView(item: item)
        }
    }
}

// ❌ BAD: VStack renders all immediately
ScrollView {
    VStack {
        ForEach(items) { item in
            ItemView(item: item)  // All 1000 rendered at once!
        }
    }
}
```

### Common Implementation Patterns

#### Custom Text Field (if not using CustomTextFieldStyle)
```swift
struct StyledTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
```

#### Loading State Overlay
```swift
struct ContentView: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            // Main content
            mainContent
                .blur(radius: isLoading ? 3 : 0)

            if isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .progressViewStyle(CircularProgressViewStyle(tint: Constants.blue))
            }
        }
    }
}
```

#### Search Bar Pattern
```swift
struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search rides...", text: $searchText)
                .textFieldStyle(.plain)

            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
```

### Implementation Completion Checklist

Before marking a feature complete:

- [ ] All screens from design are implemented
- [ ] Visual verification completed (matches design pixel-perfect)
- [ ] All views have SwiftUI previews with multiple states
- [ ] Code follows project patterns (Controllers/ structure, Constants.swift colors, card pattern)
- [ ] No hardcoded colors (all use Constants.swift)
- [ ] Navigation uses binding-based pattern with `.navigationBarBackButtonHidden(true)`
- [ ] Files organized in correct `Controllers/[Feature]/` subdirectory
- [ ] Navigation between screens works
- [ ] Tested on iPhone SE and iPhone 15 Pro Max sizes
- [ ] ImageFetcher used for async images (not direct AsyncImage)
- [ ] Mock data provided in tempData.swift or inline for previews
- [ ] Documentation added to main view files
- [ ] No force unwrapping (avoid `!` unless absolutely safe)

### Feature Implementation Summary Template

When completing a feature, provide this summary:

```
FEATURE: Ride Details & Booking
STATUS: ✅ Complete

FILES CREATED:
- Controllers/ReserveRide/DetailsPage.swift
- Controllers/ReserveRide/CheckoutView.swift
- Controllers/ReserveRide/Components/RoutePoint.swift
- Controllers/ReserveRide/RideReserved.swift

DESIGN MATCHING:
- ✅ DetailsPage matches ride-details.png
- ✅ CheckoutView matches checkout-flow.png
- ✅ Confirmation matches success-screen.png

REUSED COMPONENTS:
- Models/Constants.swift (colors)
- Views/NavigationButtons.swift (back button)
- Models/ImageFetcher.swift (profile images)
- Standard card pattern (ZStack + Rectangle border)

TESTING:
- ✅ Previews working for all views
- ✅ Tested on iPhone SE & iPhone 15 Pro Max
- ✅ Navigation flow verified: Explore → Details → Checkout → Success
- ✅ All interactive elements functional

NOTES:
- Used existing TripInfo and User models
- Followed project's binding-based navigation pattern
- RoutePoint component is feature-specific (not in Views/)
```

## File Reference Patterns

When referencing code locations:
- `Explore.swift:46-50` - Main ZStack structure
- `User.swift:35-40` - UserManager singleton pattern
- `ScrollCardsView.swift:12` - ViewModel initialization
- `InfiniteScroll.swift` - Pagination and API abstraction
- `NavigationBar.swift` - Bottom tab navigation
- `Constants.swift` - Color palette
