import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/auth/data/auth_model.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_event.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_state.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return Center(child: Text("Error occurred"));
          } else {
            return SingInScreenView();
          }
        },
      ),
    );
  }
}

class SingInScreenView extends StatefulWidget {
  const SingInScreenView({super.key});

  @override
  State<SingInScreenView> createState() => _SingInScreenViewState();
}

class _SingInScreenViewState extends State<SingInScreenView> {
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passCode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(" Well Come", style: TextStyle(fontSize: 40)),
          SizedBox(height: 10),
          TextField(
            controller: name,
            decoration: InputDecoration(
              label: Text("Enter your name"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: email,
            decoration: InputDecoration(
              label: Text("Enter Your Email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: passCode,
            decoration: InputDecoration(
              label: Text("Enter PassCode"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                SingInEvent(
                  authModel: AuthModel(
                    userName: name.text,

                    passcode: passCode.text,
                    userEmail: email.text,
                  ),
                ),
              );
            },
            child: Text("Register Now"),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(NavigateToLoginPageEvent());
            },
            child: Text(
              " Move to Login Page  ",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
