
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../constants/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final t = langProvider.translate;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: t['navHome'] ?? 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event),
            label: t['navEvents'] ?? 'Events',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant),
            label: t['navDining'] ?? 'Dining',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.hotel),
            label: t['navHotels'] ?? 'Hotels',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore),
            label: t['navExplore'] ?? 'Explore',
          ),
        ],
      ),
    );
  }
}