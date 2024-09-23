import 'package:flutter/material.dart';

import '../components/localStorage.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer(); // Close the drawer
                },
                icon: const Icon(Icons.cancel_rounded),
              ),
            ),
            const SizedBox(height: 100),
            drawerTabs(() {
              // Handle Profile tap
              onPageNavigation(context, '/Profile'); // Example route
            }, Icons.person_3_rounded, 'Profile'),
            const SizedBox(height: 30),
            drawerTabs(() {
              // Handle Playlist tap
              onPageNavigation(context, '/Playlist'); // Example route
            }, Icons.headset_rounded, 'Playlist'),
            const SizedBox(height: 10),
            drawerTabs(() {
              // Handle Map tap
              onPageNavigation(context, '/Map'); // Example route
            }, Icons.location_on_rounded, 'Map'),
            const SizedBox(height: 10),
            drawerTabs(() {
              // Handle Support Agent tap
              onPageNavigation(context, '/Support'); // Example route
            }, Icons.support_agent_rounded, 'Support Agent'),
            const Spacer(),
            drawerTabs(() async {
              // Handle Logout tap
              // Perform logout actions here
              isLogOut = true;
              if (isLogOut) {
                await _storage.remove('auth').whenComplete(
                  () {
                    Navigator.of(context).pushNamed('/Login');
                    isLogOut = false;
                  },
                );
              }
              ; // Example route
            }, Icons.logout_rounded, 'Logout'),
          ],
        ),
      ),
    );
  }
}

Widget drawerTabs(Function()? onTap, IconData icon, String tabName) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(tabName),
      ],
    ),
  );
}
