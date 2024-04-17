import 'package:darth_flutter/shop/shop-potion-view.dart';
import 'package:flutter/material.dart';

import '../service/model/adventure_models.dart';

class ShopWidget extends StatelessWidget {
  final Paragraph paragraph;

  const ShopWidget({required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/shop/potions-shop-background.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            child: const Text("Potiony"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopPotionWidget(paragraph: paragraph),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
