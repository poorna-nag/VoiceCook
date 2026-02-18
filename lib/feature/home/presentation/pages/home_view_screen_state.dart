import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicecook/feature/category/presentation/category_screen.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart' show RecipeModel;
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_state.dart';
import 'package:voicecook/feature/home/presentation/pages/card_view.dart';

class HomeViewScreenState extends StatefulWidget {
  const HomeViewScreenState({super.key});

  @override
  State<HomeViewScreenState> createState() => __HomeViewScreenStateState();
}

class __HomeViewScreenStateState extends State<HomeViewScreenState> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeLoadedState) {
          return HomeView(recipeModel: state.recipe);
        } else if (state is HomeErrorState) {
          return Center(child: Text("Error : ${state.error}"));
        }
        return const Center(child: CircularProgressIndicator());
      },
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
              fontSize: 34,
              fontWeight: FontWeight.w700,
              height: 1.2,
              letterSpacing: 0.9,
            ),
          ),
          SizedBox(height: 9),
          TextField(
            decoration: InputDecoration(
              hintText: "Search recipes...",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF1B3A2E)),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                context.read<HomeBloc>().add(GetRecipeEvent());
              } else {
                context.read<HomeBloc>().add(SearchRecipeEvent(value));
              }
            },
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 140,
            width: double.infinity,
            child: const CategoryScreen(),
          ),
          const SizedBox(height: 10),
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
