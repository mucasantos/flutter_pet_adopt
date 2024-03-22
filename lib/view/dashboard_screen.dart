import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/data/data_category.dart';
import 'package:flutter_pet_adopt/services/constants.dart';
import 'package:flutter_pet_adopt/view/filter_screen.dart';
import 'package:flutter_pet_adopt/view/pet_screen.dart';
import 'package:flutter_pet_adopt/widgets/category_widget.dart';
import 'package:flutter_pet_adopt/widgets/pet_container.dart';
import 'package:flutter_pet_adopt/widgets/sized_icon_image.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int? chipValue = 0;

  @override
  Widget build(BuildContext context) {
    final screenWitdth = MediaQuery.of(context).size.width;
    final int crossAxisCount = screenWitdth > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            userProfile,
          ),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning!",
                  style: TextStyle(
                    color: mainColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Samuel Santos",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                size: 30,
              ))
        ],
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height / 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedIconImage(
                          imageAsset: iconSearch,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const SizedIconImage(
                          imageAsset: iconVertical,
                          width: 3,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FilterScreen()),
                            );
                          },
                          child: const SizedIconImage(
                            imageAsset: iconFilter,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    labelText: 'Search',
                    contentPadding: const EdgeInsets.all(10),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 175, 175, 175),
                        width: 1,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 175, 175, 175),
                        width: 1,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xfff8f8f8),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryWidget(
                      image: categories[index].image,
                      index: index,
                      name: categories[index].name,
                      chipValue: chipValue,
                      onSelected: (bool selected) {
                        setState(() {
                          chipValue = selected ? index : null;
                        });
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.all(12.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.80,
                ),
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PetScreen()),
                        );
                      },
                      child: const PetContainer());
                }),
          ),
        ],
      ),
    );
  }
}
