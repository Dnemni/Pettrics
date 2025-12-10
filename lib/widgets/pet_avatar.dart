import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PetAvatar extends StatelessWidget {
  final double size;
  final String imageUrl;
  final bool showBorder;

  const PetAvatar({
    super.key,
    required this.imageUrl,
    this.size = 64,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: showBorder
            ? Border.all(
                color: AppColors.primary.withOpacity(0.5),
                width: 3,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primary.withOpacity(0.2),
              child: Icon(
                Icons.pets,
                size: size * 0.5,
                color: AppColors.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
