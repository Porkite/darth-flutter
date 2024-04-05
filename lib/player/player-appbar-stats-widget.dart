import 'package:darth_flutter/player/player.dart';
import 'package:flutter/material.dart';


// TODO naprawić błąd: A RenderFlex overflowed by 106 pixels on the right.
class PlayerAppBarStatsWidget extends StatelessWidget {
  final Player player;

  PlayerAppBarStatsWidget({required this.player});

  @override
  Widget build(BuildContext context) {
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
                  overflow: TextOverflow.ellipsis,
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
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
