import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/feeding/feed_screen.dart' show FeedScreen;
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';
import 'package:voicecook/feature/home/presentation/pages/home_view_screen_state.dart';
import 'package:voicecook/feature/video/presentation/video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> page = [HomeViewScreenState(), FeedScreen(), VideoScreen()];
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetRecipeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 2
          ? null
          : AppBar(
              title: const Text(
                "VoiceCook",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF1B3A2E),
              automaticallyImplyLeading: false,
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(NavToFavScreenEvent());
                  },
                  icon: const Icon(Icons.favorite, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    if (FirebaseAuth.instance.currentUser == null) {
                      NavigationService.pushNamed(routeName: AppRoutes.login);
                    } else {
                      NavigationService.pushNamed(routeName: AppRoutes.profile);
                    }
                  },
                  icon: const Icon(Icons.person, color: Colors.white),
                ),
              ],
            ),
      extendBody: selectedIndex == 2,

      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(canvasColor: selectedIndex == 2 ? Colors.transparent : null),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          backgroundColor: selectedIndex == 2
              ? Colors.black.withOpacity(0.01)
              : null,
          selectedItemColor: selectedIndex == 2
              ? Colors.white
              : const Color(0xFF1B3A2E),
          unselectedItemColor: selectedIndex == 2
              ? Colors.white70
              : Colors.grey,
          elevation: selectedIndex == 2 ? 0 : 8,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: 'Reels',
            ),
          ],
        ),
      ),
      body: page[selectedIndex],
    );
  }
}
