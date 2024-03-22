import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.image,
    required this.index,
    required this.name,
    required this.chipValue,
     this.onSelected,
  });
  final String image;
  final int index;
  final int? chipValue;
  final String name;
  final void Function(bool value)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(8.0),
      child: ChoiceChip(
        side: const BorderSide(
          width: 0.0,
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15.0,
            ),
          ),
        ),
        selectedColor: mainColor,
        backgroundColor: const Color.fromARGB(255, 227, 222, 222),
        showCheckmark: false,
        selected: chipValue == index,
        onSelected: onSelected,
       
        avatar:  CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        label:  Text(
          name,
        ),
      ),
    );
  }
}
