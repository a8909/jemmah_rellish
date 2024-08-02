import 'package:flutter/material.dart';

class SongModel {
  List songs = [];
  getSongs() {
    return songs;
  }

  bool lightMode = true;
  ThemeMode theme() {
    return lightMode ? ThemeMode.light : ThemeMode.dark;
  }
}
