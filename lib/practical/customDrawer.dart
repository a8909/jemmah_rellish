import 'package:flutter/material.dart';
import '../components/localStorage.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});
  bool isLogOut = false;
  final Localstorage _storage = Localstorage();

  void onPageNavigation(BuildContext context, String path) {
    Navigator.of(context).pushNamed(path);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer(); // Close the drawer
                },
                child: const Text('Dismiss'),
              ),
            ),
            const SizedBox(height: 100),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Welcome back Oxide!')),
            const SizedBox(height: 10),
            drawerTabs(() {
              // Handle Profile tap
              onPageNavigation(context, '/Profile'); // Example route
            }, Icons.person_3_rounded, 'Profile', false),
            drawerTabs(() {
              // Handle Playlist tap
              onPageNavigation(context, '/Playlists'); // Example route
            }, Icons.headset_rounded, 'Playlist', true),
            drawerTabs(() {
              // Handle Map tap
              onPageNavigation(context, '/Map'); // Example route
            }, Icons.location_on_rounded, 'Map', true),
            drawerTabs(() {
              // Handle Support Agent tap
              onPageNavigation(context, '/Support'); // Example route
            }, Icons.support_agent_rounded, 'Support Agent', true),
            const Spacer(),
            drawerTabs(() async {
              // Handle Logout tap
              // Perform logout actions here
              isLogOut = true;
              if (isLogOut) {
                await _storage.logOut('auth').whenComplete(
                  () {
                    Navigator.of(context).pushNamed('/Login');
                    isLogOut = false;
                  },
                );
              }
              // Example route
            }, Icons.logout_rounded, 'Logout', true),
          ],
        ),
      ),
    );
  }
}

Widget drawerTabs(Function()? onTap, IconData icon, String tabName, bool? key) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(tabName),
          ],
        ),
        SizedBox(key: GlobalObjectKey(key!), height: key ? 10 : 30)
      ],
    ),
  );
}
