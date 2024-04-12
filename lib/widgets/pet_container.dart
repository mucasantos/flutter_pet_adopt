import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/models/pet.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class PetContainer extends StatelessWidget {
  const PetContainer({
    super.key,
    required this.pet,
  });
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(211, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: boxShadow,
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    pet.images![0] ,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ) 
                  ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          pet.name!,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                        const Icon(
                          Icons.male,
                          color: mainColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(pet.age.toString()),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Years"),
                        
                        Text(" - ${pet.name}"),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.place_outlined),
                       // Text(pet.user!.name ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_sharp,
                    color: Colors.white,
                  ))),
        ],
      ),
    );
  }
}
