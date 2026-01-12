# <div align="center">Tasky App</div>

<div align="center">
  <p><strong>Smart. Efficient. Organized.</strong></p>
  <p>
    A high-performance task management solution built with Flutter and Clean Architecture.
    <br />
    Organize your daily life, filter tasks securely, and manage your profile with ease.
  </p>
</div>

<div align="center">

  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
  ![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
  ![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)

</div>

<br />

## 📸 Screenshots

<div align="center">

<h3>🚀 Onboarding Journey</h3>
  <table>
    <tr>
      <td align="center"><img src="screenshots/onboarding1.jpeg" width="200"/><br /><b>Step 1</b></td>
      <td align="center"><img src="screenshots/onboarding2.jpeg" width="200"/><br /><b>Step 2</b></td>
      <td align="center"><img src="screenshots/onboarding3.jpeg" width="200"/><br /><b>Step 3</b></td>
    </tr>
  </table>

<h3>🔐 Authentication</h3>
  <table>
    <tr>
      <td align="center"><img src="screenshots/login_light_en.jpeg" width="200"/><br /><b>Login</b></td>
      <td align="center"><img src="screenshots/register_light_en.jpeg" width="200"/><br /><b>Register</b></td>
      <td align="center"><img src="screenshots/splas_screen.jpeg" width="200"/><br /><b>Splash</b></td>
    </tr>
  </table>

<h3>🏠 Core Features</h3>
  <table>
    <tr>
      <td align="center"><img src="screenshots/home_light_en.jpeg" width="200"/><br /><b>Home (Light)</b></td>
      <td align="center"><img src="screenshots/task_details_light_en.jpeg" width="200"/><br /><b>Details</b></td>
      <td align="center"><img src="screenshots/add_task_dark_en.jpeg" width="200"/><br /><b>Add Task (Dark)</b></td>
       <td align="center"><img src="screenshots/search.jpeg" width="200"/><br /><b>Search</b></td>
    </tr>
  </table>

<h3>🌍 Localization & Themes</h3>
  <table>
    <tr>
      <td align="center"><img src="screenshots/home_light_ar.jpeg" width="200"/><br /><b>Home (Arabic)</b></td>
      <td align="center"><img src="screenshots/home_dark_en.jpeg" width="200"/><br /><b>Home (Dark)</b></td>
       <td align="center"><img src="screenshots/profile_dark_en.jpeg" width="200"/><br /><b>Profile (Dark)</b></td>
    </tr>
  </table>
</div>

<br />

## ✨ Key Features

-   🔐 **Secure Authentication**: Robust Login, Signup, and Change Password functionality powered by Firebase Auth.
-   📋 **Comprehensive Task Management**: Create, Read, Update, and Delete tasks seamlessly.
-   🧠 **Smart Filtering**: Instantly filter tasks by Date (All, Today, Tomorrow, Next Week, etc.) and Status.
-   🔍 **Real-time Search**: Find specific tasks instantly with reactive search capabilities.
-   🌍 **Localization Support**: Fully localized for **English** (LTR) and **Arabic** (RTL).
-   📱 **Responsive Design**: Pixel-perfect UI across various screen sizes using `flutter_screenutil`.
-   💾 **Persistent Onboarding**: Smart onboarding flow that remembers returning users.
-   🎨 **Dark/Light Mode**: (Ready for implementation based on `ThemeCubit`).

## 🏗️ Architecture & Tech Stack

This project strictly adheres to **Clean Architecture** principals to ensure scalability, testability, and maintainability.

### Folder Structure
```bash
lib/
├── core/                   # Core utilities, DI, Routes, Theme, Wrappers
├── features/               # Feature-based modules
│   ├── auth/               # Authentication (Data, Domain, Presentation)
│   ├── home/               # Task Management (Data, Domain, Presentation)
│   ├── profile/            # User Profile (Data, Domain, Presentation)
│   └── splash/             # Splash & Onboarding Logic
└── main.dart               # Entry point
```

### Technologies Used
-   **State Management**: `flutter_bloc` (Cubit)
-   **Dependency Injection**: `get_it`
-   **Routing**: `go_router`
-   **UI Adaptation**: `flutter_screenutil`
-   **Comparisons**: `equatable`
-   **Localization**: `easy_localization`, `intl`
-   **Backend**: Firebase (Auth, Firestore)
-   **Animations**: `animate_do`

## 🚀 Installation & Setup

Follow these steps to get the app running locally.

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/tasky_app.git
cd tasky_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup Firebase & Secrets
> [!IMPORTANT]
> This project relies on Firebase. You must provide your own configuration files as they are ignored by git for security.

-   **Android**: Place `google-services.json` in `android/app/`.
-   **iOS**: Place `GoogleService-Info.plist` in `ios/Runner/`.

### 4. Run the App
```bash
flutter run
```

## 📞 Contact

For any inquiries or feedback, feel free to reach out:

-   **Name**: Mohamed Ehab
-   **Email**: mohamedehap172004@gmail.com

---

<div align="center">
  <sub>Built with Mohamed Ehab using Flutter</sub>
</div>
