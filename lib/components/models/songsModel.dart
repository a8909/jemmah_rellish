import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/playSong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongModel {
  Localstorage storage = Localstorage();
  List<Songs> songs = [
    Songs(
        songName: 'Stronger',
        artistName: 'Young jonn',
        albumImgPath: 'assets/image/p3.jpeg',
        audioPath: 'audioPath'),
    // Songs(
    //     songName: 'Higher',
    //     artistName: 'Burna boy',
    //     albumImgPath: 'assets/image/p4.jpeg',
    //     audioPath: 'audioPath'),
    // Songs(
    //     songName: 'Wrong Direction',
    //     artistName: 'Passenger',
    //     albumImgPath: 'assets/image/p5.jpeg',
    //     audioPath: 'audioPath')
  ];

  List<Songs> get playlist => songs;

  int? currentSongIndex;
  get songIndex => currentSongIndex;

  set currentSong(int? currentIndex) {
    currentSongIndex = currentIndex;
  }

  bool lightMode = false;
  currentMode(bool newmode) async {
    final SharedPreferences getTheme = await SharedPreferences.getInstance();

    lightMode = newmode;
    bool cu = lightMode;
    print(cu);
    final themes = await getTheme.setBool('mode', cu);
    print("themes: $themes");
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
