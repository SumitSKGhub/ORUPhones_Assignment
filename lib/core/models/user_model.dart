class UserModel {
  final String userName;
  final String email;
  final String profilePicPath;
  final String city;
  final String state;
  final String mobileNumber;
  final bool isAccountExpired;
  final String createdDate;
  final List<String> favListings;

  UserModel({
    required this.userName,
    required this.email,
    required this.profilePicPath,
    required this.city,
    required this.state,
    required this.mobileNumber,
    required this.isAccountExpired,
    required this.createdDate,
    required this.favListings,
  });

  // Factory method to create UserModel from a Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      profilePicPath: json['profilePicPath'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      isAccountExpired: json['isAccountExpired'] ?? false,
      createdDate: json['createdDate'] ?? '',
      favListings: List<String>.from(json['favListings'] ?? []),
    );
  }
}
