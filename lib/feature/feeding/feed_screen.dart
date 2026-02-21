import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_bloc.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_event.dart';
import 'package:voicecook/feature/feeding/presentation/bloc/feed_state.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/video/data/video_model.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int selectedIndex = 0; // 0 for Video Reel, 1 for Recipe Post
  List<XFile> selectedMedia = [];

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final cookTimeController = TextEditingController();
  final categoryController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();
  final caloriesController = TextEditingController();
  final difficultyController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    cookTimeController.dispose();
    categoryController.dispose();
    ingredientsController.dispose();
    stepsController.dispose();
    caloriesController.dispose();
    difficultyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc(FeedInitState()),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          final isVideo = selectedIndex == 0;

          return BlocListener<FeedBloc, FeedState>(
            listener: (context, state) {
              if (state is GetMediaState) {
                setState(() {
                  selectedMedia = state.medias;
                });
              } else if (state is FeedSuccessState) {
                _clearControllers();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                );
              } else if (state is FeedErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create Content",
                          style: GoogleFonts.outfit(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Share your culinary magic with the world",
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              _buildTab("Video Reel", 0),
                              const SizedBox(width: 8),
                              _buildTab("Recipe Post", 1),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildMediaPicker(context, isVideo, theme),
                        const SizedBox(height: 32),
                        _buildSectionTitle("General Information"),
                        const SizedBox(height: 16),
                        _buildTextField(
                          nameController,
                          "Dish Name",
                          Icons.restaurant_menu,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          descriptionController,
                          "Description",
                          Icons.description_outlined,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                cookTimeController,
                                "Cook Time",
                                Icons.timer_outlined,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                difficultyController,
                                "Difficulty",
                                Icons.speed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                categoryController,
                                "Category",
                                Icons.category_outlined,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildTextField(
                                caloriesController,
                                "Calories",
                                Icons.local_fire_department_outlined,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle("Preparation Details"),
                        const SizedBox(height: 16),
                        _buildTextField(
                          ingredientsController,
                          "Ingredients (Comma separated)",
                          Icons.list_alt,
                          maxLines: 4,
                        ),
                        if (!isVideo) ...[
                          const SizedBox(height: 16),
                          _buildTextField(
                            stepsController,
                            "Steps (Comma separated)",
                            Icons.format_list_numbered,
                            maxLines: 6,
                          ),
                        ],
                        const SizedBox(height: 48),
                        BlocBuilder<FeedBloc, FeedState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: state is FeedLoadingState
                                    ? null
                                    : () => _handlePublish(context, isVideo),
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                ),
                                child: state is FeedLoadingState
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        isVideo
                                            ? "Publish Reel"
                                            : "Post Recipe",
                                        style: GoogleFonts.outfit(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _clearControllers() {
    nameController.clear();
    descriptionController.clear();
    cookTimeController.clear();
    categoryController.clear();
    ingredientsController.clear();
    stepsController.clear();
    caloriesController.clear();
    difficultyController.clear();
    setState(() {
      selectedMedia = [];
    });
  }

  void _handlePublish(BuildContext context, bool isVideo) {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedMedia.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add media and fill required fields'),
        ),
      );
      return;
    }

    if (isVideo) {
      final videoModel = VideoModel(
        id: '',
        name: nameController.text,
        description: descriptionController.text,
        imageUrl: '',
        videoUrl: '',
        cookTime: cookTimeController.text,
        difficulty: difficultyController.text,
        category: categoryController.text,
        ingredients: ingredientsController.text,
        steps: stepsController.text,
        calories: caloriesController.text,
      );
      context.read<FeedBloc>().add(
        FeedVideoEvent(videoModel: videoModel, mediaFiles: selectedMedia),
      );
    } else {
      final recipeModel = RecipeModel(
        id: '',
        name: nameController.text,
        categoryId: categoryController.text,
        description: descriptionController.text,
        ingredients: ingredientsController.text
            .split(',')
            .map((e) => e.trim())
            .toList(),
        steps: stepsController.text.split(',').map((e) => e.trim()).toList(),
        imageUrl: '',
        time: cookTimeController.text,
        difficulty: difficultyController.text,
        calories: caloriesController.text,
      );
      context.read<FeedBloc>().add(
        FeedRecipeEvent(recipeModel: recipeModel, mediaFiles: selectedMedia),
      );
    }
  }

  Widget _buildTab(String text, int index) {
    final isSelected = selectedIndex == index;
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.white
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPicker(
    BuildContext context,
    bool isVideo,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (bottomSheetContext) => Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isVideo ? "Record or Select Video" : "Take or Select Photo",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPickerOption(
                      context,
                      icon: Icons.photo_library_outlined,
                      label: "Gallery",
                      onTap: () {
                        Navigator.pop(bottomSheetContext);
                        context.read<FeedBloc>().add(
                          GetMediaEvent(
                            source: [ImageSource.gallery],
                            isVideo: isVideo,
                          ),
                        );
                      },
                    ),
                    _buildPickerOption(
                      context,
                      icon: isVideo
                          ? Icons.videocam_outlined
                          : Icons.camera_alt_outlined,
                      label: isVideo ? "Record" : "Camera",
                      onTap: () {
                        Navigator.pop(bottomSheetContext);
                        context.read<FeedBloc>().add(
                          GetMediaEvent(
                            source: [ImageSource.camera],
                            isVideo: isVideo,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: selectedMedia.isNotEmpty
            ? isVideo
                  ? const Center(
                      child: Icon(
                        Icons.video_library,
                        size: 64,
                        color: Colors.blueGrey,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.file(
                        File(selectedMedia.first.path),
                        fit: BoxFit.cover,
                      ),
                    )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isVideo
                        ? Icons.videocam_outlined
                        : Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isVideo
                        ? "Upload or Record Video"
                        : "Add or Take Dish Image",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildPickerOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    final theme = Theme.of(context);
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.outfit(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: theme.colorScheme.primary),
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
