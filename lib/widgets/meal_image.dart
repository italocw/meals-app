import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MealImage extends StatelessWidget {
  const MealImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: MemoryImage(kTransparentImage),
      fit: BoxFit.cover,
      height: 200,
      width: double.infinity,
      image: NetworkImage(imageUrl),
    );
  }
}
