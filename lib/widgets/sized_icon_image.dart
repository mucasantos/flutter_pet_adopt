import 'package:flutter/material.dart';

class SizedIconImage extends StatelessWidget {
  const SizedIconImage({
    super.key,
    required this.imageAsset,
    this.width = 30.0,
  });
  final String imageAsset;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: width,
      child: Image.asset(
        imageAsset,
        fit: BoxFit.cover,
      ),
    );
  }
}
