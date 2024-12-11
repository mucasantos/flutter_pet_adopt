import 'package:carousel_slider/carousel_slider.dart';
// Places where you have syntax error then just do this
import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/app_data/constants.dart';
import 'package:flutter_pet_adopt/models/pet.dart';
import 'package:flutter_pet_adopt/widgets/app_button.dart';
import 'package:flutter_pet_adopt/widgets/pet_info_container.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              stretch: true,
              flexibleSpace: CarouselSlider(
                options: CarouselOptions(
                  autoPlayInterval: const Duration(seconds: 2),
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * .44,
                  autoPlay: pet.images!.length > 1,
                ),
                items: pet.images!.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        image,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      );
                    },
                  );
                }).toList(),
              ),
              floating: true,
              snap: true,
              expandedHeight: 300.0,
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      }, body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          // The "controller" and "primary" members should be left unset, so that
          // the NestedScrollView can control this inner scroll view.
          // If the "controller" property is set, then this scroll view will not
          // be associated with the NestedScrollView.
          slivers: <Widget>[
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverFixedExtentList(
              itemExtent: MediaQuery.of(context).size.height,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                pet.name!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(pet.gender == null ? '' : ''),
                              const Icon(
                                Icons.male,
                                color: mainColor,
                                size: 25,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PetInfoContainer(
                          title: pet.breed == null
                              ? 'Sem raça'
                              : pet.age!.toString(),
                          info: 'Raça',
                        ),
                        PetInfoContainer(
                          title: '${pet.age!} anos',
                          info: 'Idades',
                        ),
                        const PetInfoContainer(
                          title: 'Fit',
                          info: 'Health',
                        ),
                        PetInfoContainer(
                          title: '${pet.weight!}kg',
                          info: 'Peso',
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.place_outlined),
                          Text("2.7Km"),
                          Text("Away"),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "My Story",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        pet.story ?? "",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "My Qualities",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PetInfoContainer(info: "Good with kids"),
                          PetInfoContainer(info: "Healthy"),
                          PetInfoContainer(info: "House-trained"),
                          PetInfoContainer(info: "Knows commands"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                      title: "Adopte me",
                      onclick: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                childCount: 1,
              ),
            ),
          ],
        );
      })),
    );
  }
}
