import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/Server.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';
import 'package:jemmah_rellish/practical/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final services = ServiceWorker();
SongModel sng = SongModel();

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool visiblle = true;
  bool box = true;
  bool isLoggedIn = false;
  bool status = false;
  String errorMessage = '';
  String password = '';
  bool stateChecker = false;

  isLoading() {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getusrPref();
  }

  _getusrPref() async {
    final SharedPreferences getusr = await SharedPreferences.getInstance();
    final value = getusr.getString('auth') ?? 'auth is empty';
    print('value: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Row(
                  children: [
                    Text(
                      'Welcome',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      'to jemmah rellish Big Store....',
                      style: TextStyle(fontSize: 8),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _controller,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'UserName',
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _pwdController,
                  textCapitalization: TextCapitalization.sentences,
                  obscureText: visiblle,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFC2BEBE)),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visiblle = !visiblle;
                            });
                          },
                          icon: visiblle
                              ? const Icon(Icons.visibility_sharp)
                              : const Icon(Icons.visibility_off_sharp)),
                      hintText: 'Password',
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            box = !box;
                          });
                        },
                        icon: box
                            ? const Icon(
                                Icons.check_box_outline_blank_sharp,
                                size: 25,
                              )
                            : const Icon(Icons.check_box_outlined)),
                    const Text('Remeber me'),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          // final body = {
                          //   'email': _controller.text,
                          //   'password': _pwdController.text
                          // };
                          // services.signUP(body);
                          _controller.clear();
                          _pwdController.clear();
                          setState(() {
                            isLoggedIn = !isLoggedIn;
                            bool switchMode = sng.lightMode = !sng.lightMode;
                            sng.currentMode(switchMode);
                          });

                          // Navigator.of(context).pushNamed('/SignUp');
                        },
                        child: isLoggedIn == false
                            ? const Text('Sign up')
                            : const Text('Login'))
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: _controller.text.isEmpty || password.isEmpty
                          ? null
                          : () {
                              final body = {
                                'email': _controller.text,
                                'password': _pwdController.text
                              };
                              setState(() {
                                status = true;
                              });
                              services
                                  .userLogin(body)
                                  .then((onValue) => {
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) {
                                            return const Screens();
                                          },
                                        )),
                                      })
                                  .whenComplete(() {
                                setState(() {
                                  status = false;
                                });
                                _controller.clear();
                                _pwdController.clear();
                              });
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF103B11),
                          disabledBackgroundColor:
                              const Color(0xFF103B11).withOpacity(0.5)),
                      child: status == true
                          ? const Text('checking',
                              style: TextStyle(color: Colors.white))
                          : const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            )),
                ),
                errorMessage.isEmpty
                    ? const SizedBox.shrink()
                    : Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),

                // errorMessage should be displayed here
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Password');
                      },
                      child: const Text(
                        'Forget password',
                        // style: TextStyle(color: Colors.red),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
