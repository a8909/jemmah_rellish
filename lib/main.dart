import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/Server.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';
import 'package:jemmah_rellish/practical/Forgotpass.dart';
import 'package:jemmah_rellish/practical/Login.dart';
import 'package:jemmah_rellish/practical/notification.dart';
import 'package:jemmah_rellish/practical/screens.dart';
import 'package:jemmah_rellish/practical/sign.dart';
// import 'package:jemmah_rellish/practical/explore.dart';

import 'practical/Globalstring.dart';
import 'practical/class.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final songTheme = SongModel();

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: songTheme.lightMode ? ThemeData.light() : ThemeData.dark(),
      themeMode: songTheme.lightMode ? ThemeMode.light : ThemeMode.dark,
      // darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Login(),
        jem: (context) => const Jehma(),
        scr: (context) => const Screens(),
        pswrd: (context) => Forgot(),
        notifi: (context) => const Not(),
        sign: (context) => Signup(),
      },
    );
  }
}

class Jehma extends StatefulWidget {
  const Jehma({super.key});

  @override
  State<Jehma> createState() => _JehmaState();
}

class _JehmaState extends State<Jehma> {
  final List<String> editor = [
    "Editor's chioce",
    'November for Eriayo',
    'The pay Day',
    'Christmas delicacies',
    "New year's Eve",
  ];
  final List<String> title = [
    'The Art of Dough',
    'Priceless Gem',
    'Securing the Bag',
    'Party with Lunchaexchange',
    'Kronyx fun time',
  ];
  final List<String> content = [
    "Learn how to make the perfect bread",
    'Celebrate HER',
    'Hands on Trade & code ',
    'Flex with Team',
    'A Big surprise',
  ];
  final List<String> authors = [
    'Bolu Shobola',
    'Ayomide',
    'Luncha eXchanage',
    'Luncha eXchanage',
    'Reddor Security'
  ];

  final List<String> user = [
    'smothie',
    'chicken & chips',
    'parfait',
    'cocktail',
    'shrimps'
  ];

  final List<String> amount = <String>[
    '#5000',
    '#4000',
    '#3000',
    '#2000',
    '#1000',
  ];
  final service = ServiceWorker();

  @override
  void initState() {
    super.initState();
    // if (Localstorage().updating('auth')) {
    //   print('storage is present');
    //   Localstorage().updating('auth');
    // } else {
    //   print('no such instance is found');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text('Foodrelich',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: FractionalOffset.topLeft,
              child: Text(
                'Recepies of the Day',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: title.length,
              itemBuilder: (context, index) {
                return sideshow(editor[index], title[index], content[index],
                    authors[index]);
              },
            )),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Social Chefs',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: service.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: user.length,
                        itemBuilder: (context, index) {
                          return Items(
                              image: 'assets/image/HE-1114.png',
                              recepie: user[index],
                              price: amount[index]);
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

_Items(String images, String recepie, String price) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(images),
            radius: 20,
          ),
          Text(recepie),
          const Spacer(),
          Text(price)
        ],
      ),
    ),
  );
}

Padding sideshow(String editors, String title, String content, String author) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.grey, offset: Offset(1, 2))
          ]),
      height: 200,
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(alignment: Alignment.topLeft, child: Text(editors)),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset('assets/image/HE-1114.png',
                height: 50, width: double.infinity),
            const Spacer(),
            Align(alignment: Alignment.bottomRight, child: Text(content)),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                author,
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
