import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/playSong.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';

import 'songPage.dart';

class Song extends StatefulWidget {
  const Song({super.key});

  @override
  State<Song> createState() => _SongState();
}

final SongModel sng = SongModel();

class _SongState extends State<Song> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green.shade500,
            foregroundColor: Colors.white,
            elevation: 1,
            title: const Center(child: Text('P L A Y L I S T'))),
        body: ListView.builder(
          itemCount: sng.songs.length,
          itemBuilder: (context, index) {
            final Songs s = sng.songs[index];
            return ListTile(
              leading: Hero(
                tag: s.albumImgPath,
                child: Image.asset(s.albumImgPath)),
              title: Text(s.songName),
              subtitle: Text(s.artistName),
              onTap: () {
                sng.currentSong = index;
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SongPage(index: index);
                  },
                ));
              },
            );
          },
        ));
  }
}
