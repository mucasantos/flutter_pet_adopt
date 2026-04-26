import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.imageUrl,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final trimmedImageUrl = imageUrl?.trim();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ChoiceChip(
        side: const BorderSide(width: 0, color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        selectedColor: mainColor,
        backgroundColor: const Color.fromARGB(255, 227, 222, 222),
        showCheckmark: false,
        selected: selected,
        onSelected: onSelected,
        avatar: trimmedImageUrl == null
            ? const CircleAvatar(
                child: Icon(Icons.pets, size: 18),
              )
            : ClipOval(
                child: Image.network(
                  trimmedImageUrl,
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const SizedBox(
                      width: 28,
                      height: 28,
                      child: Icon(Icons.pets, size: 18),
                    );
                  },
                ),
              ),
        label: Text(label.toUpperCase()),
      ),
    );
  }
}
