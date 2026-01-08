# SKILLS.md

This document outlines coding standards, best practices, and architectural patterns for the StuGo iOS app.

## SwiftUI Best Practices

### View Composition and Structure

**Keep Views Small and Focused**
```swift
// ✅ GOOD: Single responsibility
struct RideCardView: View {
    let ride: TripInfo
    let onReserve: (TripInfo) -> Void

    var body: some View {
        CardContainer {
            RideDetails(ride: ride)
            ReserveButton(action: { onReserve(ride) })
        }
    }
}

// ❌ BAD: Massive view doing everything
struct ExploreRides: View {
    var body: some View {
        // 500+ lines of nested views
    }
}
```

**Extract Reusable Components**
- Place shared components in `Views/` directory
- Use `ViewBuilder` for flexible composition
- Follow existing patterns: `NavigationBar`, `CustomTextFieldStyle`, radio buttons

**Prefer Composition Over Inheritance**
```swift
// ✅ GOOD: Composition with protocols
protocol CardViewProtocol: View {
    var cardContent: some View { get }
}

// ❌ BAD: SwiftUI views cannot inherit
class BaseCardView: View { } // This won't work
```

### State Management

**Choose the Right Property Wrapper**

| Wrapper | Use Case | Example |
|---------|----------|---------|
| `@State` | Local UI state | `@State private var showCalendar = false` |
| `@Binding` | Child view receives parent's state | `init(isRideOffer: Binding<Bool>)` |
| `@StateObject` | View owns the ViewModel lifecycle | `@StateObject var viewModel = InfiniteScroll()` |
| `@ObservedObject` | View observes but doesn't own | `@ObservedObject var userManager: UserManager` |
| `@EnvironmentObject` | Shared state across view hierarchy | Not currently used in this project |

**State Management Guidelines**

```swift
// ✅ GOOD: Private state, clear ownership
struct ExploreRides: View {
    @State private var showCalendar = false
    @State private var selectedDate = Date()
    @StateObject private var viewModel = InfiniteScroll()

    var body: some View { ... }
}

// ❌ BAD: Public state, unclear ownership
struct ExploreRides: View {
    @State var showCalendar = false  // Should be private
    var selectedDate = Date()         // Should be @State
}
```

**Single Source of Truth**
```swift
// ✅ GOOD: Parent owns state, child receives binding
struct ParentView: View {
    @State private var isRideOffer = true

    var body: some View {
        ToggleView(isRideOffer: $isRideOffer)
        ScrollCardsView(isRideOffer: $isRideOffer)
    }
}

// ❌ BAD: Duplicated state in multiple views
struct ChildView: View {
    @State private var isRideOffer = true  // Duplicate state!
}
```

### Singleton Pattern for Global State

**Use UserManager Pattern**
```swift
// ✅ GOOD: Following project pattern (User.swift:35-40)
class UserManager: ObservableObject {
    static let shared = UserManager()
    @Published var user: User
    private init() {}
}

// Usage in views:
@StateObject var userManager = UserManager.shared

// ❌ BAD: Creating multiple instances
@StateObject var userManager = UserManager()  // Breaks singleton!
```

**When to Use Singletons**
- Global user session (UserManager)
- App-wide settings
- Network client (when implemented)

**When NOT to Use Singletons**
- Feature-specific state
- Screen-specific ViewModels
- Temporary UI state

## MVC/MVVM Architecture

### Model Layer

**Data Models**
```swift
// ✅ GOOD: Conform to necessary protocols
struct User: Identifiable, Decodable, Equatable, Encodable {
    var id: Int
    var name: String
    // ... properties

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

// ❌ BAD: Missing essential protocols
struct User {
    var name: String
    // Can't use in List, can't decode from JSON
}
```

**Model Guidelines**
- Keep models in `Models/` directory
- Models should be pure data structures (no business logic)
- Conform to `Identifiable` for use in lists
- Conform to `Decodable/Encodable` for API integration
- Implement `Equatable` for comparison operations

### ViewModel Layer

**ObservableObject ViewModels**
```swift
// ✅ GOOD: ViewModel with clear responsibilities
class InfiniteScroll: ObservableObject {
    @Published var rideCards: [TripInfo] = []
    @Published var isLoading: Bool = false

    private var currentPage = 1
    private var hasMoreData = true

    func fetchRideCards() async {
        guard !isLoading && hasMoreData else { return }
        isLoading = true
        // API call
        isLoading = false
    }
}

// ❌ BAD: ViewModel doing too much
class InfiniteScroll: ObservableObject {
    @Published var rideCards: [TripInfo] = []
    @Published var userProfile: User = User(...)  // Wrong layer
    @Published var navigationState: Bool = false  // View concern

    func saveToDatabase() { }      // Persistence logic
    func updateUI() { }             // UI logic
}
```

**ViewModel Best Practices**
- One ViewModel per major feature/screen
- Publish only data that views need to observe
- Keep private state for internal logic
- Handle async operations (API calls, data loading)
- No direct UIKit/SwiftUI references

### View Layer (Controllers)

**SwiftUI View Organization**
```swift
// ✅ GOOD: Well-organized view
struct ExploreRides: View {
    // 1. State and bindings
    @State private var selectedDate = Date()
    @StateObject private var viewModel = InfiniteScroll()

    // 2. Computed properties
    var formattedDate: String {
        selectedDate.formatted()
    }

    // 3. Body
    var body: some View {
        NavigationStack {
            mainContent
        }
    }

    // 4. View builders for complex layouts
    @ViewBuilder
    private var mainContent: some View {
        VStack {
            header
            scrollContent
        }
    }

    // 5. Helper methods
    private func handleSelection(_ trip: TripInfo) {
        // Handle logic
    }
}

// ❌ BAD: Disorganized, unclear structure
struct ExploreRides: View {
    var body: some View { ... }
    @State var x = 1
    func foo() { }
    var computed: Int { 5 }
    @State var y = 2
}
```

## Navigation Patterns

### Declarative Navigation with NavigationStack

**Follow Project Pattern**
```swift
// ✅ GOOD: Binding-based navigation (Explore.swift:10-24)
struct ExploreRides: View {
    @State private var NavHome = false
    @State private var NavProfile = false
    @State private var showDetails = false

    var body: some View {
        NavigationStack {
            content
                .navigationDestination(isPresented: $showDetails) {
                    DetailsPage()
                }
                .navigationBarBackButtonHidden(true)
        }
    }
}

// ❌ BAD: NavigationLink with tag (old pattern)
NavigationLink(destination: DetailsPage(), tag: 1, selection: $selection) {
    Text("View")
}
```

**Navigation Guidelines**
- Use `@State` for navigation flags
- One `navigationDestination` per destination
- Always hide back button: `.navigationBarBackButtonHidden(true)`
- Avoid nested NavigationStacks
- Use custom back buttons for branded experience

**Bottom Tab Navigation**
```swift
// ✅ GOOD: Using NavigationBar.swift pattern
NavigationBar(
    NavHome: $NavHome,
    NavCommunity: $NavCommunity,
    NavProfile: $NavProfile
)
.navigationDestination(isPresented: $NavHome) { ExploreRides() }
.navigationDestination(isPresented: $NavCommunity) { GroupView() }
.navigationDestination(isPresented: $NavProfile) { ProfilePageView() }
```

## API and Networking

### Async/Await Pattern

**Follow Project Pattern**
```swift
// ✅ GOOD: Async with error handling (Explore.swift:205-224)
func fetchRideCount(for date: Date) async -> Int {
    guard let url = URL(string: "https://api.example.com/rides?date=\(date)") else {
        return 0  // Graceful degradation
    }

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let count = try? JSONDecoder().decode(Int.self, from: data) {
            return count
        }
        return 0
    } catch {
        print("Error fetching rides: \(error)")
        return 0
    }
}

// ❌ BAD: Completion handlers (old pattern)
func fetchRideCount(completion: @escaping (Int) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, _ in
        // Nested callbacks
    }.resume()
}
```

**API Call Guidelines**
- Use async/await (not completion handlers)
- Always provide fallback values on error
- Decode with `JSONDecoder` for type safety
- Update `@Published` properties on main thread
- Log errors for debugging (use `print` or logging framework)

**Generic Fetch Pattern**
```swift
// ✅ GOOD: Reusable generic fetch (InfiniteScroll.swift pattern)
func fetchData<T: Decodable>(from url: URL) async throws -> T {
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode(T.self, from: data)
}

// Usage:
let rides: [TripInfo] = try await fetchData(from: url)
```

### API Development with Mock Data

**During Development**
```swift
// ✅ GOOD: Use tempData.swift for development
import Foundation

let mockRides = [
    TripInfo(id: 1, driver: mockDriver, ...),
    TripInfo(id: 2, driver: mockDriver2, ...)
]

// In ViewModel init:
self.rideCards = mockRides  // Use mock data

// ❌ BAD: Hardcoded in view
var body: some View {
    List {
        RideCardView(ride: TripInfo(id: 1, ...))  // Don't do this
    }
}
```

## UI Consistency and Design Patterns

### Use Constants for Colors

**Always Use Constants.swift**
```swift
// ✅ GOOD: Using color constants
Button("Reserve") {
    action()
}
.foregroundColor(Constants.blue)
.background(Constants.highlighterYellow)

// ❌ BAD: Hardcoded colors
Button("Reserve") {
    action()
}
.foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.8))
```

**Project Color Palette**
- `Constants.blue` - Primary actions, links
- `Constants.warmYellow` - Profile backgrounds
- `Constants.highlighterYellow` - CTA buttons, important actions
- `Color.black` - Text, borders
- `Color.white` - Backgrounds, cards

### Card Design Pattern

**Follow Consistent Card Structure**
```swift
// ✅ GOOD: Standard card pattern (RideCardView.swift)
ZStack {
    Rectangle()
        .fill(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 1.5)
        )

    VStack(alignment: .leading, spacing: 12) {
        // Card content
    }
    .padding()
}
.frame(width: 350, height: 220)

// ❌ BAD: Inconsistent card styling
VStack {
    // No container, different sizes, inconsistent borders
}
.background(Color.gray)
.cornerRadius(5)
```

### Reusable Components

**Create Components in Views/ Directory**
```swift
// Create: Views/CustomButton.swift
struct CustomButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Constants.blue)
                .cornerRadius(10)
        }
    }
}

// Use throughout app:
CustomButton(title: "Reserve") {
    handleReservation()
}
```

## Code Organization

### File Naming Conventions

- Views: `FeatureNameView.swift` (e.g., `RideCardView.swift`, `ProfilePageView.swift`)
- ViewModels: `FeatureViewModel.swift` or `FeatureModel.swift` (e.g., `TextFieldViewModel.swift`)
- Models: `EntityName.swift` (e.g., `User.swift`, `TripInfo.swift`)
- Reusable components: `ComponentName.swift` (e.g., `NavigationBar.swift`)

### Directory Organization

**Place Files in Correct Directories**
```
Controllers/FeatureName/    - Feature-specific views
Models/                     - Data models and ViewModels
Views/                      - Reusable UI components
Assets.xcassets/           - Images, colors, icons
```

### Import Organization

```swift
// ✅ GOOD: Organized imports
import SwiftUI
import Foundation
import Combine

// ❌ BAD: Unnecessary imports
import UIKit        // Only if you actually use UIKit
import CoreData     // Only if you use CoreData
```

## Performance Best Practices

### Avoid Expensive Operations in Body

```swift
// ✅ GOOD: Computed property or @State
struct ExploreRides: View {
    @State private var formattedDate: String = ""

    var body: some View {
        Text(formattedDate)
            .onAppear {
                formattedDate = formatDate(Date())
            }
    }
}

// ❌ BAD: Heavy computation in body
var body: some View {
    Text(performExpensiveCalculation())  // Called every render!
}
```

### Lazy Loading with ScrollView

```swift
// ✅ GOOD: LazyVStack for large lists
ScrollView {
    LazyVStack {
        ForEach(viewModel.rideCards) { ride in
            RideCardView(ride: ride)
                .onAppear {
                    viewModel.loadMoreIfNeeded(ride)
                }
        }
    }
}

// ❌ BAD: VStack loads all views immediately
ScrollView {
    VStack {
        ForEach(viewModel.rideCards) { ride in
            RideCardView(ride: ride)  // All 1000 cards rendered!
        }
    }
}
```

### Image Loading

**Use ImageFetcher for Async Images**
```swift
// ✅ GOOD: Using project's ImageFetcher pattern
struct ProfileImage: View {
    @StateObject private var imageFetcher = ImageFetcher()
    let url: String

    var body: some View {
        Group {
            if let image = imageFetcher.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageFetcher.loadImage(from: url)
        }
    }
}
```

## Testing Considerations

### Testable Architecture

**Structure Code for Testing**
```swift
// ✅ GOOD: Testable ViewModel
class InfiniteScroll: ObservableObject {
    @Published var rideCards: [TripInfo] = []

    // Dependency injection for testing
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient = URLSession.shared) {
        self.networkClient = networkClient
    }

    func fetchRideCards() async {
        // Testable logic
    }
}

// ❌ BAD: Hard to test
class InfiniteScroll: ObservableObject {
    func fetchRideCards() async {
        let data = try! await URLSession.shared.data(from: url)  // Can't mock!
    }
}
```

### Preview Providers

**Always Provide Previews**
```swift
// ✅ GOOD: Useful preview with mock data
#Preview {
    RideCardView(
        ride: TripInfo(
            id: 1,
            driver: mockDriver,
            from: "Campus",
            to: "Airport",
            date: Date(),
            price: 25.0
        ),
        onReserve: { _ in print("Reserved") }
    )
}

// ❌ BAD: No preview or broken preview
#Preview {
    RideCardView()  // Missing required parameters!
}
```

## Common Pitfalls to Avoid

### 1. Retain Cycles with Closures

```swift
// ✅ GOOD: Weak self in closures
class InfiniteScroll: ObservableObject {
    func fetchData() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            self?.processData(data)
        }.resume()
    }
}

// ❌ BAD: Strong reference cycle
func fetchData() {
    URLSession.shared.dataTask(with: url) { data, _, _ in
        self.processData(data)  // Retain cycle!
    }.resume()
}
```

### 2. Updating UI on Background Thread

```swift
// ✅ GOOD: Update @Published on main thread
func fetchRideCards() async {
    let data = try await fetchData()
    await MainActor.run {
        self.rideCards = data
    }
}

// Or with async/await:
@MainActor
func updateUI(with data: [TripInfo]) {
    self.rideCards = data
}

// ❌ BAD: Background thread update
func fetchRideCards() {
    URLSession.shared.dataTask(with: url) { data, _, _ in
        self.rideCards = decode(data)  // Crash! Not on main thread
    }.resume()
}
```

### 3. Massive View Files

```swift
// ✅ GOOD: Extract subviews
struct ExploreRides: View {
    var body: some View {
        VStack {
            HeaderView()
            ContentView()
            FooterView()
        }
    }
}

// ❌ BAD: Everything in one body
struct ExploreRides: View {
    var body: some View {
        VStack {
            // 500 lines of nested views
        }
    }
}
```

### 4. Overusing @EnvironmentObject

```swift
// ✅ GOOD: Use singleton for global state
@StateObject var userManager = UserManager.shared

// ❌ BAD: @EnvironmentObject without injection
@EnvironmentObject var userManager: UserManager  // Where's it injected?
```

### 5. Force Unwrapping

```swift
// ✅ GOOD: Safe unwrapping
guard let url = URL(string: urlString) else {
    return 0
}

if let image = imageFetcher.image {
    return Image(uiImage: image)
}

// ❌ BAD: Force unwrapping
let url = URL(string: urlString)!  // Will crash on invalid URL
let image = imageFetcher.image!    // Will crash if nil
```

## Code Review Checklist

Before submitting code, verify:

- [ ] Views are small and focused (< 200 lines)
- [ ] State management uses correct property wrapper (@State, @Binding, @StateObject)
- [ ] Colors use Constants.swift (no hardcoded colors)
- [ ] Cards follow standard ZStack + Rectangle pattern
- [ ] Navigation uses binding-based pattern with `.navigationBarBackButtonHidden(true)`
- [ ] API calls use async/await (not completion handlers)
- [ ] Error handling provides graceful fallbacks
- [ ] No force unwrapping (no `!` unless absolutely necessary)
- [ ] Images loaded asynchronously with ImageFetcher
- [ ] UI updates on main thread (@MainActor or await MainActor.run)
- [ ] Preview provider included for views
- [ ] Imports are minimal and necessary
- [ ] Files placed in correct directory (Controllers, Models, or Views)
- [ ] Naming follows convention (ViewName.swift, ViewModelName.swift)

## Additional Resources

- **Apple SwiftUI Documentation**: https://developer.apple.com/documentation/swiftui
- **Swift API Design Guidelines**: https://swift.org/documentation/api-design-guidelines/
- **WWDC SwiftUI Sessions**: Search "SwiftUI" on developer.apple.com

## Questions and Improvements

If you identify patterns that should be added to this guide or notice inconsistencies in the codebase, document them and discuss with the team.
