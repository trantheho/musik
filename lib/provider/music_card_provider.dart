import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../model/player_data.dart';
import '../model/song.dart';
import 'playlist_provider.dart';

final musicCardProvider = ChangeNotifierProvider<MusicCardNotifier>((ref){
  final playlist = ref.watch(playlistProvider).value;
  return MusicCardNotifier(playlist ?? []);
});

enum CardStatus {
  like,
  dislike,
  none,
}

enum SwipeDirection{
  left,
  right,
  up,
  down,
  none,
}

class MusicCardNotifier extends ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();
  List<Song> _playlist = [];
  List<Song> _songlist = [];
  List<Song> favoritePlayList = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;

  Offset get position => _position;

  bool get isDragging => _isDragging;

  double get angle => _angle;

  List<Song> get currentPlayList => _playlist;

  Song? get currentSong => _playlist.isNotEmpty ? _playlist.last : null;

  Stream<PlayerData> get playerDataStream => Rx.combineLatest2<Duration, Duration?, PlayerData>(
      audioPlayer.positionStream, audioPlayer.durationStream, (position, duration) => PlayerData(position: position, duration: duration ?? Duration.zero));

  MusicCardNotifier(List<Song> playlist) {
    _playlist.addAll(playlist);
    _songlist.addAll(playlist);
  }

  Future<void> initialize() async {
    await playAudio();
  }

  void initAudio(AudioPlayer player){
    audioPlayer = player;
  }

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition() async {
    _isDragging = false;
    notifyListeners();
    final status = getStatus();
    updateNextSong(status!);

    switch (status) {
      case SwipeDirection.right:
      case SwipeDirection.up:
        like();
        break;
      case SwipeDirection.left:
      case SwipeDirection.down:
        dislike();
        break;
      default:
        resetPosition();
    }
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  CardStatus? getCardStatus() {
    final x = _position.dx;
    final y = _position.dy;
    const delta = 50;

    if (x >= delta || (y <= -delta / 2 && x.abs() < 20)) {
      return CardStatus.like;
    }

    if(x <= -delta || y >= delta){
      return CardStatus.dislike;
    }

    return CardStatus.none;
  }

  SwipeDirection? getStatus() {
    final x = _position.dx;
    final y = _position.dy;
    const delta = 50;

    if(x>= delta){
      return SwipeDirection.right;
    }

    if((y <= -delta / 2 && x.abs() < 20)){
      return SwipeDirection.up;
    }

    if(x <= -delta){
      return SwipeDirection.left;
    }

    if(y >= delta){
      return SwipeDirection.down;
    }

    return SwipeDirection.none;
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(2 * _screenSize.width, 0);
    _nextAudio();
    notifyListeners();
  }

  void like() {
    _angle = 20;
    _position += Offset(2 * _screenSize.width, 0);
    _nextAudio();
    notifyListeners();
  }

  Future<void> _nextAudio() async {
    if (_playlist.isEmpty) return;
    await Future.delayed(const Duration(milliseconds: 250));
    await playAudio();
    resetPosition();
  }

  Future<void> playAudio() async{
    if(_playlist.isNotEmpty){
      await audioPlayer.setAsset(_playlist.last.asset);
      await audioPlayer.play();
    }
  }

  void updateNextSong(SwipeDirection swipeDirection){
    final song = _nextSong(swipeDirection, _playlist.last.id);
    _playlist.removeLast();
    _playlist.add(song);
    notifyListeners();
  }

  Future<void> playFavoriteAudio(int index) async{
    if(favoritePlayList.isNotEmpty){
      await audioPlayer.setAsset(favoritePlayList[index].asset);
      await audioPlayer.play();
    }
  }

  Future<void> initFavoriteAudio() async{
    if(favoritePlayList.isNotEmpty){
      await audioPlayer.setAsset(favoritePlayList[0].asset);
    }
  }

  Future<void> togglePlay(bool value) async {
    if(value){
      await audioPlayer.pause();
    }
    else{
      await audioPlayer.play();
    }
  }

  Song _nextSong(SwipeDirection swipeDirection, int currentSongId){
    switch(swipeDirection){
      case SwipeDirection.left:
        final modId = Random().nextInt(10) % _songlist.length;
        final nextSongId = currentSongId - 1 + modId;
        final song = _getSong(nextSongId);
        return song;
      case SwipeDirection.right:
        favoritePlayList.add(currentSong!);
        final modId = Random().nextInt(10) % _songlist.length;
        final nextSongId = currentSongId + 1 + modId;
        final song = _getSong(nextSongId);
        return song;
      case SwipeDirection.up:
        favoritePlayList.add(currentSong!);
        final nextSongId = currentSongId * 2 % _songlist.length;
        final song = _getSong(nextSongId);
        return song;
      case SwipeDirection.down:
        final nextSongId = currentSongId ~/ 2;
        final song = _getSong(nextSongId);
        return song;
      default:
        return _playlist[_playlist.length -2];
    }
  }

  Song _getSong(int songId){
    return _songlist.firstWhere((element) => element.id == songId, orElse: (){
      return _playlist[_playlist.length -2];
    });
  }
}