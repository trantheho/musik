import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musik/internal/utils/style.dart';
import 'package:musik/widgets/player_controller.dart';

import '../../provider/music_card_provider.dart';
import '../../widgets/swipe_card.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with SingleTickerProviderStateMixin {
  final AudioPlayer audioPlayer = AudioPlayer();


  @override
  void initState() {
    audioPlayer.setLoopMode(LoopMode.one);
    super.initState();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Musik',
          style: AppTextStyle.bold.copyWith(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (_, ref, __) {
          final musicProvider = ref.watch(musicCardProvider)..initAudio(audioPlayer)..initialize();

          return Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Expanded(
                child: Stack(
                  children: musicProvider.currentPlayList.map(
                    (e) {
                      final bool lastItem = musicProvider.currentPlayList.first.id == e.id;
                      return SwipeCard(
                        song: e,
                        isLastItem: lastItem,
                      );
                    },
                  ).toList(),
                ),
              ),
              const PlayerController(),
              const SizedBox(
                height: 20.0,
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> onDispose() async {
    await audioPlayer.stop();
    audioPlayer.dispose();
  }
}
