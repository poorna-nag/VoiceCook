import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_bloc.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_event.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_state.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int selectedIndex = 0;
  List<XFile> selectedMedia = [];
  final name = TextEditingController();
  final description = TextEditingController();
  final cookTime = TextEditingController();
  final category = TextEditingController();
  final ingredients = TextEditingController();
  final steps = TextEditingController();
  final calories = TextEditingController();
  final difficulty = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    cookTime.dispose();
    category.dispose();
    ingredients.dispose();
    steps.dispose();
    calories.dispose();
    difficulty.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc(FeedInitState()),
      child: BlocListener<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is GetMediaState) {
            setState(() {
              selectedMedia = state.medias;
            });
          } else if (state is FeedSuccessState) {
            name.clear();
            description.clear();
            cookTime.clear();
            category.clear();
            ingredients.clear();
            steps.clear();
            calories.clear();
            difficulty.clear();
            setState(() {
              selectedMedia = [];
            });
          }
        },
        child: SingleChildScrollView(
          child: BlocBuilder<FeedBloc, FeedState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          buildToggle("Video", 0),
                          SizedBox(width: 5),
                          buildToggle("Image", 1),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.read<FeedBloc>().add(
                          GetMediaEvent(
                            source: [ImageSource.gallery],
                            isVideo: selectedIndex == 0,
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF1B3A2E),
                        ),
                        child: selectedMedia.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(selectedMedia.first.path),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 250,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 120,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Add Media",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Enter Details',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B3A2E),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        label: Text('name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: description,
                      decoration: InputDecoration(
                        label: Text('description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: cookTime,
                      decoration: InputDecoration(
                        label: Text('cookTime'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: category,
                      decoration: InputDecoration(
                        label: Text('category'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: ingredients,
                      decoration: InputDecoration(
                        label: Text('ingredients'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: steps,
                      decoration: InputDecoration(
                        label: Text('steps'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: calories,
                      decoration: InputDecoration(
                        label: Text('calories'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: difficulty,
                      decoration: InputDecoration(
                        label: Text('difficulty'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1B3A2E),
                        ),
                        onPressed: state is FeedLoadingState
                            ? null
                            : () {
                                if (name.text.isEmpty ||
                                    description.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please fill required fields',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final videoModel = VideoModel(
                                  id: '',
                                  name: name.text,
                                  description: description.text,
                                  imageUrl: selectedMedia.isNotEmpty
                                      ? selectedMedia.first.path
                                      : '',
                                  cookTime: cookTime.text,
                                  difficulty: difficulty.text,
                                  category: category.text,
                                  ingredients: ingredients.text,
                                  steps: steps.text,
                                  calories: calories.text,
                                );

                                context.read<FeedBloc>().add(
                                  FeedVideoEvent(videoModel: videoModel),
                                );
                              },
                        child: state is FeedLoadingState
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "ADD ",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildToggle(String text, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF1B3A2E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

          alignment: Alignment.center,
          duration: Duration(microseconds: 200),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Color(0xFF1B3A2E),
            ),
          ),
        ),
      ),
    );
  }
}
