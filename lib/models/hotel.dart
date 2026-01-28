import 'location.dart';
import 'review.dart';

class Hotel {
  final String id;
  final String name;
  final String description;
  final int starRating;
  final Location location;
  final String image;
  final double pricePerNight;
  final double? rating;
  final int? reviewCount;
  final List<Review> reviews;
  final List<String> amenities;
  final String? phone;
  final String? email;
  final String? website;
  final String? bookingUrl;

  Hotel({
    required this.id,
    required this.name,
    required this.description,
    required this.starRating,
    required this.location,
    required this.image,
    required this.pricePerNight,
    this.rating,
    this.reviewCount,
    this.reviews = const [],
    this.amenities = const [],
    this.phone,
    this.email,
    this.website,
    this.bookingUrl,
  });

  String get formattedPrice {
    return 'MUR ${pricePerNight.toStringAsFixed(0)}';
  }

  String get starRatingText {
    return '$starRating★';
  }
}