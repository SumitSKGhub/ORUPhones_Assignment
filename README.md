# OruPhones - Flutter App

## Overview

OruPhones is a mobile marketplace for buying and selling used phones. This project is a replication of ORUPhones and follows a clean architecture with Stacked state management to ensure modularity, scalability, and maintainability.

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

