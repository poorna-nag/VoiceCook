import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:voicecook/core/constants/app_strings.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/auth/data/auth_model.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_event.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? AppStrings.errorOccurred),
                backgroundColor: theme.colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with Gradient
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/chef.json', height: 100, width: 100),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.createAccount,
                      style: GoogleFonts.outfit(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.joinCommunity,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.getStarted,
                      style: GoogleFonts.outfit(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppStrings.fillDetailsToCreate,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                      controller: nameController,
                      label: AppStrings.fullName,
                      icon: Icons.person_outline,
                      theme: theme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: emailController,
                      label: AppStrings.email,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      theme: theme,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: passwordController,
                      label: AppStrings.password,
                      icon: Icons.lock_outline,
                      obscureText: obscurePassword,
                      theme: theme,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: () =>
                            setState(() => obscurePassword = !obscurePassword),
                      ),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton(
                            onPressed: state is AuthLoading
                                ? null
                                : _handleSignUp,
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                            ),
                            child: state is AuthLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    AppStrings.registerNow,
                                    style: GoogleFonts.outfit(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          NavigationService.pop();
                        },
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.outfit(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            children: [
                              const TextSpan(
                                text: AppStrings.alreadyHaveAccount,
                              ),
                              TextSpan(
                                text: AppStrings.login,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.pleaseFillFields)),
      );
      return;
    }

    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.passwordTooShort)),
      );
      return;
    }

    context.read<AuthBloc>().add(
      SignUpEvent(
        authModel: AuthModel(
          userName: nameController.text,
          passcode: passwordController.text,
          userEmail: emailController.text,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required ThemeData theme,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.outfit(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: theme.colorScheme.primary),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        labelStyle: GoogleFonts.outfit(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
