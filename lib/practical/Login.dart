import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';
import 'package:jemmah_rellish/components/services/googleAuth.dart';
import 'package:jemmah_rellish/practical/screens.dart';

import '../components/services/server.dart';

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
  var errorMessage = '';
  String password = '';
  bool stateChecker = false;
  final GlobalColors _color = GlobalColors();
  final GoogleAuthentication _gAuth = GoogleAuthentication();
 

  void googleRequest() {
    // _gAuth.signInwithGoogle();
    //if gAuth is available authticate with google else show coming soon
  }
  

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), (){
      setState(() {
        errorMessage = "";
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Row(
                children: [
                  Text(
                    'Welcome',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'to jemmah rellish Big Store....',
                    style: TextStyle(fontSize: 10),
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
                        final body = {
                          'email': _controller.text,
                          'password': _pwdController.text
                        };
                        services.signUP(body).catchError(
                          (err) {
                            print('errormessage is :$err');
                            return err;
                          },
                          test: (error) {
                            return throw Exception(error);
                          },
                        ).whenComplete(
                          () {
                            _controller.clear();
                            _pwdController.clear();
                          },
                        );
                  
                        // Navigator.of(context).pushNamed('/SignUp');
                      },
                      child: const Text('Sign up'))
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
                              'username': _controller.text.trim(),
                              'password': _pwdController.text.trim(),
                              "expiresInMins": 30
                            };
                            setState(() {
                              status = true;
                            });
                            services
                                .userLogin(body)
                                .then((value) => {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) {
                                          return const Screens();
                                        },
                                      )),
                                    })
                                .catchError(
                              (error) {
                                if(error is Exception){
                                  setState(() {
                                    errorMessage = "Invalid login";
                                  });
                                }
                                return error;
                              },
                            ).whenComplete(() {
                              setState(() {
                                status = false;
                                _controller.clear();
                                _pwdController.clear();
                              });
                            });
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF103B11),
                        disabledBackgroundColor:
                            const Color(0xFF103B11).withOpacity(0.5)),
                    child: status
                        ? const CircularProgressIndicator(color: Colors.white,)
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
              ),
              errorMessage.isEmpty
                  ? const SizedBox.shrink()
                  : Text(errorMessage),
                  
              // errorMessage should be displayed here
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/forgetPassword');
                    },
                    child: Text(
                      'Forget password',
                      style: TextStyle(color: _color.danger),
                    )),
              ),
              const SizedBox(height: 20),
              //google sign in
              GestureDetector(
                onTap: () {
                  googleRequest();
                },
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(1),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Image.asset('assets/image/google.png',
                            width: 50, height: 50),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
