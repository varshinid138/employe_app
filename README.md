# employee_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

# Employee Directory - Flutter App

A simple Flutter application to fetch and display a list of employees from an API. It features an elegant user interface with a real-time search functionality to filter employees by their first names.

---

## 📱 APK Installation Guide

### ✅ Prerequisites

- Android phone with Android 5.0 (Lollipop) or higher.
- "Unknown Sources" installation enabled.

### 🔄 Steps to Install the APK

1. **Locate the APK File**  
   Navigate to the path below in your Flutter project after running a release build:  
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

2. **Transfer to Mobile**
   - Use a USB cable or file sharing tool (like Google Drive, AirDroid, or email) to transfer `app-release.apk` to your mobile device.

3. **Enable Unknown Sources on Android**
   - Go to **Settings > Security**.
   - Enable **Install from Unknown Sources** (or **Allow installation from this source** when prompted during install).

4. **Install APK**
   - On your mobile, open the transferred `app-release.apk` file.
   - Follow the on-screen instructions to install the app.

---

## 🚀 Features & Specifications

- ✅ Displays a list of employees using data fetched from a remote API (`https://reqres.in/api/users?page=2`).
- ✅ Built-in search functionality by first name.
- ✅ Stylish card-based user layout with avatars and employee info.
- ✅ Handles loading states and API failures gracefully with alert dialogs.
- ✅ Fast performance with optimized network fetching.

---

## 🧠 Code Explanation

### `main.dart`
- Entry point of the app.
- Sets up the app with a material design theme and launches `UserListScreen`.

### `UserListScreen` widget
- Fetches user data from an API on initialization using `ApiService.fetchUsers`.
- Includes a search bar to filter users by first name.
- Displays each user in a card with their name, email, and ID.
- Handles loading state and errors gracefully.

### `api_service.dart`
- Contains `ApiService` class with a static method `fetchUsers()`.
- Makes an HTTP GET request to `https://reqres.in/api/users?page=2`.
- Parses the response and returns a list of `User` objects.

### `user.dart`
- Defines the `User` model with fields: `id`, `firstName`, `lastName`, and `email`.
- Includes a factory method `fromJson` to map API response data to a `User` object.

---

## 🧩 Project Structure

```
lib/
│
├── main.dart               # App entry point
├── models/
│   └── user.dart           # User model class
├── services/
│   └── api_service.dart    # API interaction logic
```

---

## 📦 Building the Release APK

1. Make sure Flutter is installed.
2. In the root directory of your project, run:
   ```bash
   flutter build apk --release
   ```
3. Find your APK at:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

---

## 👨‍💻 Author & License

- Developed by: VARSHINI DURAI RASU
- License: MIT

---


