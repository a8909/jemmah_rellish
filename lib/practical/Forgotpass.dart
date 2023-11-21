import 'package:flutter/material.dart';

class Forgot extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  Forgot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  hintText: 'Forgot Password',
                  labelText: 'Forgot Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () {}, child: const Text('Try another way'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
