import 'package:darth_flutter/shop/shop.dart';
import 'package:flutter/material.dart';

import '../service/model/adventure_models.dart';

class ShopWidget extends StatefulWidget {
  final Paragraph paragraph;

  const ShopWidget({required this.paragraph});

  @override
  State<ShopWidget> createState() => _ShopView();
}

class _ShopView extends State<ShopWidget> {
  late Shop _shop;

  @override
  void initState() {
    super.initState();
    _shop = Shop.fromParagraph(widget.paragraph);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(_shop.assistantImg),
          radius: 40,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            _shop.welcomeText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _shop.potions.length,
            itemBuilder: (context, index) {
              var potion = _shop.potions[index];
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    potion.img,
                    width: 64,
                    height: 64,
                  ),
                  title: Text(potion.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        potion.description,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Efekty:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      ...potion.effects
                          .map(
                            (effect) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '• ',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(effect),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                      SizedBox(height: 4),
                      Text(
                        'Cena: ${potion.price} złociszy',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                      onPressed: () {},
                      child: Text('Chluśniem!',
                          style: TextStyle(color: Colors.black))),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
