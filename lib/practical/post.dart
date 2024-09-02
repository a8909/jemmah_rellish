import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jemmah_rellish/components/allPost.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/userPost.dart';

import '../components/models/postArray.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final TextEditingController _controller = TextEditingController();
  GlobalColors clr = GlobalColors();
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

  onCreatePost() async {
    UsrPost postRev = UsrPost(
        img: _sngImg, name: 'Jacob Brilliant', comment: _controller.text);
    if (postRev.img.isEmpty || postRev.comment.isEmpty) {
      displayImage = false;
      return;
    }
    setState(() {
      postArray.userPost.add(postRev);
    });
    final post = jsonEncode(postRev.tojson());
    await _storage.savepostUpdate('pst', post);
    _controller.clear();
    displayImage = false;
    Navigator.pop(context);
  }

  void _getReviews() async {
    final userPost = await _storage.getPost('pst');
    if (postArray.userPost.isNotEmpty || userPost != null) {
      setState(() {
        userPost
            .map((eachPost) => UsrPost.fromJson(jsonDecode(eachPost)))
            .toList();
      });
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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.location_on_sharp)),
        title: const Center(
          child: Text(
            'Posts',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/Notify');
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
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
                        onChanged: (value) {
                          _controller.text = value;
                        },
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
                      _controller.text.isEmpty && _controller.text == ''
                          ? Text(
                              'Field is required',
                              style: TextStyle(color: clr.danger),
                            )
                          : const Text(''),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AllPost(usp: postArray.singlePost[index]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                  itemCount: postArray.userPost.length),
            )
          ],
        ),
      ),
    );
  }
}
