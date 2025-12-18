
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_event.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadedState) {
          return LoginUi();
        } else if (state is ErrorState) {
          throw Exception();
        }
        return SizedBox.shrink();
      },
    );
  }
}

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("LogIn Here", style: TextStyle(fontSize: 30)),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                LogingEvent(userName: "", passCode: ""),
              );
            },

            child: Text("Login "),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(NavigateToSinginPageEvent());
            },
            child: Text(
              " Not Register then Register Here  ",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
