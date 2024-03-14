import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/widgets/app_button.dart';
import 'package:flutter_pet_adopt/widgets/pet_info_container.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              height: MediaQuery.of(context).size.height * .44,
              autoPlay: true,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.asset(
                    dogImage,
                    fit: BoxFit.cover,
                  );
                },
              );
            }).toList(),
          ),
          const Row(
            children: [
              Text("Name Pet"),
              Text("2 years"),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PetInfoContainer(
                title: 'Boxer',
                info: 'Breed',
              ),
              PetInfoContainer(
                title: '2 Years',
                info: 'Age',
              ),
              PetInfoContainer(
                title: 'Fit',
                info: 'Health',
              ),
              PetInfoContainer(
                title: '4 Kg',
                info: 'Weight',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const AppButton(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
