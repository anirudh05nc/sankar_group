# Task Management App

**GitHub Repository:** [anirudh05nc/sankar_group](https://github.com/anirudh05nc/sankar_group)

A robust Task Management Flutter application integrated with Firebase, Riverpod for state management, and a dynamic quotes API.

## Features
- **Firebase Authentication**: Secure login and sign-up flows, including Google Sign-In.
- **Task Management**: Create, read, update, and delete tasks. Track task completion and deadlines (On Time/Late).
- **Firestore Integration**: Persistent and real-time data storage for tasks in Firebase Firestore.
- **Dynamic Quotes**: Daily motivation through dynamic quotes fetched from an external API.
- **State Management**: Efficient and scalable state management using `flutter_riverpod`.
- **Modern UI**: Clean and intuitive user interface with a bottom navigation bar.

## Tech Stack
- **Framework**: Flutter
- **Language**: Dart
- **Backend/BaaS**: Firebase (Authentication, Firestore)
- **State Management**: Riverpod (`flutter_riverpod`)
- **Networking**: `http` package

## Setup Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/anirudh05nc/sankar_group.git
   cd sankar_group
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Firebase Configuration**:
   - The app relies on Firebase. Ensure you have the `google-services.json` (for Android) configured in `android/app/`.
   - Ensure the SHA-1 fingerprint of your development machine is added to your Firebase project settings to allow Google Sign-In to function properly.
4. **Run the App**:
   Connect your device or start an emulator/simulator, then run:
   ```bash
   flutter run
   ```

## Project Details
This project demonstrates a complete integration of Firebase services within a Flutter application. It showcases best practices in structuring a Flutter app, managing complex state with Riverpod, handling authentication flows, and performing database interactions using Cloud Firestore.

---

Submitting to SANKAR GROUP
by Anirudh NC
Date : 15-05-2026
