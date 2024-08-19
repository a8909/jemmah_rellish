import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Posts extends StatefulWidget {
  Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final TextEditingController _controller = TextEditingController();

  File? _img;
  bool displayImage = false;

  final picker = ImagePicker();

  Future uploadFromGallery() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickerFile == null) return;
      _img = File(pickerFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.tag),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add Comments',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _controller,
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                            hintText: 'Message',
                            labelText: 'Add post',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Add Image',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      displayImage
                          ? const Text('image has been loaded..')
                          : GestureDetector(
                              onTap: () => uploadFromGallery(),
                              child: Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    border: Border.all(color: Colors.black)),
                                child: const Center(
                                  child: Text('Upload fron gallery'),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text('OR'),
                      const SizedBox(
                        height: 16,
                      ),
                      OutlinedButton(
                          onPressed: () {}, child: const Text('camera')),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Create post'))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on_sharp)),
                const Text(
                  'Posts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/Notify');
                    },
                    icon: const Icon(Icons.notifications))
              ],
            ),
            const Divider(
              height: 30,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/image/HE-1114.png',
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text('Boluwatife Shobola')
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              'assets/image/HE-1114.png',
              height: 200,
              width: double.infinity,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Coding is fun, i really enjoyed it..... '))
          ],
        ),
      ),
    );
  }
}
