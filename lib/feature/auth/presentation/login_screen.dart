import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
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
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            return LoginUi();
          } else if (state is AuthError) {
            return Text(state.toString());
          }
          return const LoginUi();
        },
      ),
    );
  }
}

class LoginUi extends StatefulWidget {
  const LoginUi({super.key});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("LogIn Here", style: TextStyle(fontSize: 30)),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
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
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please fill all fields'),
                                ),
                              );
                              return;
                            }
                            context.read<AuthBloc>().add(
                              LogingEvent(
                                useremail: emailController.text,
                                passCode: passwordController.text,
                              ),
                            );
                          },
                    child: state is AuthLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Login "),
                  );
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  NavigationService.pushNamed(routeName: AppRoutes.signin);
                },
                child: Text(" Register Here >> "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
