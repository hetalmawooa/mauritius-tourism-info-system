import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/language_provider.dart';
import '../data/mock_data.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../widgets/language_selector.dart';
import '../widgets/attraction_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t['homeTitle'] ?? 'Discover Mauritius',
                        style: AppTextStyles.h1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t['homeSubtitle'] ?? 'Your paradise island adventure',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                const LanguageSelector(),
              ],
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: AppColors.primaryLight,
                    child: const Center(
                      child: Icon(Icons.image, size: 48),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t['emergencyTitle'] ?? 'Emergency Contacts',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: 12),
            _buildEmergencyGrid(context),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t['featuredAttractions'] ?? 'Featured Attractions',
                  style: AppTextStyles.h2,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(t['viewAll'] ?? 'View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...MockData.attractions.take(3).map((attraction) {
              return AttractionCard(attraction: attraction);
            }),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: MockData.emergencyContacts.length,
      itemBuilder: (context, index) {
        final contact = MockData.emergencyContacts[index];
        return _buildEmergencyCard(context, contact);
      },
    );
  }

  Widget _buildEmergencyCard(BuildContext context, contact) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse('tel:${contact.phone}');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                contact.icon,
                size: 32,
                color: contact.color,
              ),
              const SizedBox(height: 8),
              Text(
                contact.name,
                style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                contact.phone,
                style: AppTextStyles.bodySmall.copyWith(
                  color: contact.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}