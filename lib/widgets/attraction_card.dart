import 'package:flutter/material.dart';
import '../models/attraction.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class AttractionCard extends StatelessWidget {
  final Attraction attraction;
  final VoidCallback? onTap;

  const AttractionCard({
    super.key,
    required this.attraction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.network(
                    attraction.image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 48),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getCategoryIcon(),
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getCategoryName(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attraction.name,
                    style: AppTextStyles.h3,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          attraction.location.address,
                          style: AppTextStyles.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (attraction.rating != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          attraction.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber[700],
                          ),
                        ),
                        if (attraction.reviewCount != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(${attraction.reviewCount} reviews)',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    attraction.description,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (attraction.category) {
      case AttractionCategory.beach:
        return Icons.beach_access;
      case AttractionCategory.restaurant:
        return Icons.restaurant;
      case AttractionCategory.nature:
        return Icons.park;
      case AttractionCategory.cultural:
        return Icons.museum;
      case AttractionCategory.hotel:
        return Icons.hotel;
      case AttractionCategory.shopping:
        return Icons.shopping_bag;
      case AttractionCategory.entertainment:
        return Icons.theater_comedy;
    }
  }

  String _getCategoryName() {
    switch (attraction.category) {
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