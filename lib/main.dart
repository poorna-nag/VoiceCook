import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance(); //
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc(RecipeRepoImpl())),
      ],
      child: MaterialApp(
        theme: ThemeData(colorSchemeSeed: const Color(0xFF1B3A2E)),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: NavigationService.onGenerateRoute,
        initialRoute: AppRoutes.sp,
        home: const SplashScreen(),
      ),
    );
  }
}
