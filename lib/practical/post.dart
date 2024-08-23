import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jemmah_rellish/components/allPost.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/userPost.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/models/postArray.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final TextEditingController _controller = TextEditingController();

  File? img;
  String _sngImg = "";
  bool displayImage = false;

  final picker = ImagePicker();
  final postArray = Reviews();
  final Localstorage _storage = Localstorage();

  Future uploadFromGallery() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickerFile == null) return;
      img = File(pickerFile.path);
      _sngImg = pickerFile.path;
      displayImage = true;
    });
  }

  onCreatePost() {
    UsrPost postRev = UsrPost(
        img: _sngImg, name: 'Jacob Brilliant', comment: _controller.text);
    setState(() {
      postArray.userPost.add(postRev);
      _storage.getPost('pst');
    });
    print(postRev);
    _controller.clear();
    displayImage = false;
    Navigator.pop(context);
  }

  void _getReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('pst') && postArray.userPost.isNotEmpty) {
      _storage.getPost('pst');
    }
  }

  @override
  void initState() {
    super.initState();
    _getReviews();
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
                  padding: const EdgeInsets.all(24.0),
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
                          ? Image.file(
                              img!,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            )
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
                          onPressed: () {
                            onCreatePost();
                          },
                          child: const Text('Create post'))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AllPost(usp: postArray.singlePost[index]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: postArray.userPost.length)
            ],
          ),
        ),
      ),
    );
  }
}
