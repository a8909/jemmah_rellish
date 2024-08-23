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
    _mode ? darkMode : light;
  }

  get _mode => lightMode;

  ThemeData light = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
          surface: Colors.grey.shade400,
          primary: Colors.grey.shade300,
          secondary: Colors.grey.shade200));
  ThemeData darkMode = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade800,
          secondary: Colors.grey.shade700));
}
