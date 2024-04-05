import 'package:darth_flutter/shop/shop-potion-view.dart';
import 'package:flutter/material.dart';

import '../service/model/adventure_models.dart';

class ShopWidget extends StatelessWidget {
  final Paragraph paragraph;

  const ShopWidget({required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SKLEP")),
      body: Center(
          child: ElevatedButton(
        child: const Text("Potiony"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPotionWidget(paragraph: paragraph)));
        },
      )),
    );
    throw UnimplementedError();
  }
}
