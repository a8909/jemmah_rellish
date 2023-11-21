import 'package:flutter/material.dart';
import 'package:jemmah_rellish/main.dart';
import 'package:jemmah_rellish/practical/instagram.dart';
import 'package:jemmah_rellish/practical/post.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
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
  chat,
}

final pages = [
  const Jehma(),
  Posts(),
  const Insta(),
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
                onPressed: () => onTap(Menus.chat),
                icon: const Icon(Icons.chat_sharp),
                color: currentIndex == Menus.chat
                    ? Colors.black
                    : Colors.black.withOpacity(0.3)),
            label: 'me'),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.blueAccent,
    );
  }
}
