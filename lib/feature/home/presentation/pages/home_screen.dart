import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/feeding/feed_screen.dart' show FeedScreen;
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(RecipeRepoImpl())..add(GetRecipeEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              NavigationService.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_sharp),
          ),
          title: Text("VoiceCook", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF1B3A2E),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                context.read<HomeBloc>().add(NavToFavScreenEvent());
              },
              icon: Icon(Icons.favorite, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                context.read<HomeBloc>().add(NavToProfileEvent());
              },
              icon: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'feed'),

            BottomNavigationBarItem(
              icon: Icon(Icons.video_camera_back),
              label: 'vedio',
            ),
          ],
        ),
        body: page[selectedIndex],
      ),
    );
  }
}
