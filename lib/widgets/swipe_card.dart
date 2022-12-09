import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musik/widgets/music_card.dart';

import '../model/song.dart';
import '../provider/music_card_provider.dart';
import 'tag.dart';

enum Swipe {
  left,
  right,
  up,
  down,
  none,
}

class SwipeCard extends StatefulWidget {
  final Song song;
  final bool isLastItem;

  const SwipeCard({
    Key? key,
    required this.song,
    required this.isLastItem,
  }) : super(key: key);

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: buildFront(),
        /*child: !widget.isLastItem ? buildFront() : MusicCard(
          song: widget.song,
        ),*/
      ),
    );
  }

  Widget buildFront() {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final provider = ref.watch(musicCardProvider);
        provider.setScreenSize(MediaQuery.of(context).size);

        return GestureDetector(
          child: LayoutBuilder(builder: (context, constraints) {
            final position = provider.position;
            final milliseconds = provider.isDragging ? 0 : 400;
            final center = constraints.smallest.center(Offset.zero);
            final angle = provider.angle * pi / 180;
            final status = provider.getCardStatus();
            final rotatedMatrix = Matrix4.identity()
              ..translate(center.dx, center.dy)
              ..rotateZ(angle)
              ..translate(-center.dx, -center.dy);
            return AnimatedContainer(
              curve: Curves.easeInOut,
              duration: Duration(microseconds: milliseconds),
              transform: rotatedMatrix..translate(position.dx, position.dy),
              child: Stack(
                children: [
                  MusicCard(
                    song: widget.song,
                  ),
                  if (status == CardStatus.like)
                    Positioned(
                      top: 60,
                      left: 50,
                      child: Transform.rotate(
                        angle: 12,
                        child: const Tag(
                          text: 'Like',
                          tagColor: Colors.green,
                        ),
                      ),
                    ),
                  if (status == CardStatus.dislike)
                    Positioned(
                      top: 70,
                      right: 44,
                      child: Transform.rotate(
                        angle: -12,
                        child: const Tag(
                          text: 'Dislike',
                          tagColor: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
          onPanStart: (details) {
            provider.startPosition(details);
          },
          onPanUpdate: (details) {
            provider.updatePosition(details);
          },
          onPanEnd: (details) {
            provider.endPosition();
          },
        );
      },
    );
  }
}
