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
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              stretch: true,
              flexibleSpace: CarouselSlider(
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
                (BuildContext context, int index) => const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Name Pet",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.male,
                                color: mainColor,
                                size: 25,
                              ),
                            ],
                          ),
                          Text("2 years"),
                        ],
                      ),
                    ),
                    Row(
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
                    SizedBox(
                      height: 20,
                    ),
                    Text("My Story"),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                          "Legs foi resgatada em Itaquaquecetuba, atropelada, duas patas quebradas. Chovia muito naquele dia. Encontrei ela jogada num canto de uma estradinha de terra, ensopada. Tremia muito, não sei se de medo, frio, dor, ou tudo isso junto. Aquela cachorra porte grande, pelo grosso e desgranhado, preta , de olhar assustado, não resistiu um minuto aos movimentos para colocá-la no carro. Enquanto eu saia com o carro me dei conta de que era 20 de dezembro, e que eu não tinha onde hospedá-la. Devido às festas de fim de ano, os hotéis e creches estão lotado e eu não tinha  vaga no Santo Pet."),
                    ),
                    AppButton(),
                    SizedBox(
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

    /*
      body: Column(
        mainAxisSize: MainAxisSize.min,
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
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
              Positioned(
                  top: 10,
                  left: 0,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_left_outlined,
                        color: mainColor,
                        size: 60,
                      ))),
            ],
          ),
          Padding(
            padding:  EdgeInsets.all(16.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
      
                  children: [
                  Text(
                  "Name Pet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: mainColor,
                  ),
                ),
                SizedBox(width: 5,),
                 Icon(
                          Icons.male,
                          color: mainColor,
                          size: 25,
                        ),
                ],),
                Text("2 years"),
              ],
            ),
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
                    Text("My Story"),
                    Expanded(child: Text("Legs foi resgatada em Itaquaquecetuba, atropelada, duas patas quebradas. Chovia muito naquele dia. Encontrei ela jogada num canto de uma estradinha de terra, ensopada. Tremia muito, não sei se de medo, frio, dor, ou tudo isso junto. Aquela cachorra porte grande, pelo grosso e desgranhado, preta , de olhar assustado, não resistiu um minuto aos movimentos para colocá-la no carro. Enquanto eu saia com o carro me dei conta de que era 20 de dezembro, e que eu não tinha onde hospedá-la. Devido às festas de fim de ano, os hotéis e creches estão lotado e eu não tinha  vaga no Santo Pet.")),
      
          const AppButton(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  
  */
  }
}
