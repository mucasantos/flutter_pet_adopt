import 'package:flutter/material.dart';
import 'package:flutter_pet_adopt/view/revisao/model_ricky.dart';

class WidgetRicky extends StatelessWidget {
  const WidgetRicky({
    super.key,
    required this.rickNMorty,
  });

  final Result rickNMorty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 120,
      color: Colors.blue,
      child: Column(
        children: [
          Expanded(child: Image.network(rickNMorty.image, fit: BoxFit.fill,)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(rickNMorty.name),
                Text(rickNMorty.status.toString())
              ],
            ),
          )
        ],
      ),
    );
  }
}
