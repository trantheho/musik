import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../internal/utils/style.dart';
import '../model/song.dart';

class MusicCard extends StatefulWidget {
  final Song song;
  const MusicCard({Key? key, required this.song,}) : super(key: key);

  @override
  State<MusicCard> createState() => _MusicCardState();
}

class _MusicCardState extends State<MusicCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: clampDouble(widget.song.id.toDouble()/10, 1, 1),
      duration: const Duration(milliseconds: 250),
      child: Container(
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(widget.song.cover),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: const BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 15.0,),
                Text(
                  widget.song.name,
                  style: AppTextStyle.medium.copyWith(fontSize: 24.0),
                ),
                Text(
                  widget.song.single,
                  style: AppTextStyle.normal,
                ),
                Text(
                  'Song id: ${widget.song.id}',
                  style: AppTextStyle.normal,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayButton extends StatefulWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}


class MusicProgressBarWithCover extends StatefulWidget {
  const MusicProgressBarWithCover({Key? key}) : super(key: key);

  @override
  State<MusicProgressBarWithCover> createState() => _MusicProgressBarWithCoverState();
}

class _MusicProgressBarWithCoverState extends State<MusicProgressBarWithCover> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 300,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://thumbs.dreamstime.com/b/clown-listening-to-music-relaxing-35822021.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

