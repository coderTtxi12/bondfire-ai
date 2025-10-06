import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';

class PhotoQuestionWidget extends StatefulWidget {
  final Question question;
  final QuestionAnswer? answer;

  const PhotoQuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<PhotoQuestionWidget> createState() => _PhotoQuestionWidgetState();
}

class _PhotoQuestionWidgetState extends State<PhotoQuestionWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.answer?.photoFile;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            // Photo requirements
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.buttonSecondary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.buttonPrimary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.photo_camera,
                        color: AppColors.buttonPrimary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Photo Requirements',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.buttonPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• High quality image\n• Good lighting\n• Face clearly visible\n• No filters or heavy editing',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Photo display or upload button
            if (_selectedImage != null) ...[
              // Selected photo
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.buttonPrimary,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Change photo button
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Change Photo'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.buttonPrimary,
                        side: const BorderSide(color: AppColors.buttonPrimary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _removeImage,
                      icon: const Icon(Icons.delete),
                      label: const Text('Remove'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Upload photo button
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.buttonSecondary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.buttonPrimary.withOpacity(0.3),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 48,
                        color: AppColors.buttonPrimary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tap to upload photo',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.buttonPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Camera or Gallery',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        final File imageFile = File(image.path);
        setState(() {
          _selectedImage = imageFile;
        });
        
        // Save to view model
        final viewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
        viewModel.answerPhotoQuestion(imageFile);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    
    // Clear from view model
    final viewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    viewModel.answerPhotoQuestion(File(''));
  }
}
