import SwiftUI

#Preview("Main View") {
    ContentView()
        .environmentObject({
            let store = TibberStore()
            store.priceData = DemoData.priceData
            store.apiToken = "demo"
            return store
        }())
}

#Preview("Loading") {
    ContentView()
        .environmentObject({
            let store = TibberStore()
            store.isLoading = true
            store.apiToken = "demo"
            return store
        }())
}

#Preview("Setup") {
    ContentView()
        .environmentObject(TibberStore())
}

#Preview("Chart Only") {
    let entries = DemoData.priceData.today
    StatefulPreviewWrapper(Int?.none) { selection in
        PriceChartView(
            entries: entries,
            minPrice: entries.map(\.total).min() ?? 0,
            maxPrice: entries.map(\.total).max() ?? 1,
            selectedIndex: selection
        )
        .frame(height: 80)
        .padding()
    }
}

/// Small helper to give `#Preview` a mutable binding.
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> Content

    init(_ initial: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initial)
        self.content = content
    }

    var body: some View { content($value) }
}
