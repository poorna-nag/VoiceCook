import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
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
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return SingInScreenView();
          } else if (state is AuthError) {
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
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passCode = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    passCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'An error occurred'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(" WelCome", style: TextStyle(fontSize: 40)),
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
              keyboardType: TextInputType.emailAddress,
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
              obscureText: true,
            ),
            SizedBox(height: 10),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return FilledButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          if (name.text.isEmpty ||
                              email.text.isEmpty ||
                              passCode.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all fields')),
                            );
                            return;
                          }

                          if (passCode.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Password must be at least 6 characters',
                                ),
                              ),
                            );
                            return;
                          }

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
                  child: state is AuthLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Register Now"),
                );
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                NavigationService.pop();
              },
              child: Text(
                " Move to Login Page  ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
