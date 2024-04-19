import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/services/http_connect.dart';
import 'package:flutter_pet_adopt/view/revisao/model_ricky.dart';
import 'package:flutter_pet_adopt/view/revisao/widget_ricky.dart';

class ReviewApiCall extends StatefulWidget {
  const ReviewApiCall({super.key});

  @override
  State<ReviewApiCall> createState() => _ReviewApiCallState();
}

class _ReviewApiCallState extends State<ReviewApiCall> {
  List<Result>? rickDataList;
  int page = 5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Aula revisão (Pg.$page)"),
        ),
        body: Center(
          child: Column(
            children: [
              if (rickDataList != null)
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(12.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.80,
                      ),
                      itemCount:
                          rickDataList?.length, //passar o tam da minha lista!
                      itemBuilder: (BuildContext context, int index) {
                        return WidgetRicky(rickNMorty: rickDataList![index]);
                      }),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var dataResult = await HttpConnect.getData(
              endpoint: "api/character/", page: page
            );

            ModelRicky rickData = ModelRicky.fromJson(dataResult);

            setState(() {
              if (page <= rickData.info.pages){
                page++;
              }
              
              rickDataList = rickData.results;
            });

          },
          child: const Icon(
            Icons.contactless_outlined,
            size: 35,
          ),
        ),
      ),
    );
  }
}
