import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';

import 'package:jemmah_rellish/practical/neuBox.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final SongModel sngmodel = SongModel();
  late var newsng;
  late var _playingList;

  @override
  void initState() {
    super.initState();

    newsng = sngmodel.songIndex;
    _playingList = sngmodel.playlist[newsng];
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
                    Image.asset(_playingList.albumImgPath),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _playingList.songName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _playingList.artistName,
                              )
                            ],
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
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
                        child: NeuBox(
                            child: const Padding(
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
                                  sngmodel.pauseResume(_playingList.audioPath);
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
                        child: NeuBox(
                            child: const Padding(
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
