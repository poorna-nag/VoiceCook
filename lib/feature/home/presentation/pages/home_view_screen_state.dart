import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicecook/core/constants/app_colors.dart';
import 'package:voicecook/core/constants/app_strings.dart';
import 'package:voicecook/feature/category/presentation/category_screen.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart' show RecipeModel;
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_state.dart';
import 'package:voicecook/feature/home/presentation/pages/card_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_bloc.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_event.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_state.dart';
import 'package:voicecook/core/navigation_service.dart';

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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.cookingJourney,
                  style: GoogleFonts.playfairDisplay(
                    color: const Color(0xFF1B3A2E),
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    letterSpacing: 0.9,
                  ),
                ),
                BlocProvider(
                  create: (context) => UserBloc()..add(GetUserEvent()),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      String? imageUrl;
                      if (state is UserLoadedState) {
                        imageUrl = state.user.imageUrl;
                      }

                      return GestureDetector(
                        onTap: () {
                          if (FirebaseAuth.instance.currentUser == null) {
                            NavigationService.pushNamed(
                              routeName: AppRoutes.login,
                            );
                          } else {
                            NavigationService.pushNamed(
                              routeName: AppRoutes.profile,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                imageUrl != null && imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl)
                                : null,
                            backgroundColor: Colors.grey[200],
                            child: imageUrl == null || imageUrl.isEmpty
                                ? const Icon(
                                    Icons.person,
                                    color: AppColors.primary,
                                  )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 9),
            TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchRecipes,
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
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
                  AppStrings.needToTry,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(
                      NavToSeeMoreEvent(widget.recipeModel),
                    );
                  },
                  child: const Text(
                    AppStrings.seeAllArrow,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: CardView(recipes: widget.recipeModel)),
          ],
        ),
      ),
    );
  }
}
