# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

This is a pure Xcode project — there is no package manager, no `Makefile`, and no test suite. All building happens in Xcode or via `xcodebuild`.

```bash
# Build the Watch App target (simulator)
xcodebuild -project TibberWatch.xcodeproj \
  -scheme "TibberWatch Watch App" \
  -destination "platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)" \
  build

# Build both targets at once (clean)
xcodebuild -project TibberWatch.xcodeproj \
  -scheme "TibberWatch Watch App" \
  -destination "platform=watchOS Simulator,name=Apple Watch Series 9 (45mm)" \
  clean build
```

For day-to-day development, open `TibberWatch.xcodeproj` in Xcode and run the **TibberWatch Watch App** scheme on a watchOS simulator or a paired physical watch.

## Architecture

Two Xcode targets share a single project:

| Target | Entry point | Purpose |
|--------|-------------|---------|
| `TibberWatch Watch App` | `TibberWatchApp.swift` | The standalone watch app |
| `TibberComplication` | `TibberComplication.swift` | WidgetKit extension for watch face complications |

### Data flow

```
TibberAPIService          →  TibberStore              →  ContentView / PriceChartView
(GraphQL POST, async)        (@MainActor ObservableObject)  (SwiftUI views)
                                    ↓
                          saveComplicationData()
                                    ↓
                    UserDefaults(suiteName: "group.com.mtbsteve.tibberwatch")
                                    ↑ shared App Group ↑
                          TibberPriceProvider
                          (WidgetKit timeline, refreshes every 15 min)
```

- **`TibberStore`** is the single source of truth. Token persisted via `@AppStorage("tibber_api_token")`. Auto-refreshes every 15 minutes after a successful fetch; cancels on error.
- **`TibberAPIService`** posts a GraphQL query to `https://api.tibber.com/v1-beta/gql` requesting `QUARTER_HOURLY` resolution (96 slots/day for today + tomorrow).
- **`Models.swift`** is compiled into **both** targets (shared via target membership, not duplicated). It contains `PriceLevel`, `PriceEntry`, `PriceData`, `PriceLevel.displayColorHex`, and `Color(hexValue:)`.
- The complication reads `complication_price`, `complication_level`, and `complication_currency` keys from the shared `UserDefaults` suite written by `TibberStore.saveComplicationData()`.

### Screen flow (`ContentView`)

```
ContentView
  ├── TokenSetupView     — no token stored (apiToken == "")
  ├── LoadingView        — token set, first fetch in progress
  ├── ErrorView          — fetch failed, no cached data (shows token diagnostics)
  └── PriceMainView      — data available
        ├── PriceChartView     — 96-bar quarter-hourly chart
        ├── PriceLegendView    — hour markers (00/06/12/18/24)
        ├── PriceMinMaxLabels
        ├── CurrentPriceCard   — current 15-min slot, colour-coded
        ├── statsRow           — Min/Avg/Max scoped to displayed day
        └── dayToggle          — switches today ↔ tomorrow (only if tomorrow data exists)
```

Demo mode is triggered by setting `apiToken = "demo"`; `DemoData.priceData` is substituted instead of a real fetch.

## Key constants

| Constant | Value | Where |
|----------|-------|-------|
| App Group ID | `group.com.mtbsteve.tibberwatch` | `TibberStore.appGroupID`, `TibberComplication.swift` line 33 |
| Tibber GraphQL endpoint | `https://api.tibber.com/v1-beta/gql` | `TibberAPIService.endpoint` |
| Price resolution | `QUARTER_HOURLY` (96 slots/day) | GraphQL query in `TibberAPIService` |
| Auto-refresh interval | 15 minutes | `TibberStore.startAutoRefresh()` |
| Complication refresh | 15 minutes | `TibberPriceProvider.getTimeline()` |
| Deployment target | watchOS 10.0 | Xcode project settings |

## Gotchas

- **`Models.swift` target membership**: it must be ticked for **both** `TibberWatch Watch App` and `TibberComplication`. Never add a second copy of the file — share via target membership only.
- **App Group must match exactly** in both entitlement files and in both Swift constants. A mismatch silently breaks the complication (it shows `--`).
- **`WidgetCenter.shared.reloadAllTimelines()`** is called after every successful price fetch — this is how the complication stays current without waiting for its own 15-minute WidgetKit cycle.
- **ISO 8601 date parsing** uses two passes: first with `.withFractionalSeconds`, then without. Tibber sends `2026-04-24T10:00:00.000+02:00`; a single-pass formatter fails on timestamps that lack fractional seconds.
- **Token sanitisation** in `TokenSetupView` strips smart quotes, en-dashes, em-dashes, control characters, and whitespace before saving — autocorrect frequently mangles pasted tokens.
- **Tibber tokens are exactly 43 characters**. The `ErrorView` shows length + first/last chars + hex bytes to help diagnose token corruption without leaving the watch.
- The `CFPrefs daemon` log noise (`Couldn't read values in CFPrefsPlistSource…`) is harmless system output from the App Group `UserDefaults` setup.
