
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../models/attraction.dart';
import '../models/location.dart';
import '../providers/language_provider.dart';
import '../data/mock_data.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/language_selector.dart';
// ignore: unused_import
import '../widgets/map_painter.dart';

class AttractionsPage extends StatefulWidget {
  const AttractionsPage({super.key});

  @override
  State<AttractionsPage> createState() => _AttractionsPageState();
}

class _AttractionsPageState extends State<AttractionsPage> {
  Region? selectedRegion;
  AttractionCategory? selectedCategory;
  String? svgPath;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

    final attractions = MockData.attractions.where((a) {
      final matchesRegion = selectedRegion == null || a.location.region == selectedRegion;
      final matchesCategory = selectedCategory == null || a.category == selectedCategory;
      return matchesRegion && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    t['exploreTitle'] ?? 'Explore Mauritius',
                    style: AppTextStyles.h1,
                  ),
                ),
                const LanguageSelector(),
              ],
            ),
            const SizedBox(height: 16),
            _buildInteractiveMap(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildCategoryChip(null, t['filterAll'] ?? 'All'),
                _buildCategoryChip(
                  AttractionCategory.beach,
                  t['categoryBeach'] ?? 'Beaches',
                ),
                _buildCategoryChip(
                  AttractionCategory.restaurant,
                  t['categoryRestaurant'] ?? 'Restaurants',
                ),
                _buildCategoryChip(
                  AttractionCategory.nature,
                  t['categoryNature'] ?? 'Nature',
                ),
                _buildCategoryChip(
                  AttractionCategory.cultural,
                  t['categoryCultural'] ?? 'Cultural',
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (attractions.isEmpty)
              _buildEmptyState(t)
            else
              ...attractions.map((a) => _buildAttractionCard(a)),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveMap() {
    final screenWidth = MediaQuery.of(context).size.width - 32;
    final centerX = screenWidth * 0.5;

    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: svgPath != null
                  ? SvgPicture.file(
                      File(svgPath!),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'lib/assest/mauritius_map.avif',
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              top: 20,
              left: centerX - 35,
              child: _regionButton(Region.north),
            ),
            Positioned(
              bottom: 20,
              left: centerX - 35,
              child: _regionButton(Region.south),
            ),
            Positioned(
              top: 130,
              right: 20,
              child: _regionButton(Region.east),
            ),
            Positioned(
              top: 130,
              left: 20,
              child: _regionButton(Region.west),
            ),
            Positioned(
              top: 130,
              left: centerX - 35,
              child: _regionButton(Region.centre),
            ),
            Positioned(
              top: 60,
              left: 60,
              child: _regionButton(Region.portLouis),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.upload_file),
                onPressed: _pickSvgFile,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _regionButton(Region region) {
    final isSelected = selectedRegion == region;
    final regionName = _getRegionDisplayName(region);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? AppColors.primary : AppColors.primaryLight,
        foregroundColor: isSelected ? Colors.white : AppColors.textPrimary,
        elevation: isSelected ? 4 : 2,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(70, 36),
      ),
      onPressed: () {
        setState(() {
          selectedRegion = isSelected ? null : region;
        });
      },
      child: Text(
        regionName,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  String _getRegionDisplayName(Region region) {
    switch (region) {
      case Region.north:
        return 'North';
      case Region.south:
        return 'South';
      case Region.east:
        return 'East';
      case Region.west:
        return 'West';
      case Region.centre:
        return 'Centre';
      case Region.portLouis:
        return 'Port Louis';
    }
  }

  Widget _buildCategoryChip(AttractionCategory? category, String label) {
    final isSelected = selectedCategory == category;

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          selectedCategory = category;
        });
      },
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.primaryLight,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildAttractionCard(Attraction attraction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  attraction.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.image_not_supported, size: 32),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attraction.name,
                      style: AppTextStyles.cardTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          _getCategoryIcon(attraction.category),
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            attraction.location.address,
                            style: AppTextStyles.cardSubtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    if (attraction.rating != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            attraction.rating!.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Map<String, String> t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 32),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            t['noAttractionsFound'] ?? 'No attractions found',
            style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            t['tryDifferentFilter'] ?? 'Try changing your filters',
            style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                selectedRegion = null;
                selectedCategory = null;
              });
            },
            icon: const Icon(Icons.refresh),
            label: Text(t['clearFilters'] ?? 'Clear Filters'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickSvgFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['svg'],
    );

    if (result != null) {
      setState(() {
        svgPath = result.files.single.path;
      });
    }
  }

  IconData _getCategoryIcon(AttractionCategory category) {
    switch (category) {
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
}

