import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text("Profile"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              NavigationService.pushNamed(routeName: AppRoutes.settings);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      body: BlocProvider(
        create: (context) => UserBloc()..add(GetUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            File? image;
            if (state is UserLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              return UserProfile(user: state.user);
            } else if (state is UploadImageState) {
              image = state.image;
            } else if (state is UserErrorState) {
              return Text(state.error);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class UserProfile extends StatefulWidget {
  final UserModel user;
  const UserProfile({super.key, required this.user});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final data = widget.user;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: Card(
                elevation: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<UserBloc>().add(EditProfileEvent());
                        },
                        child: Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CircleAvatar(
                            child: Image.network(
                              "https://plus.unsplash.com/premium_photo-1690407617542-2f210cf20d7e?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287",
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Expanded(
                              child: Text(
                                data.name,
                                style: GoogleFonts.aBeeZee(fontSize: 34),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '♀ ${data.gender}     Age : ${data.age}      ⭐ ${data.rateing}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              '🍽️ ${data.foodType} ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: Text(
                              '📍 ${data.address}         📞 ${data.phoneNum}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonal(
                  onPressed: () {
                    context.read<UserBloc>().add(UploadPhotoEvent());
                  },
                  child: Row(
                    children: [Icon(Icons.camera_alt), Text("Upload Image")],
                  ),
                ),

                FilledButton.tonal(
                  onPressed: () {
                    context.read<UserBloc>().add(AddFoodInfoEvent());
                  },
                  child: Row(
                    children: [Icon(Icons.menu), Text("Add Instraction")],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
