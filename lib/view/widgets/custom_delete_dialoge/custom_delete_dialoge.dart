import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirmDelete; // Callback when delete is confirmed
  final String title; // Title for the dialog
  final String content; // Message inside the dialog

  const CustomDeleteDialog({
    super.key,
    required this.onConfirmDelete,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.lightWhite,
          fontSize: 18,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.lightWhite
        ),

      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirmDelete(); // Call the delete function
            Navigator.of(context).pop(); // Close the dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.yesButtonColor, // Red color for delete action
          ),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Function to show the custom dialog
void showCustomDeleteDialog(BuildContext context, VoidCallback onConfirmDelete) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDeleteDialog(
        title: 'Delete Favorite',
        content: 'Are you sure you want to delete this item?',
        onConfirmDelete: onConfirmDelete,
      );
    },
  );
}
