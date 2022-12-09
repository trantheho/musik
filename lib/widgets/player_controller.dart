import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musik/internal/utils/app_assets.dart';

import '../internal/utils/format_duration.dart';
import '../internal/utils/style.dart';
import '../model/player_data.dart';
import '../provider/music_card_provider.dart';

class PlayerController extends StatelessWidget {
  const PlayerController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final musicProvider = ref.watch(musicCardProvider);

        return Column(
          children: [
            _buildMusicSlider(musicProvider),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: null, icon: Image.asset(AppIcons.icShuffle,)),
                StreamBuilder<bool>(
                  stream: musicProvider.audioPlayer.playingStream,
                  initialData: false,
                  builder: (context, snapshot) {
                    final bool isStop = musicProvider.audioPlayer.position.inSeconds == musicProvider.audioPlayer.duration?.inSeconds;
                    //debugPrint('$isStop');
                    if(snapshot.hasData){
                      return IconButton(
                          onPressed: () => musicProvider.togglePlay(snapshot.data!),
                          icon: Image.asset(snapshot.data! && !isStop ? AppIcons.icPause : AppIcons.icPlay,),
                      );
                    }

                    return Image.asset(AppIcons.icPlay,);
                  }
                ),
                IconButton(onPressed: null, icon: Image.asset(AppIcons.icRepeat,)),
              ],
            ),
          ],
        );
      },
    );
  }


  Widget _buildMusicSlider(MusicCardNotifier musicProvider) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32,),
      child: StreamBuilder<PlayerData>(
          stream: musicProvider.playerDataStream,
          builder: (context, playerStream) {
            return Row(
              children: <Widget>[
                SizedBox(
                  width: 40,
                  child: Text(
                    formatDuration(
                        playerStream.data?.position ?? Duration.zero,
                        true),
                    style: AppTextStyle.normal.copyWith(fontSize: 12,),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: playerStream.data?.position.inSeconds.toDouble() ?? 0,
                    min: 0,
                    max: playerStream.data?.duration.inSeconds.toDouble() ?? 0,
                    activeColor: Colors.black,
                    thumbColor: Colors.tealAccent,
                    inactiveColor: Colors.blueGrey,
                    onChanged: null,
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Text(
                    formatDuration(playerStream.data?.duration ?? const Duration(seconds: 0), true),
                    style: AppTextStyle.normal.copyWith(fontSize: 12,),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
