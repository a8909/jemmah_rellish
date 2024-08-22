import 'package:flutter/material.dart';
import 'package:jemmah_rellish/main.dart';
import 'package:jemmah_rellish/practical/post.dart';
import 'package:jemmah_rellish/practical/profile.dart';
// import 'package:jemmah_rellish/practical/song.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  @override
  void initState() {
    super.initState();

    print('user has loggee in');
  }

  Menus currentIndex = Menus.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex.index],
      bottomNavigationBar: MybottomNavigator(
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex),
    );
  }
}

enum Menus {
  home,
  add,
  profile,
  // music
}

final pages = [
  const Jehma(), Posts(),
  const Insta(),
  // Song()
];

class MybottomNavigator extends StatelessWidget {
  final ValueChanged<Menus> onTap;
  final Menus currentIndex;
  const MybottomNavigator(
      {super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => onTap(Menus.home),
            icon: const Icon(Icons.home),
            color: currentIndex == Menus.home
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () => onTap(Menus.add),
                icon: const Icon(Icons.add),
                color: currentIndex == Menus.add
                    ? Colors.black
                    : Colors.black.withOpacity(0.3)),
            label: 'add'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () => onTap(Menus.profile),
                icon: const Icon(Icons.person_2_outlined),
                color: currentIndex == Menus.profile
                    ? Colors.black
                    : Colors.black.withOpacity(0.3)),
            label: 'me')
        //     BottomNavigationBarItem(
        //         icon: IconButton(
        //             onPressed: () => onTap(Menus.music),
        //             icon: const Icon(Icons.music_note),
        //             color: currentIndex == Menus.music
        //                 ? Colors.black
        //                 : Colors.black.withOpacity(0.3)),
        //         label: 'music'),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.blueAccent,
    );
  }
}
