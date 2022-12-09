import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musik/internal/utils/app_assets.dart';
import 'package:musik/provider/music_card_provider.dart';
import 'package:musik/widgets/music_item.dart';

import '../../internal/utils/style.dart';
import '../../model/song.dart';
import '../../provider/playlist_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final playlist = ref.watch(playlistProvider).value;

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              'Search',
              style: AppTextStyle.bold.copyWith(
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () => showSearchDelegate(playlist ?? []),
                icon: Image.asset(AppIcons.icSearch),
                iconSize: 24,
              ),
            ],
            centerTitle: true,
          ),
          body: Center(
            child: Text('Search'),
          ),
        );
      },
    );
  }

  void showSearchDelegate(List<Song> data) {
    showSearch(
      context: context,
      delegate: MusicSearchDelegate(data),
    );
  }
}

class MusicSearchDelegate extends SearchDelegate {
  final List<Song> data;
  MusicSearchDelegate(this.data);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Song> matchQuery = querySong();

    return ListView.separated(
      itemCount: matchQuery.length,
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      itemBuilder: (context, index) {
        final song = matchQuery[index];
        return MusicItem(song: song);
      },
      separatorBuilder: (_, __) {
        return const Divider(
          color: Colors.black,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Song> matchQuery = querySong();

    return query.isNotEmpty
        ? ListView.builder(
            itemCount: matchQuery.length,
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
            ),
            itemBuilder: (context, index) {
              final song = matchQuery[index];
              return MusicItem(song: song);
            },
          )
        : const SizedBox.shrink();
  }

  List<Song> querySong() {
    return data
        .where((song) =>
            song.name.toLowerCase().contains(query.toLowerCase()) ||
            song.single.toString().toLowerCase().contains(query.toLowerCase()) ||
            song.author.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
