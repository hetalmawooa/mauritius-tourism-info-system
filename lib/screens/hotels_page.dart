import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../data/mock_data.dart';
import '../models/location.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/language_selector.dart';
import '../widgets/hotel_card.dart';

class HotelsPage extends StatefulWidget {
  const HotelsPage({super.key});

  @override
  State<HotelsPage> createState() => _HotelsPageState();
}

class _HotelsPageState extends State<HotelsPage> {
  int? _selectedStars;
  Region? _selectedRegion;
  double _minPrice = 0;
  double _maxPrice = 25000;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

    final filteredHotels = MockData.hotels.where((hotel) {
      if (_selectedStars != null && hotel.starRating != _selectedStars) {
        return false;
      }
      if (_selectedRegion != null && hotel.location.region != _selectedRegion) {
        return false;
      }
      if (hotel.pricePerNight < _minPrice || hotel.pricePerNight > _maxPrice) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          t['hotelsTitle'] ?? 'Hotels & Resorts',
                          style: AppTextStyles.h1,
                        ),
                      ),
                      const LanguageSelector(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildStarFilter(null, 'All'),
                        const SizedBox(width: 8),
                        _buildStarFilter(5, '5⭐'),
                        const SizedBox(width: 8),
                        _buildStarFilter(4, '4⭐'),
                        const SizedBox(width: 8),
                        _buildStarFilter(3, '3⭐'),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.tune),
                          onPressed: () => _showFilterSheet(context, t),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredHotels.isEmpty
                  ? _buildEmptyState(t)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        return HotelCard(hotel: filteredHotels[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarFilter(int? stars, String label) {
    final isSelected = _selectedStars == stars;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedStars = stars;
        });
      },
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.primaryLight,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.primary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }

  Widget _buildEmptyState(Map<String, String> t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hotel_rounded, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            t['noHotelsFound'] ?? 'No hotels found',
            style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _selectedStars = null;
                _selectedRegion = null;
                _minPrice = 0;
                _maxPrice = 25000;
              });
            },
            icon: const Icon(Icons.refresh),
            label: Text(t['clearFilters'] ?? 'Clear Filters'),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context, Map<String, String> t) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filters', style: AppTextStyles.h2),
                  const SizedBox(height: 24),
                  Text('Price Range (per night)', style: AppTextStyles.h4),
                  const SizedBox(height: 8),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 25000,
                    divisions: 50,
                    labels: RangeLabels(
                      'MUR ${_minPrice.round()}',
                      'MUR ${_maxPrice.round()}',
                    ),
                    onChanged: (values) {
                      setModalState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}