import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/playSong.dart';

class SongModel {
  Localstorage storage = Localstorage();
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

  bool lightMode = false;
  currentMode(bool newmode) async {
    lightMode = newmode;
    bool cu = lightMode;
    print(cu);
    final val = await storage.switching('mode', true);
    print(val);
  }

  get thm => lightMode;

  ThemeData light = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
          surface: Colors.grey.shade50,
          primary: Colors.grey.shade900,
          secondary: Colors.grey.shade200));
  ThemeData darkMode = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
          surface: Colors.grey.shade900,
          primary: Colors.grey.shade500,
          secondary: Colors.grey.shade700));
}
