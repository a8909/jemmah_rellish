import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  bool visiblle = true;
  bool box = true;
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
              textCapitalization: TextCapitalization.sentences,
              obscureText: visiblle,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
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
                      Navigator.of(context).pushNamed('/SignUp');
                    },
                    child: const Text('Sign up'))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/screens');
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Login')),
            ),
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
