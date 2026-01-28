import 'location.dart';

enum EventCategory {
  music,
  sports,
  cultural,
  food,
  festival,
}

class Event {
  final String id;
  final String name;
  final String description;
  final EventCategory category;
  final DateTime date;
  final DateTime? endDate;
  final Location location;
  final String image;
  final bool isFree;
  final double? price;
  final String? organizer;
  final String? bookingUrl;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.date,
    this.endDate,
    required this.location,
    required this.image,
    this.isFree = false,
    this.price,
    this.organizer,
    this.bookingUrl,
  });

  String getFormattedDate() {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  bool get isUpcoming {
    return date.isAfter(DateTime.now());
  }

  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}