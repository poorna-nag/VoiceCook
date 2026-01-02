import 'package:flutter/material.dart';
import 'package:voicecook/feature/auth/presentation/login_screen.dart';
import 'package:voicecook/feature/auth/presentation/singin_screen.dart';
import 'package:voicecook/feature/category/presentation/categoty_item_list_screen.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/presentation/pages/fav_screen.dart';
import 'package:voicecook/feature/home/presentation/pages/home_screen.dart';
import 'package:voicecook/feature/recipe_detals/presentation/recipe_home_screen.dart';
import 'package:voicecook/feature/recipe_detals/presentation/recipe_detail_screen.dart';
import 'package:voicecook/feature/home/presentation/splash_screen.dart';
import 'package:voicecook/feature/settings/presentation/settings_screen.dart';
import 'package:voicecook/feature/user_profile/presentation/add_food_screen.dart';
import 'package:voicecook/feature/user_profile/presentation/profile_edit_screen.dart';
import 'package:voicecook/feature/user_profile/presentation/user_profile_screen.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  static Future<T?> pushNamed<T extends Object?>({
    required String routeName,
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<
    T extends Object?,
    TO extends Object?
  >({required String routeName, Object? arguments, TO? result}) {
    return navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static void pop() {
    return navigatorKey.currentState!.pop();
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/sp':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case '/categoryList':
        final args = settings.arguments as Map<String, dynamic>?;
        final recipes = args?['recipes'] as List<RecipeModel>? ?? [];

        return MaterialPageRoute(
          builder: (_) => CategotyItemListScreen(recipe: recipes),
          settings: settings,
        );
      // case '/search':
      //   return MaterialPageRoute(
      //     builder: (_) => SearchScreen(),
      //     settings: settings,
      //   );
      case AppRoutes.card:
        final args = settings.arguments as Map<String, dynamic>?;
        final recipes = args?['recipes'] as List<RecipeModel>?;

        return MaterialPageRoute(
          builder: (_) => CategotyItemListScreen(recipe: recipes ?? []),
          settings: settings,
        );
      case AppRoutes.details:
        final args = settings.arguments as Map<String, dynamic>?;
        final recipes = args?['recipes'] as RecipeModel;

        return MaterialPageRoute(
          builder: (_) => RecipeHomeScreen(recipeModel: recipes),
          settings: settings,
        );

      case AppRoutes.fav:
        final args = settings.arguments as Map<String, dynamic>?;
        final favItems = args?['favItems'] as List<RecipeModel>?;

        return MaterialPageRoute(
          builder: (_) => FavScreen(favItems: favItems ?? []),
          settings: settings,
        );
      case AppRoutes.doc:
        final args = settings.arguments as Map<String, dynamic>?;
        final recipes = args?['recipes'] as List<RecipeModel>?;

        return MaterialPageRoute(
          builder: (_) => RecipeDetailScreen(recipe: recipes ?? []),
          settings: settings,
        );
      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (context) => UserProfileScreen(),
          settings: settings,
        );
      case AppRoutes.editprofile:
        return MaterialPageRoute(
          builder: (context) => ProfileEditScreen(),
          settings: settings,
        );
      case AppRoutes.addInfo:
        return MaterialPageRoute(
          builder: (context) => AddFoodScreen(),
          settings: settings,
        );
      case AppRoutes.signin:
        return MaterialPageRoute(
          builder: (context) => SingInScreen(),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
          settings: settings,
        );
      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}

class AppRoutes {
  static const String sp = '/sp';
  static const String home = "/home";
  static const String card = "/card";
  static const String fav = "/fav";
  static const String doc = "/doc";
  static const String details = "/details";
  static const String categoryList = "/categoryList";
  static const String search = "/search";
  static const String profile = "/profile";
  static const String addInfo = "/instraction";
  static const String editprofile = "/editprofile";
  static const String signin = '/signin';
  static const String login = '/login';
  static const String settings = '/settings';
}
