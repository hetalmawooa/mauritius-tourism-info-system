import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';
import '../models/location.dart';
import '../providers/language_provider.dart';
import '../data/mock_data.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/language_selector.dart';

class EventDetailsPage extends StatefulWidget {
  final DateTime selectedDate;

  const EventDetailsPage({super.key, required this.selectedDate});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Region? selectedRegion;
  EventCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

    final events = MockData.events.where((e) {
      final matchesDate = e.date.year == widget.selectedDate.year &&
          e.date.month == widget.selectedDate.month &&
          e.date.day == widget.selectedDate.day;
      final matchesRegion = selectedRegion == null || e.location.region == selectedRegion;
      final matchesCategory = selectedCategory == null || e.category == selectedCategory;
      return matchesDate && matchesRegion && matchesCategory;
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
                    '${t['eventsTitle'] ?? 'Events'} - ${widget.selectedDate.toLocal().toString().split(' ')[0]}',
                    style: AppTextStyles.h1,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const LanguageSelector(),
              ],
            ),
            const SizedBox(height: 16),
            _buildRegionButtons(),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildCategoryChip(null, t['filterAll'] ?? 'All'),
                _buildCategoryChip(
                  EventCategory.cultural,
                  t['categoryCultural'] ?? 'Cultural',
                ),
                _buildCategoryChip(
                  EventCategory.festival,
                  t['categoryFestival'] ?? 'Festival',
                ),
                _buildCategoryChip(
                  EventCategory.sports,
                  t['categorySports'] ?? 'Sports',
                ),
                _buildCategoryChip(
                  EventCategory.music,
                  t['categoryMusic'] ?? 'Music',
                ),
                _buildCategoryChip(
                  EventCategory.food,
                  t['categoryFood'] ?? 'Food',
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (events.isEmpty)
              _buildEmptyState(t)
            else
              ...events.map((e) => _buildEventCard(e)),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(EventCategory? category, String label) {
    final isSelected = selectedCategory == category;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedCategory = selected ? category : null;
        });
      },
      backgroundColor: AppColors.primaryLight,
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: 8),
            Text(
              event.description,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 8),
            Text(
              '${event.location.address} - ${event.date.toLocal().toString().split(' ')[0]}',
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionButtons() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: Region.values.map((region) => _buildRegionChip(region)).toList(),
    );
  }

  Widget _buildRegionChip(Region region) {
    final isSelected = selectedRegion == region;
    final regionName = _getRegionDisplayName(region);

    return FilterChip(
      label: Text(regionName),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedRegion = selected ? region : null;
        });
      },
      backgroundColor: AppColors.primaryLight,
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
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

    Widget _buildEmptyState(Map<String, String> t) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: Text(
            t['noEvents'] ?? 'No events found',
            style: AppTextStyles.body,
          ),
        ),
      );
    }
  }