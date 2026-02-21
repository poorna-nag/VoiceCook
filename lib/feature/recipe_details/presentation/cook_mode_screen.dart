import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicecook/core/constants/app_colors.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';

class CookModeScreen extends StatefulWidget {
  final RecipeModel recipe;
  const CookModeScreen({super.key, required this.recipe});

  @override
  State<CookModeScreen> createState() => _CookModeScreenState();
}

class _CookModeScreenState extends State<CookModeScreen> {
  int _currentStepIndex = 0;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage("en-IN");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    _flutterTts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });
  }

  void _speak() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() => _isSpeaking = false);
    } else {
      setState(() => _isSpeaking = true);
      await _flutterTts.speak(widget.recipe.steps[_currentStepIndex]);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = widget.recipe.steps[_currentStepIndex];
    final progress = (_currentStepIndex + 1) / widget.recipe.steps.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Cook Mode",
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                "${_currentStepIndex + 1} / ${widget.recipe.steps.length}",
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Step ${_currentStepIndex + 1}",
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    step,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 26,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: _speak,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        _isSpeaking ? Icons.stop : Icons.volume_up,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isSpeaking ? "Stop Speaking" : "Listen to Step",
                    style: GoogleFonts.outfit(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStepIndex > 0)
                  _buildNavButton(
                    onPressed: () {
                      setState(() {
                        _currentStepIndex--;
                        _flutterTts.stop();
                        _isSpeaking = false;
                      });
                    },
                    icon: Icons.arrow_back_ios_new,
                    label: "Back",
                  )
                else
                  const SizedBox(width: 80),

                if (_currentStepIndex < widget.recipe.steps.length - 1)
                  _buildNavButton(
                    onPressed: () {
                      setState(() {
                        _currentStepIndex++;
                        _flutterTts.stop();
                        _isSpeaking = false;
                      });
                    },
                    icon: Icons.arrow_forward_ios,
                    label: "Next",
                    isPrimary: true,
                  )
                else
                  _buildNavButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.check_circle,
                    label: "Finish",
                    isPrimary: true,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    bool isPrimary = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? AppColors.primary : Colors.grey[100],
        foregroundColor: isPrimary ? Colors.white : AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: isPrimary ? 4 : 0,
      ),
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
