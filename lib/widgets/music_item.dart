import 'package:flutter/material.dart';

import '../internal/utils/style.dart';
import '../model/song.dart';

class MusicItem extends StatelessWidget {
  final Song song;
  const MusicItem({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(song.cover),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.name,
                style: AppTextStyle.medium.copyWith(fontSize: 16.0),
              ),
              Text(
                song.single,
                style: AppTextStyle.normal,
              ),
              Text(
                'Song id: ${song.id}',
                style: AppTextStyle.normal,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
