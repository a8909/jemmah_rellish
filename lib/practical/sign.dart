import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _controller = TextEditingController();
  var gender = Gender.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Password',
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Re-Enter Password',
                labelText: 'Re-Enter Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            Row(
              children: [
                const Text('Gender'),
                const SizedBox(width: 10),
                const Text('Male'),
                Radio(
                  value: Gender.male,
                  fillColor: WidgetStateProperty.resolveWith(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.black.withOpacity(.32);
                    } else {
                      return Colors.black;
                    }
                  }),
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = Gender.male;
                    });
                  },
                ),
                const SizedBox(width: 5),
                const Text('Female'),
                Radio(
                  value: Gender.female,
                  fillColor: WidgetStateProperty.resolveWith(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.black.withOpacity(.32);
                    } else {
                      return Colors.black;
                    }
                  }),
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = Gender.female;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum Gender { none, male, female }
