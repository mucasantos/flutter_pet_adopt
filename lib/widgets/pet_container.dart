import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/models/pet.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';

class PetContainer extends StatelessWidget {
  const PetContainer({
    super.key,
    required this.pet,
    required this.setFavorite,
  });

  final Pet pet;
  final VoidCallback setFavorite;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    pet.images![0],
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pet.name ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: mainColor,
                            ),
                          ),
                        ),
                        Icon(
                          pet.gender == "M" ? Icons.male : Icons.female,
                          color: mainColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(pet.age.toString()),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text("Years"),
                      ],
                    ),
                    Text(pet.breed ?? "Sem raça"),
                    Text("Cor: ${pet.color} "),
                  ],
                ),
              ),
            ],
          ),
          /*
          Positioned(
              right: 0,
              child: IconButton(
                  onPressed: setFavorite,
                  icon: Icon(
                    pet.favorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_sharp,
                    color: pet.favorite ? mainColor : Colors.white,
                  ))),

                  */
        ],
      ),
    );
  }
}
