import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';
import 'package:jemmah_rellish/practical/Login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> gender = ['Male', 'Female'];
  String dropdownValue = 'Male';
  final songTheme = SongModel();
  final Localstorage _storage = Localstorage();

  void onLogOut() async {
    await _storage.logOut('auth');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            PopupMenuButton<Option>(
              onSelected: (value) {
                switch (value) {
                  case Option.edit:
                    break;
                  case Option.log:
                    break;
                  case Option.mode:
                    break;
                  default:
                    print('No value found');
                    // TODO: Handle this case.
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: Option.edit,
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: Option.log,
                    child: const Text('Log out'),
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text(
                                "Are you sure you want to log out ?"),
                            actions: [
                              Align(
                                alignment: Alignment.center,
                                child: OutlinedButton(
                                    onPressed: () {
                                      onLogOut();
                                    },
                                    child: const Text('Log out')),
                              )
                            ],
                          );
                        }),
                  ),
                  PopupMenuItem(
                    value: Option.mode,
                    child: Text(songTheme.lightMode ? 'LightMode' : 'DarkMode'),
                    onTap: () {
                      setState(() {
                        bool mode = songTheme.lightMode = !songTheme.lightMode;
                        songTheme.themes = mode;
                        print('theme : ${songTheme.lightMode}');
                      });
                    },
                  ),
                ];
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/image/HE-1114.png',
                              height: 90,
                              width: 90,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            iconSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Folasade Bewaji Grcae',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    const Text('Welcome to our QRcode Generator 🔥'),
                    const Text('Insert a link below to generate a QR Code'),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Insert a link',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(1)),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue),
                        onPressed: () {
                          // image and the link embeded inside
                        },
                        child: const Text('Submit')),
                    Container(
                      height: 50,
                      color: Colors.white.withOpacity(1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Gender'),
                            Center(
                              child: DropdownButton(
                                value: dropdownValue,
                                items: gender.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    details('Address', 'Redemption camp, ogun-state'),
                    const SizedBox(
                      height: 5,
                    ),
                    details('Phone number', '09090397455')
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

enum Option { edit, log, mode }

Container details(String key, String value) {
  return Container(
    height: 50,
    width: double.infinity,
    color: Colors.white.withOpacity(1),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(key),
          const Spacer(),
          Text(value),
        ],
      ),
    ),
  );
}
