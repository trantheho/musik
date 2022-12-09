import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musik/internal/utils/style.dart';
import 'package:musik/widgets/player_controller.dart';

import '../../model/song.dart';
import '../../provider/music_card_provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final AudioPlayer audioPlayer = AudioPlayer();


  @override
  void dispose() {
    audioPlayer.dispose();
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
          'Favorite',
          style: AppTextStyle.bold.copyWith(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final musicProvider = ref.watch(musicCardProvider)..initAudio(audioPlayer)..initFavoriteAudio();

          return musicProvider.favoritePlayList.isNotEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FavoriteList(
                      list: musicProvider.favoritePlayList,
                      onSongChanged: (index, _){
                        musicProvider.playFavoriteAudio(index);
                      },
                    ),
                    const PlayerController(),
                  ],
                )
              : Center(
                  child: Text(
                    'No song',
                    style: AppTextStyle.medium,
                  ),
                );
        },
      ),
    );
  }
}

class FavoriteList extends StatefulWidget {
  final Function(int, CarouselPageChangedReason)? onSongChanged;
  final List<Song> list;

  const FavoriteList({
    Key? key,
    required this.list,
    this.onSongChanged,
  }) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  final ValueNotifier<int> indexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: MediaQuery.of(context).size.width / 150,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  aspectRatio: MediaQuery.of(context).size.width / 150,
                  enlargeCenterPage: true,
                  onPageChanged: (index, _){
                    indexNotifier.value = index;
                    widget.onSongChanged!(index, _);
                  },
              ),
              items: widget.list.map((e) => _buildingImageItem(context, e.cover)).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ValueListenableBuilder<int>(
            valueListenable: indexNotifier,
            builder: (_, index, __) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.list[index].name,
                    style: AppTextStyle.bold.copyWith(
                      fontSize: 26,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.list[index].single,
                    style: AppTextStyle.normal,
                  ),
                ],
              );
            }),
      ],
    );
  }

  Widget _buildingImageItem(BuildContext context, String url) {
    return AspectRatio(
      aspectRatio: MediaQuery.of(context).size.width / 150,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
