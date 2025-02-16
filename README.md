# OruPhones - Flutter App

## Overview

OruPhones is a mobile marketplace for buying and selling used phones. This project is a replication of ORUPhones and follows a clean architecture with Stacked state management to ensure modularity, scalability, and maintainability.

## Bonus Features Implemented 🎉
In addition to the core requirements of the assignment, the following bonus features have been implemented to enhance the app’s functionality and user experience:

✅ 1. Persistent Authentication State

The app maintains the user's authentication status across sessions using SharedPreferences.

On app launch, the Splash Screen checks the authentication state and navigates accordingly.

✅ 2. Stacked State Management for Modular Code

Used Stacked architecture to separate UI and business logic.

ViewModels manage API calls, authentication, and state without affecting UI components.

✅ 3. Bottom Sheet Authentication Flow

Implemented login and OTP verification using Bottom Sheets for a seamless user experience.

Supports both standalone screens and bottom sheets, ensuring modular reuse.


✅ 4. Infinite Scroll with Pagination

Implemented lazy loading in the product listing using a ScrollController.

_onScroll() triggers new data fetch only when the user reaches the bottom.

✅ 5. Favorite Products with Local Storage

Users can like/unlike products, and their favorite listings persist using SharedPreferences.

Ensures offline support for favorite products.

✅ 6. Server-Side Sorting

Integrated sorting options via API parameters.

✅ 7. Improved Image Loading Performance

Used CachedNetworkImage to efficiently load product images with placeholders and error handling.

## Architecture Followed

The project is built using Clean Architecture principles with a separation of concerns:

🔹 Layers Used:

📂 Core Layer: Business logic, models, and service classes.

📂 UI Layer: Views, ViewModels (Stacked), and widgets.

📂 Services Layer: Handles API calls, authentication, and shared preferences.

## State Management Approach

The app uses Stacked State Management (ViewModel-based).

Separation of UI & Logic – Views remain clean.

Easy Dependency Injection – Services injected via locator.dart.

Reactive UI – Automatic updates via notifyListeners().

Example: Each screen has a corresponding ViewModel
```
class HomeViewModel extends BaseViewModel {
  final ProductService _productService = locator<ProductService>();

  List<Product> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    products = await _productService.fetchProducts();
    isLoading = false;
    notifyListeners();
  }
}
```


## Project Setup & Installation

Follow these steps to set up the project locally.

1️⃣ Clone the Repository
```
git clone https://github.com/your-repo/oruphones.git
cd oruphones
```

2️⃣ Install Dependencies
```
flutter pub get
```

3️⃣ Set Up Firebase (For Push Notifications)

Create a Firebase project.

Download google-services.json and place it in android/app/.

Enable Firebase Authentication.

4️⃣ Run the App
For Android:
```
flutter run
```

For iOS:
```
cd ios
pod install
flutter run
```

## Features Implemented
✔️ Splash Screen with Auth Check

✔️ Stacked BottomSheet & Authentication Flow

✔️ Collapsing SliverAppBar

✔️ Product Listings with Pagination & Favorites

✔️ Push Notifications with Firebase

✔️ Filter & Sort Functionality

✔️ Custom Drawer with User Profile

## Contributing
Contributions are welcome! Fork the repo, make changes, and submit a pull request.

## Contact
For any issues or discussions, contact sumitkamble2@outlook.com

