import 'package:flutter/material.dart';
// import 'package:jemmah_rellish/components/models/scrollCntrl.dart';
import 'package:jemmah_rellish/main.dart';
import 'package:jemmah_rellish/practical/catlogues.dart';
import 'package:jemmah_rellish/practical/post.dart';
import 'package:jemmah_rellish/practical/profile.dart';
import 'package:jemmah_rellish/practical/song.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  // final Scroller _scroller = Scroller();

  @override
  void initState() {
    super.initState();
    // _scroller.onScroll();
  }

  Menus currentIndex = Menus.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex.index],
      bottomNavigationBar:
          //  _scroller.scroll
          //     ? const SizedBox.shrink()
          //     :
          MybottomNavigator(
              onTap: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              currentIndex: currentIndex),
    );
  }
}

enum Menus { home, post, profile, music, catlogues }

final pages = [
  const Jehma(),
  const Posts(),
  const Profile(),
  const Song(),
  const Cartlogues()
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
            icon: const Icon(Icons.home_filled),
            color: currentIndex == Menus.home
                ? Colors.black
                : Colors.black.withOpacity(0.3),
          ),
          label: 'home',
        ),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () => onTap(Menus.post),
                icon: const Icon(Icons.post_add_rounded),
                color: currentIndex == Menus.post
                    ? Colors.black
                    : Colors.black.withOpacity(0.3)),
            label: 'post'),
        // BottomNavigationBarItem(
        //     icon: IconButton(
        //         onPressed: () => onTap(Menus.profile),
        //         icon: const Icon(Icons.person_pin),
        //         color: currentIndex == Menus.profile
        //             ? Colors.black
        //             : Colors.black.withOpacity(0.3)),
        //     label: 'me'),
        // BottomNavigationBarItem(
        //     icon: IconButton(
        //         onPressed: () => onTap(Menus.music),
        //         icon: const Icon(Icons.headphones_rounded),
        //         color: currentIndex == Menus.music
        //             ? Colors.black
        //             : Colors.black.withOpacity(0.3)),
        //     label: 'music'),
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () => onTap(Menus.catlogues),
                icon: const Icon(Icons.shopping_bag),
                color: currentIndex == Menus.catlogues
                    ? Colors.black
                    : Colors.black.withOpacity(0.3)),
            label: 'cart'),
      ],
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: const Color.fromARGB(255, 140, 152, 172),
    );
  }
}
