import 'package:audioplayers/audioplayers.dart';
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
        albumImgPath: 'assets/image/youngJonn.jpeg',
        audioPath: 'Young-Jonn-Stronger-(TrendyBeatz.com).mp3'),
    Songs(
        songName: 'Higher',
        artistName: 'Burna boy',
        albumImgPath: 'assets/image/burna.jpeg',
        audioPath: 'Burna-Boy-Higher-(TrendyBeatz.com).mp3'),
    Songs(
        songName: 'Awolowo',
        artistName: 'Passenger',
        albumImgPath: 'assets/image/awolowo.jpeg',
        audioPath: 'assets/audios/Fido-Awolowo-(TrendyBeatz.com).mp3')
  ];

  List<Songs> get playlist => songs;

  int? currentSongIndex;

  set currentSong(int? newSong) {
    currentSongIndex = newSong;
  }

  get songIndex => currentSongIndex;

  bool lightMode = false;

  set themes(bool newTheme) {
    lightMode = newTheme;
  }

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

  final AudioPlayer audioplayer = AudioPlayer();
  bool isPlaying = false;
  Duration? _duration;
  Duration? _position;

  void play(String path) async {
    isPlaying = true;
    await audioplayer.play(AssetSource(path));
  }

  void pause() async {
    isPlaying = false;
    await audioplayer.pause();
  }

  void pauseResume(String musicPath) {
    isPlaying ? play(musicPath) : pause();
  }
}
