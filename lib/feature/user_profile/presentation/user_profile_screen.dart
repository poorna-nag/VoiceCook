import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicecook/core/constants/app_colors.dart';
import 'package:voicecook/core/constants/app_strings.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/user_profile/data/user_model.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_bloc.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_event.dart';
import 'package:voicecook/feature/user_profile/presentation/bloc/user_state.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.profile,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            onPressed: () {
              NavigationService.pushNamed(routeName: AppRoutes.settings);
            },
            icon: const Icon(Icons.settings, color: AppColors.white),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,

      body: BlocProvider(
        create: (context) => UserBloc()..add(GetUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              return UserProfile(user: state.user);
            } else if (state is UserErrorState) {
              return Center(child: Text(state.error));
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  final UserModel user;
  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
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
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
              ),
              Positioned(
                bottom: -60,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(user.imageUrl),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () {
                          context.read<UserBloc>().add(
                            UploadProfilePhotoEvent(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: theme.colorScheme.onPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 70),
          Text(
            user.name,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      context.read<UserBloc>().add(EditProfileEvent());
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text(AppStrings.editProfile),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // More options
                    },
                    icon: const Icon(Icons.more_horiz),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildInfoSection(context, user),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<UserBloc>().add(AddFoodInfoEvent());
              },
              icon: const Icon(Icons.menu_book),
              label: const Text(AppStrings.recipeInstructions),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, UserModel user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.accountDetails,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard(context, [
            _buildInfoRow(
              context,
              Icons.person_outline,
              AppStrings.gender,
              user.gender,
            ),
            _buildInfoRow(
              context,
              Icons.calendar_today_outlined,
              AppStrings.age,
              user.age,
            ),
            _buildInfoRow(
              context,
              Icons.star_outline,
              AppStrings.rating,
              user.rating,
            ),
            _buildInfoRow(
              context,
              Icons.restaurant_outlined,
              AppStrings.foodPreference,
              user.foodType,
            ),
            _buildInfoRow(
              context,
              Icons.location_on_outlined,
              AppStrings.address,
              user.address,
            ),
            _buildInfoRow(
              context,
              Icons.phone_outlined,
              AppStrings.phone,
              user.phoneNum,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          return Column(
            children: [
              children[index],
              if (index != children.length - 1)
                Divider(
                  height: 1,
                  indent: 60,
                  endIndent: 20,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
