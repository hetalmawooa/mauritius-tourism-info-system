import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/language_provider.dart';
import 'widgets/navigation_bar.dart' as custom_nav;
import 'screens/home_page.dart';
import 'screens/events_page.dart';
import 'screens/directory_page.dart';
import 'screens/hotels_page.dart';
import 'screens/attractions_page.dart';
import 'chatbot/chatbot_widget.dart';
import 'constants/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MauritiusGuideApp(),
    ),
  );
}

class MauritiusGuideApp extends StatelessWidget {
  const MauritiusGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mauritius Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          background: AppColors.background,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    EventsPage(),
    DirectoryPage(),
    HotelsPage(),
    AttractionsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          const ChatBotWidget(),
        ],
      ),
      bottomNavigationBar: custom_nav.CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
