import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/category/presentation/category_screen.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_state.dart';
import 'package:voicecook/feature/home/presentation/pages/card_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadedState) {
              return HomeView(recipeModel: state.recipe);
            } else if (state is HomeErrorState) {
              return Text("Error : ${state.error}");
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  final List<RecipeModel> recipeModel;
  const HomeView({super.key, required this.recipeModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Embark on Your\nCooking Journey",
            style: GoogleFonts.playfairDisplay(
              color: const Color(0xFF1B3A2E),
              fontSize: 38,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: 0.9,
            ),
          ),
          SizedBox(height: 9),
          TextField(
            decoration: InputDecoration(
              hintText: "Search recipes...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                context.read<HomeBloc>().add(GetRecipeEvent());
              } else {
                context.read<HomeBloc>().add(SearchRecipeEvent(value));
              }
            },
          ),
          SizedBox(height: 5),
          Container(
            color: Colors.amber,
            height: 220,
            width: double.infinity,

            child: CategoryScreen(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Need to try",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1B3A2E),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<HomeBloc>().add(
                    NavToSeeMoreEvent(widget.recipeModel),
                  );
                },
                child: const Text(
                  "See all →",
                  style: TextStyle(
                    color: Color(0xFF1B3A2E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: CardView(recipes: widget.recipeModel)),
        ],
      ),
    );
  }
}
