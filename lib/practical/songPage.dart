import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';

import 'package:jemmah_rellish/practical/neuBox.dart';

class SongPage extends StatefulWidget {
  final int index;
  const SongPage({super.key, required this.index});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final SongModel sngmodel = SongModel();
  final GlobalColors _color = GlobalColors();
  late var playingList;
  bool favourite = false;

  @override
  void initState() {
    super.initState();
    playingList = sngmodel.playlist[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                const Text(
                  'P L A Y L I S T',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.menu)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
            child: NeuBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 5),
                child: Column(
                  children: [
                    Hero(
                        tag: playingList.albumImgPath,
                        child: Image.asset(playingList.albumImgPath)),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playingList.songName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                playingList.artistName,
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                favourite = !favourite;
                              });
                            },
                            child: Icon(
                              favourite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: favourite ? _color.danger : Colors.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0:00'),
                    Icon(Icons.shuffle),
                    Icon(Icons.repeat),
                    Text('0:00')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0)),
            child: Slider(
              min: 0,
              max: 100,
              activeColor: GlobalColors().success,
              value: 50,
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {},
                        child: const NeuBox(
                            child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.skip_previous),
                        )))),
                const SizedBox(width: 20),
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                        onTap: () {},
                        child: NeuBox(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sngmodel.isPlaying = !sngmodel.isPlaying;
                                  sngmodel.pauseResume(playingList.audioPath);
                                });
                              },
                              child: Icon(sngmodel.isPlaying
                                  ? Icons.play_arrow
                                  : Icons.pause)),
                        )))),
                const SizedBox(width: 20),
                Expanded(
                    child: GestureDetector(
                        onTap: () {},
                        child: const NeuBox(
                            child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.skip_next),
                        )))),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
