import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/playSong.dart';

class SongModel {
  final Localstorage _storage = Localstorage();
  List<Songs> songs = [
    Songs(
        songName: 'Stronger',
        artistName: 'Young jonn',
        albumImgPath: 'assets/image/youngJonn.jpeg',
        audioPath: 'assets/audios/Young-Jonn-Stronger-(TrendyBeatz.com).mp3'),
    Songs(
        songName: 'Higher',
        artistName: 'Burna boy',
        albumImgPath: 'assets/image/burna.jpeg',
        audioPath: 'assets/audios/Burna-Boy-Higher-(TrendyBeatz.com).mp3'),
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

  set themes(bool newTheme)  {
    lightMode = newTheme;
    savedModeState(lightMode);
    
  }
  // saving the state of the application theme..
  void savedModeState(value) async {
    await _storage.modeSwitching('switchKey', value);
  }

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
  // Duration? _duration;
  // Duration? _position;

  void play(String path) async {
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
