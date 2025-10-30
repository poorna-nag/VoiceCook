import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B3A2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "VoiceCook",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Your Local Recipe Assistant",
              style: TextStyle(
                fontSize: 20,
                color: const Color.fromARGB(255, 90, 146, 140),
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(NavToHomeEvent());
              },
              child: Text(
                "Let's Start",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
