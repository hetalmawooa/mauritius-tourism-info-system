import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../constants/colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);

    return PopupMenuButton<Language>(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.language,
              size: 18,
              color: AppColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              _getLanguageFlag(langProvider.currentLanguage),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 4),
            Text(
              langProvider.languageCode.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        _buildMenuItem(Language.en, '🇬🇧', 'English'),
        _buildMenuItem(Language.fr, '🇫🇷', 'Français'),
        _buildMenuItem(Language.cr, '🇲🇺', 'Kreol'),
      ],
      onSelected: (language) {
        langProvider.setLanguage(language);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      offset: const Offset(0, 45),
    );
  }

  PopupMenuItem<Language> _buildMenuItem(
    Language language,
    String flag,
    String name,
  ) {
    return PopupMenuItem<Language>(
      value: language,
      child: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String _getLanguageFlag(Language language) {
    switch (language) {
      case Language.en:
        return '🇬🇧';
      case Language.fr:
        return '🇫🇷';
      case Language.cr:
        return '🇲🇺';
    }
  }
}