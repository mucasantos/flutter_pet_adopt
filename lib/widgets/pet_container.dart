import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/constants.dart';

class PetContainer extends StatelessWidget {
  const PetContainer({
    super.key,
  });

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
                  child: Image.asset(
                    'assets/images/dog1.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Kuggu",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                        Icon(
                          Icons.male,
                          color: mainColor,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("2"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Years"),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Mixed Breed | "),
                        Text("Adult"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.place_outlined),
                        Text("2.7Km"),
                        Text("Away"),
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
