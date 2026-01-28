class Review {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  final bool verified;

  Review({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.verified = false,
  });

  String getFormattedDate() {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? "week" : "weeks"} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? "month" : "months"} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? "year" : "years"} ago';
    }
  }
}