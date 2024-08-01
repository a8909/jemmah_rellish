import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/Server.dart';
import 'package:jemmah_rellish/practical/screens.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final services = ServiceWorker();

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  bool visiblle = true;
  bool box = true;
  bool isLoggedIn = true;
  bool status = false;
  String errorMessage = '';
  String password = '';

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

  switchMode() {
    isLoggedIn = !isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Row(
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                      final body = {
                        'email': _controller.text,
                        'password': _pwdController.text
                      };
                      services.signUP(body);
                      _controller.clear();
                      _pwdController.clear();
                      // Navigator.of(context).pushNamed('/SignUp');
                    },
                    child: isLoggedIn
                        ? const Text('Sign up')
                        : const Text('Login'))
              ],
            ),
            const SizedBox(
              height: 30,
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
                          services.userLogin(body);
                          status = true;
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) {
                              return const Screens();
                            },
                          ));
                          _controller.clear();
                          _pwdController.clear();
                        },
                  style: ElevatedButton.styleFrom(),
                  child: status ? const Text('Login') : const Text('Sign up')),
            ),

            // errorMessage should be displayed here
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Password');
                },
                child: const Text(
                  'Forget password',
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
