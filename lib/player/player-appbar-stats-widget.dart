import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../player/player.dart';

class PlayerAppBarStatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Player>(
      builder: (context, player, child) {
        return Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(player.avatarUrl),
              radius: 20.0,
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20.0,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'HP: ${player.hp}',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.amber,
                      size: 20.0,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Coins: ${player.coins}',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
