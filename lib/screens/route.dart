// import 'package:bd_app/screens/blog_screen.dart';
import 'package:bd_app/screens/blog_screen.dart';
import 'package:bd_app/screens/home_screen%20.dart';
import 'package:bd_app/screens/search_screen.dart';
import 'package:bd_app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool homePageVariable = true;
  bool exploreMembersVariable = false;

  @override
  void dispose() {
    _pageController.dispose(); // Dispose controller when not needed
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index; // Update bottom navigation bar's index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged, // Call this on page change
        children: [
          if (homePageVariable)
            HomeScreen(
              exploreMembersFunction: () {
                setState(() {
                  homePageVariable = false;
                  exploreMembersVariable = true;
                });
              },
            ),
          const SearchScreen(),
          const BlogScreen(),
          const SettingScreen(),
        ],
      ),
      bottomNavigationBar: Card(
        elevation: 20,
        child: SalomonBottomBar(
          selectedItemColor: const Color.fromRGBO(22, 103, 128, 1),
          selectedColorOpacity: 1,
          unselectedItemColor: const Color.fromRGBO(22, 103, 128, 1),
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.white : const Color.fromRGBO(22, 103, 128, 1)),
              title: Text(
                "Home",
                style: GoogleFonts.syne(
                  fontSize: 17.sp,
                  color: _currentIndex == 0 ? Colors.white : Colors.transparent,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.search, color: _currentIndex == 1 ? Colors.white : const Color.fromRGBO(22, 103, 128, 1)),
              title: Text(
                "Search",
                style: GoogleFonts.syne(
                  fontSize: 17.sp,
                  color: _currentIndex == 1 ? Colors.white : Colors.transparent,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.inbox, color: _currentIndex == 2 ? Colors.white : const Color.fromRGBO(22, 103, 128, 1)),
              title: Text(
                "Blog",
                style: GoogleFonts.syne(
                  fontSize: 17.sp,
                  color: _currentIndex == 2 ? Colors.white : Colors.transparent,
                ),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.settings, color: _currentIndex == 3 ? Colors.white : const Color.fromRGBO(22, 103, 128, 1)),
              title: Text(
                "Settings",
                style: GoogleFonts.syne(
                  fontSize: 17.sp,
                  color: _currentIndex == 3 ? Colors.white : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
