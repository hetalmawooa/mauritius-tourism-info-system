import 'location.dart';
import 'review.dart';

enum AttractionCategory {
  beach,
  restaurant,
  nature,
  cultural,
  hotel,
  shopping,
  entertainment,
}

class Attraction {
  final String id;
  final String name;
  final String description;
  final AttractionCategory category;
  final Location location;
  final String image;
  final double? rating;
  final int? reviewCount;
  final List<Review> reviews;
  final String? openingHours;
  final String? phone;
  final String? email;
  final String? website;
  final double? entryFee;
  final List<String> tags;

  Attraction({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.image,
    this.rating,
    this.reviewCount,
    this.reviews = const [],
    this.openingHours,
    this.phone,
    this.email,
    this.website,
    this.entryFee,
    this.tags = const [],
  });

  String get categoryName {
    switch (category) {
      case AttractionCategory.beach:
        return 'Beach';
      case AttractionCategory.restaurant:
        return 'Restaurant';
      case AttractionCategory.nature:
        return 'Nature';
      case AttractionCategory.cultural:
        return 'Cultural';
      case AttractionCategory.hotel:
        return 'Hotel';
      case AttractionCategory.shopping:
        return 'Shopping';
      case AttractionCategory.entertainment:
        return 'Entertainment';
    }
  }
}