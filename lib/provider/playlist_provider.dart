import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/song.dart';

const jsonFile = 'assets/json/data.json';

final playlistProvider = FutureProvider<List<Song>>((ref) async {
  final response = await rootBundle.loadString('assets/json/data.json');
  final data = json.decode(response);
  final playlist = List<Song>.from(data['playlist'].map((e) => Song.fromJson(e)));

  return playlist;
});