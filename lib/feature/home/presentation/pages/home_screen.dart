import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/constants/app_colors.dart';
import 'package:voicecook/core/constants/app_strings.dart';
import 'package:voicecook/feature/feeding/feed_screen.dart' show FeedScreen;
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';
import 'package:voicecook/feature/home/presentation/pages/fav_screen.dart';
import 'package:voicecook/feature/home/presentation/pages/home_view_screen_state.dart';
import 'package:voicecook/feature/video/presentation/video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> page = [
    HomeViewScreenState(),
    FavScreen(favItems: []),
    FeedScreen(),
    VideoScreen(),
  ];
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetRecipeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      extendBody: selectedIndex == 3,

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: selectedIndex == 3 ? AppColors.transparent : null,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          backgroundColor: selectedIndex == 3
              ? AppColors.black.withOpacity(0.01)
              : null,
          selectedItemColor: selectedIndex == 3
              ? AppColors.white
              : AppColors.primary,
          unselectedItemColor: selectedIndex == 3
              ? Colors.white70
              : AppColors.grey,
          elevation: selectedIndex == 3 ? 0 : 8,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: AppStrings.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: AppStrings.favorites,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: AppStrings.create,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: AppStrings.reels,
            ),
          ],
        ),
      ),
      body: page[selectedIndex],
    );
  }
}
