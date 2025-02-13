class Product {
  final String id;
  final String imageUrl;
  final String name;
  final String price;
  final String condition;
  final String location;
  final String locality;
  final String storage;
  final String ram;
  final String discount;
  final String created;
  final bool negotiate;
  final bool verified;

  Product(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.condition,
      required this.location,
      required this.locality,
        required this.storage,
        required this.ram,
        required this.discount,
        required this.created,
        required this.negotiate,
        required this.verified,
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["marketingName"] ?? "unknown",
      imageUrl: json["defaultImage"]["fullImage"] ?? "",
      price: (json["listingPrice"] ?? 0).toString(),
      condition: json["deviceCondition"] ?? "unknown",
      location: json["listingLocation"] ?? "unknown",
      locality: json["listingLocality"] ?? "unknown",
      storage: json["deviceStorage"] ?? "unknown",
      // ram: json["deviceRam"]!= "--" ? json["deviceRam"]+"/" : "",
      ram: json["deviceRam"] ?? "",
      discount: json["discountPercentage"]!= null ? json["discountPercentage"].toString() : "0",
      created: json["createdAt"] ?? "",
      negotiate: json["openForNegotiation"] ? true : false,
        verified: json["verified"] ? true : false
    );
  }
}
