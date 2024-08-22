import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/playSong.dart';

class SongModel {
  List<Songs> songs = [
    Songs(
        songName: 'songName',
        artistName: 'artistName',
        albumImgPath: 'albumImgPath',
        audioPath: 'audioPath'),
    Songs(
        songName: 'songName',
        artistName: 'artistName',
        albumImgPath: 'albumImgPath',
        audioPath: 'audioPath'),
    Songs(
        songName: 'songName',
        artistName: 'artistName',
        albumImgPath: 'albumImgPath',
        audioPath: 'audioPath')
  ];

  List<Songs> get playlist => songs;

  int? currentSongIndex;
  // get songIndex => currentSongIndex;

  set currentSong(int? currentIndex) {
    currentSongIndex = currentIndex;
  }

  bool lightMode = true;

  displayTheme() {
    _mode ? ThemeData.dark() : ThemeData.light();
  }

  get _mode => lightMode;
}
