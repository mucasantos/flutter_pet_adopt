import 'package:flutter/material.dart';

class EmptyPetsState extends StatelessWidget {
  const EmptyPetsState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          'No pets matched the current search or category filters.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
