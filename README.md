# Vibe - Music Streaming Client

Vibe is a cross-platform music streaming client built with Flutter. It utilizes a FastAPI backend for data management, Supabase for authentication, and local caching strategies to provide a responsive user experience.

---

## Technical Stack

- **Frontend Framework:** Flutter & Dart
- **State Management:** Flutter Riverpod (with compile-time code generation)
- **Audio Playback:** JustAudio & JustAudio Background
- **Local Caching:** Hive
- **Backend Framework:** FastAPI & SQLModel
- **Authentication & Database:** Supabase (Authentication) & PostgreSQL
- **Media Storage:** Cloudinary

---

## Key Features

- **Google Authentication:** Secure user sign-in and session persistence managed via Supabase.
- **Audio Engine:** Gapless playback, background service integration, and progress monitoring using JustAudio.
- **Waveform Visualization:** Interactive scrubbers rendering audio waveforms during playback.
- **Dynamic Search:** Debounced search queries targeting song names, artists, and metadata tags.
- **Offline Caching:** Local persistence of recently played tracks using a local key-value store (Hive).
- **Favorites System:** Toggling and syncing of track favorite states with the remote database.
- **Media Upload:** Direct audio and thumbnail uploads to Cloudinary storage.

---

## Architecture

The project follows clean architecture principles, separating layers into:

- **Core:** App-wide services (API, Supabase, Caching), design systems, themes, and global constants.
- **Features:** Modular structures (Auth, Home, Music, Search, Library) containing distinct Models, Views (Pages & Widgets), and ViewModels/Notifiers.

---

## Media & Visual Demonstrations

### Screenshots

<!-- Add screenshots here (e.g., Home Screen, Music Player, Search Grid, Library) -->
<!-- Example layout below: -->

|          Home Screen           |           Music Player           |           Search Page            |
| :----------------------------: | :------------------------------: | :------------------------------: |
| [Placeholder: Home Screenshot] | [Placeholder: Player Screenshot] | [Placeholder: Search Screenshot] |

### Video Demonstration

<!-- Add a link or embed a video demonstration of the app in action -->
<!-- Example layout below: -->

[Link to video demonstration / Walkthrough]

---

## Getting Started

### Prerequisites

- Flutter SDK (v3.12.0 or newer recommended)
- Dart SDK (v3.11.3 or newer)
- A running instance of the Vibe FastAPI backend

### Installation

1.  Clone the repository:

    ```bash
    git clone https://github.com/GalaxyPhoenix716/Vibe.git
    cd vibe
    ```

2.  Initialize dependency packages:

    ```bash
    flutter pub get
    ```

3.  Configure Environment Variables:
    Create a `.env` file in the project root folder and specify the configuration parameters:

    ```env
    BACKEND_URL=your_backend_api_url
    SUPABASE_URL=your_supabase_project_url
    SUPABASE_PUBLISHABLE_KEY=your_supabase_anon_key
    ```

4.  Generate Code Bindings:
    Compile the Riverpod annotation files:

    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

5.  Run the application:
    ```bash
    flutter run
    ```
