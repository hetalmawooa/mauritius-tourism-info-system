import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../data/mock_data.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/language_selector.dart';
import '../widgets/attraction_card.dart';

class DirectoryPage extends StatefulWidget {
  const DirectoryPage({super.key});

  @override
  State<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

    final filteredRestaurants = MockData.restaurants.where((restaurant) {
      if (_searchQuery.isEmpty) return true;
      return restaurant.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          restaurant.location.address.toLowerCase().contains(_searchQuery.toLowerCase());
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
                          t['directoryTitle'] ?? 'Restaurant Directory',
                          style: AppTextStyles.h1,
                        ),
                      ),
                      const LanguageSelector(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: t['searchPlaceholder'] ?? 'Search restaurants...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredRestaurants.isEmpty
                  ? _buildEmptyState(t)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        return AttractionCard(
                          attraction: filteredRestaurants[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(Map<String, String> t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            t['noRestaurantsFound'] ?? 'No restaurants found',
            style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}