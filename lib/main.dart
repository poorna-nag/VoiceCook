import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voicecook/core/constants/app_colors.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:voicecook/feature/home/data/repo/recipe_repo_impl.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/splash_screen.dart';
import 'package:voicecook/feature/video/presentation/bloc/video_bloc.dart';
import 'package:voicecook/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SharedPreferences.getInstance();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc(RecipeRepoImpl())),
        BlocProvider(create: (context) => AuthBloc(AuthRepoImpl())),
        BlocProvider(create: (context) => VideoBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(colorSchemeSeed: AppColors.primary),
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: NavigationService.onGenerateRoute,
        initialRoute: AppRoutes.sp,
        home: SplashScreen(),
      ),
    );
  }
}
