import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Filter",
          style: TextStyle(
            color: mainColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: const Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal:  16.0, ),
          child: Divider(color: mainColor,),
        )
      ],),
    );
  }
}
