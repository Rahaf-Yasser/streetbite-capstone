<p align="center">
  <img src="assets/images/StreetBite-Logo.png" alt="StreetBite logo" width="160" />
</p>

<h1 align="center">StreetBite</h1>

<p align="center">
  <em>Hyperlocal food discovery, delivered to your fingertips.</em>
</p>

<p align="center">
  <a href="https://flutter.dev"><img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white" /></a>
  <a href="https://dart.dev"><img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white" /></a>
  <a href="https://pub.dev/packages/flutter_bloc"><img alt="flutter_bloc" src="https://img.shields.io/badge/state-flutter__bloc-1E88E5" /></a>
  <a href="https://pub.dev/packages/dio"><img alt="Dio" src="https://img.shields.io/badge/network-Dio-0088CC" /></a>
  <a href="https://firebase.google.com"><img alt="Firebase" src="https://img.shields.io/badge/backend-Firebase-FFCA28?logo=firebase&logoColor=black" /></a>
  <a href="https://pub.dev/packages/google_maps_flutter"><img alt="Google Maps" src="https://img.shields.io/badge/maps-Google%20Maps-34A853" /></a>
</p>

<p align="center">
  StreetBite is a bilingual, biometric-aware Flutter app for discovering meals from <a href="https://www.themealdb.com">TheMealDB</a>, exploring nearby vendors on an interactive map, and managing a personal food profile. It pairs a clean layered architecture with Firebase backend services to deliver a calm, focused discovery experience that respects the user's language, theme, and privacy on every screen.
</p>

---

## Table of Contents

- [About StreetBite](#about-streetbite)
- [Features](#features)
- [Screenshots & App Preview](#screenshots--app-preview)
- [Tech Stack](#tech-stack)
- [Architecture & Engineering](#architecture--engineering)
- [Getting Started](#getting-started)
- [Permissions & Configuration](#permissions--configuration)
- [Localization & Theming](#localization--theming)
- [Project Structure](#project-structure)
- [Team](#team)
- [Beta Distribution & Release Information](#beta-distribution--release-information)
- [Closing](#closing)

---

## About StreetBite

StreetBite is a hyperlocal food discovery and ordering app that turns hunger into wandering. Instead of asking users to know what they want upfront, it invites them to browse curated categories, featured dishes, time-limited offers, and a map of vendors anchored to real Egyptian geographies — a shawarma counter in Cairo, a seafood grill in Alexandria, a koshary stand in Mansoura.

The product tackles friction that haunts most food apps: endless lists with no sense of place, account flows that feel like paperwork, and a single-language assumption that excludes half of a multilingual city. Onboarding takes seconds. Profile access is gated by the device's fingerprint sensor. English and Arabic are first-class citizens that switch in real time and persist between sessions. Light and dark themes follow the same principle — choose once, and StreetBite remembers.

The journey moves from a branded splash into a home feed powered by TheMealDB, where a categories strip, featured carousel, hot-offers rail, and popular-near-you grid sit beneath a real-time search. Tapping any meal opens a focused detail view; a plus chip drops it into the session cart, with a running count in the app bar. A dedicated map plots nearby vendors across Egypt, each marker tuned to its rating. The profile tab — unlocked by fingerprint — combines identity, order history, and account actions into one readable surface.

What distinguishes StreetBite is how the pieces respect each other. Localization is wired through every screen. The data layer treats the network as best-effort, falling back to a local cache when TheMealDB is unreachable. State lives in BLoC cubits and a single cart bloc, so the UI never talks to Firebase or Dio directly. The result is an app that feels cohesive — small enough to understand in an afternoon, structured enough to grow into a real product.

---

## Features

### Authentication & Onboarding

A branded splash fades into a welcome screen offering sign-up and log-in paths. Account creation collects a full name, email, and password with inline validation — capitalization, email format, minimum length, and password confirmation are all enforced before submission. Firebase Authentication backs both flows, and a Firestore document is created at sign-up so the profile is ready for the user's first visit. Returning users land directly in the main shell after a silent session check.

### Meal Discovery

The home screen is the heart of StreetBite. A search bar at the top filters meals by name in real time. Below it, a horizontal category strip pulls live categories from TheMealDB with thumbnail imagery. A featured banner carousel cycles through editorial picks with rating, delivery estimate, and price overlays. A hot-offers rail surfaces discounted dishes with a prominent discount badge. A popular-near-you grid rounds out the page with two columns of meal cards. Pull-to-refresh silently re-fetches from the remote source, with cached data remaining visible during the refresh.

### Meal Details

Tapping any meal — from the grid, the banner, or a hot-offer card — opens a dedicated detail screen built around the dish itself. A pinned sliver app bar expands to reveal the meal image behind a soft gradient scrim, with the meal name anchored below. Category and origin appear as labelled badges, alongside the price and any active discount. The full preparation instructions sit in a bordered card beneath, and a sticky bottom bar offers a single primary action: add to cart.

### Cart & Ordering

Meals can be added to the session cart from anywhere in the discovery feed — the grid card, the banner, the hot-offer rail, and the meal details screen all feed the same cart bloc. The cart screen lists every item with a thumbnail, name, unit price, line total, and quantity stepper that increments or removes items. A payment method selector offers cash-on-delivery and card options, and an order summary breaks down the subtotal, delivery fee, and total. A sticky bottom bar carries the place-order action. The cart icon in the home app bar surfaces the running item count as a badge.

### Nearby Vendor Maps

A dedicated map screen, reachable from the home app bar, plots StreetBite's vendor network across Egypt on an interactive Google Maps canvas. Each marker is colour-coded by rating — green for the highest tier, azure for the middle, orange for the rest — so quality is legible at a glance. Tapping a marker raises an info window and slides up a vendor card with cuisine, city, and rating. A floating action button re-fits the camera to encompass every vendor.

### User Profile

The profile tab is gated by the device's fingerprint sensor: every visit prompts a fresh biometric check, and leaving the tab resets the gate. Once unlocked, the profile displays the user's avatar (with a camera affordance to pick a new photo from the gallery), full name, and email. Below the identity block, an order-history panel reads from a live Firestore stream, followed by a menu of secondary actions — settings, contact, help, and sign-out. A device-information card at the bottom of the page surfaces the running model and OS version.

### Localization

StreetBite ships with full English and Arabic translations, declared as official supported locales and wired through Flutter's generated localization layer. A language toggle on the splash, in settings, and in the home app bar switches between languages instantly. The chosen language is persisted in shared preferences and reloaded before the first frame is drawn, so the app never flashes the wrong locale on cold start. Arabic sessions automatically adopt a right-to-left layout direction across every screen.

### Theme Switching

Light, dark, and system theme modes are cycled by a single tap on the theme icon in the home app bar. A theme bloc tracks the current mode, and the home app bar resolves the effective brightness by combining the explicit mode with the platform brightness when system mode is active. Both light and dark schemes are tuned around StreetBite's green brand palette, with full Material 3 colour roles defined explicitly for each scheme.

### Local Caching & Offline Resilience

TheMealDB responses are cached locally in shared preferences as JSON-encoded meal models. On cold start, the home cubit emits the cached list immediately as a refreshing state, then fetches fresh data from the remote source. If the remote call fails, the repository transparently returns the cached meals alongside a network failure, and the UI continues to function.

---

## Screenshots & App Preview

The gallery below is reserved for genuine in-app screenshots. Each reference resolves automatically once the corresponding image is placed in the `screenshots/` directory at the project root.

<p align="center">
  <img src="screenshots/onboarding.png" alt="Onboarding and welcome screen" width="200" />
  <img src="screenshots/login.png" alt="Login screen" width="200" />
  <img src="screenshots/signup.png" alt="Sign up screen" width="200" />
</p>
<p align="center"><sub>Splash · Login · Sign Up</sub></p>

<p align="center">
  <img src="screenshots/home_en.png" alt="Home feed in English" width="200" />
  <img src="screenshots/home_ar.png" alt="Home feed in Arabic (RTL)" width="200" />
  <img src="screenshots/home_dark.png" alt="Home feed in dark mode" width="200" />
</p>
<p align="center"><sub>Home — English · Arabic (RTL) · Dark mode</sub></p>

<p align="center">
  <img src="screenshots/meal_details.png" alt="Meal details screen" width="200" />
  <img src="screenshots/cart.png" alt="Cart screen" width="200" />
  <img src="screenshots/orders.png" alt="Orders screen" width="200" />
</p>
<p align="center"><sub>Meal details · Cart · Orders</sub></p>

<p align="center">
  <img src="screenshots/vendor_map.png" alt="Nearby vendors map" width="200" />
  <img src="screenshots/profile.png" alt="Profile screen" width="200" />
  <img src="screenshots/biometric.png" alt="Biometric profile unlock" width="200" />
</p>
<p align="center"><sub>Nearby vendors map · Profile · Biometric unlock</sub></p>

---

## Tech Stack

StreetBite is built on a focused Flutter stack. Each technology below earns its place by solving a concrete problem in the app.

- **Flutter & Dart** — the application framework and language powering every screen. Material 3 is enabled throughout, with a custom theme layer providing both light and dark schemes.
- **flutter_bloc** — the state-management backbone. Cubits manage authentication, locale, theme, biometrics, profile, order history, the home feed, and the vendor map; a single BLoC owns the in-memory cart.
- **Dio** — the HTTP client. A singleton Dio client configures base URLs, timeouts, and JSON headers once; remote data sources for meals and categories depend on it without re-implementing configuration.
- **Firebase Authentication** — handles email-password sign-up, sign-in, and sign-out, and provides the signed-in user identity that scopes every Firestore read.
- **Cloud Firestore** — the document store for user profiles and orders. A thin Firestore service wraps document and collection reads, including live streams that keep the profile and order history reactive.
- **shared_preferences** — used for two purposes: persisting the user's chosen language between sessions, and caching TheMealDB responses as JSON-encoded meals for offline resilience.
- **GetIt** — the dependency-injection container. A single setup function registers network, Firebase, data sources, repositories, use cases, and cubits.
- **google_maps_flutter** — powers the nearby-vendors map, with custom marker hues, info windows, and animated camera bounds.
- **local_auth** — drives the biometric fingerprint check that gates profile access, with comprehensive error mapping for unavailable, unenrolled, and locked-out states.
- **image_picker** — opens the device gallery to select a profile photo, with size and quality limits tuned to fit comfortably inside a Firestore document.
- **device_info_plus** — surfaces the running device model and OS version in the profile.
- **google_fonts** — loads the Inter typeface for both display and body text.
- **equatable** — underpins value equality across entities, models, and bloc states.

---

## Architecture & Engineering

StreetBite follows a layered clean architecture that keeps the application's intent in the domain layer and the technical details in the data layer. The presentation layer talks to the domain through use cases; the domain defines repository contracts that the data layer implements.

### Layered Structure

- **Domain layer** — pure Dart, with no Flutter or third-party dependencies. Entities model the core concepts of the product (Meal, Category, Vendor, Profile, Order, CartItem, BiometricResult, DeviceDetails). Repository contracts declare what the application needs — fetch meals, watch profile, watch orders, fetch vendors, fetch categories, authenticate with biometrics, pick and update a profile photo, read device details. Use cases turn each repository capability into a single callable class.
- **Data layer** — implements the repository contracts against real backends. Remote data sources wrap Dio for TheMealDB and FirebaseAuth plus Firestore for the user-facing services. A local data source reads and writes the meal cache through shared preferences. Models handle JSON serialization and map between the wire format and domain entities.
- **Presentation layer** — Flutter widgets, screens, and BLoC cubits. Each screen is a thin composition of widgets that read state from a cubit and dispatch intents back. Widgets are split into reusable building blocks under a dedicated widgets directory, with feature-specific subdirectories for home and vendor-map components.

### State Management

flutter_bloc is used uniformly. Cubits manage streams of state for authentication, locale, theme, biometrics, the home feed, categories, profile, order history, and the vendor map. A single BLoC — the cart bloc — owns the cart, demonstrating the appropriate use of events where the action surface may grow. All states derive from Equatable, and bloc builders use `buildWhen` to skip rebuilds when irrelevant fields change.

### Dependency Injection

A single setup function in the injection file registers every dependency through GetIt at app start. Infrastructure classes — Dio, FirebaseAuth, the Firestore service, shared preferences, the local authentication plugin, the image picker, and the device-info plugin — are registered as lazy singletons. Repositories and use cases follow the same pattern. Cubits that hold transient state are registered as factories, so a fresh instance is created each time one is requested by a screen.

### Repository and Data-Source Abstractions

Each repository contract in the domain layer has a single implementation in the data layer backed by one or more data sources. The meal repository is the most expressive example: it depends on a meal data-source factory that can produce either a remote or a local data source. On a successful remote fetch, the repository caches the result before returning. On a remote failure, the repository reads the cache and returns the cached meals alongside a network failure — so the UI can keep rendering.

### Models and Serialization

Models extend their corresponding domain entities and add JSON factories and serialization methods. The meal model parses TheMealDB's wire format into a stable internal shape, derives a deterministic price and discount percentage from the meal id, and serializes back to a JSON map for cache storage. The order model carries an items list and a payment-method value object, serializing timestamps as Firestore `Timestamp` values.

### Design Patterns

The patterns in StreetBite are visible in the code, not just in the folder names. The Dio client and the Firestore service both expose a single shared instance through a private constructor and a factory getter — the singleton pattern. The meal data-source factory chooses between the remote and local data sources at runtime — the factory pattern in the classic GoF sense. The user builder assembles a user model step by step and validates required fields before construction — the builder pattern. The payment-method hierarchy models cash and card as interchangeable implementations of a single interface — the strategy pattern.

### Error Handling

Errors are modelled explicitly. The data layer throws typed exceptions — `ApiException` for network and parsing failures, `CacheException` for storage failures — and the repository layer catches them and converts them into typed failures (network, cache, server, unknown). Use cases return both the data and an optional failure as a record, so the presentation layer can decide how to render the result. Biometric errors are similarly mapped to a result enum that the cubit translates into a localized snackbar message.

### Caching and Persistence

Two persistence surfaces are wired through the app. The first is shared preferences, used for the user's chosen language and the JSON-encoded meal cache. The second is Firestore, used for the user's profile document and orders collection. Both surfaces are wrapped behind repository contracts so the presentation layer never knows which store it is reading from.

---

## Getting Started

StreetBite is a standard Flutter project and runs on any developer machine with a working Flutter SDK. The steps below describe the setup in plain language; consult the Flutter documentation for platform-specific tooling if any step is unfamiliar.

A recent stable Flutter SDK and the matching Dart SDK are required. An Android or iOS emulator, or a physical device in developer mode, is needed to run the app; the vendor map requires Google Play services on Android.

After cloning the repository, fetch the project's Dart dependencies through your usual Flutter workflow. The project's dependency list is declared in the standard pubspec file at the project root and resolves through pub.

Firebase configuration is required before the app can sign users in or read profile data. Create a Firebase project, enable Email/Password authentication, and enable Cloud Firestore. Register an Android application and an iOS application in the Firebase console, then place the platform-specific Firebase configuration files — the Android Google services descriptor in the android app module, and the iOS Google services plist inside the iOS runner — at the locations documented by Firebase. The Firestore security rules should permit authenticated users to read and write their own user document and the orders subcollection under it.

Google Maps integration requires an API key with the Maps SDK enabled for both Android and iOS. Add the Android key to the Android manifest under the application tag, referencing the Maps API key metadata entry, and add the iOS key to the iOS information property list under the Google Maps API key entry. The Google Cloud console is the source of truth for the keys themselves; never commit real keys to the repository.

With Firebase and Google Maps configured, run the app on a target device or emulator. The first launch should resolve dependencies, build the native shells, and present the splash screen. Sign up a new account to confirm that Firebase Authentication is wired correctly, then open the profile tab to verify the biometric prompt on devices with enrolled fingerprints.

The TheMealDB integration requires no API key — the public endpoints used by StreetBite are open and require no configuration.

---

## Permissions & Configuration

StreetBite requests the following device capabilities. Each permission is tied to a concrete feature; none are requested speculatively.

- **Biometric authentication** — requested when the user taps the profile tab or the profile icon in the app bar. The app checks for device support and enrolled biometrics before invoking the prompt, and surfaces a localized message if either is missing. The check is fingerprint-only by design; face or iris authentication is not requested.
- **Gallery access** — requested when the user taps the camera affordance on the profile avatar. The image picker opens the device gallery with a maximum dimension and quality cap, so the resulting photo fits comfortably inside a Firestore document.
- **Internet access** — required for TheMealDB, Firebase Authentication, and Cloud Firestore. On Android, this is declared in the manifest; on iOS, it is implied and enforced by the system.
- **Location** — the Google Maps canvas does not request the user's live location; the map is centred on a fixed initial target and on the vendor bounds. Location permission is therefore not requested.
- **Google Maps API key** — a platform-specific configuration value, required for the vendor map to render.
- **Firebase configuration files** — the Android Google services descriptor and the iOS Google services plist, both generated by the Firebase console.

---

## Localization & Theming

StreetBite is bilingual. English and Arabic are declared as supported locales in the application configuration, and the official Flutter localization tooling generates the `AppLocalizations` class from the two locale files in the localization directory. Every user-facing string — from the welcome headline to the biometric error messages, the meal detail labels, the cart summary, and the bottom navigation items — is keyed and translated, so no untranslated English leaks into an Arabic session.

The active locale is held in a locale cubit and persisted to shared preferences on every change. On app start, the saved locale is loaded before the first frame is drawn, so the app never briefly renders English before switching to Arabic. A language toggle is available in three places — the splash, the home app bar, and the settings screen — and switching between languages takes effect immediately across every open screen. Arabic sessions automatically adopt a right-to-left layout direction; widgets that use directional-aware positioning flip correctly, including the language toggle on the splash and the camera button on the profile avatar.

Theming follows the same philosophy. A theme bloc tracks the current theme mode — light, dark, or system — and a single tap on the theme icon in the home app bar cycles through them. The home app bar resolves the effective brightness by combining the explicit mode with the platform brightness when system mode is active. Both light and dark schemes are built on StreetBite's green brand palette and define the full Material 3 colour surface hierarchy — surface containers, primary containers, secondary containers, and tonal variants — so every widget picks up the right tone for the right context.

---

## Project Structure

The repository is organized around the layered architecture described above. The high-level shape is:

```
lib/
├── main.dart                  Application entry, providers, routes
├── injection.dart             GetIt dependency graph
├── core/                      Cross-cutting infrastructure
│   ├── constants/             API endpoints and storage keys
│   ├── errors/                Typed exceptions and failures
│   ├── l10n/                  Localization extensions
│   ├── navigation/            Shared route transitions
│   ├── network/               Dio singleton client
│   ├── services/              Firestore and locale-preference services
│   ├── theme/                 Material 3 light and dark schemes
│   └── utils/                 Validators and biometric message helpers
├── data/                      Data layer: models, sources, repositories
│   ├── datasources/           Remote, local, and platform data sources
│   ├── models/                JSON-serializable model classes
│   └── repositories/          Repository implementations
├── domain/                    Domain layer: pure business rules
│   ├── entities/              Value entities (Meal, Vendor, Profile, …)
│   ├── repositories/          Repository contracts
│   └── usecases/              Single-purpose use-case classes
├── l10n/                      Generated English and Arabic localization classes
└── presentation/              UI layer
    ├── blocs/                 Cubits and BLoCs by feature area
    ├── screens/               Route-level screens
    └── widgets/               Reusable widgets and feature components
```

Each layer has a single responsibility. `core` holds infrastructure shared across the app. `data` knows about the wire and the device. `domain` knows about the product. `presentation` knows about Flutter. The dependency direction is strictly inward — `presentation` may depend on `domain`, `domain` depends on nothing, and `data` implements `domain`.

---

## Team

StreetBite is a collaborative product built by a three-person team.

<p align="center">
  <strong>Rahaf</strong> &nbsp;·&nbsp; <strong>Reem</strong> &nbsp;·&nbsp; <strong>Jana</strong>
</p>

Each member contributed across design, engineering, and product decisions, shaping StreetBite into a cohesive application rather than a collection of separately-built parts.

---

## Beta Distribution & Release Information

StreetBite is built for iOS and Android. This section is reserved for distribution material — Firebase App Distribution builds, reviewer lists, and store listings.

---

## Closing

StreetBite is a small app with a deliberate shape. It treats language, theme, and privacy as first-class concerns, builds its screens on a clean layered architecture, and lets the data layer absorb the friction of an unreliable network so the UI never has to. Built collaboratively by Rahaf, Reem, and Jana, it is both a portfolio piece and a foundation — a calm mobile food experience that respects its users enough to remember their language, gate their profile, and keep working when the network drops.
