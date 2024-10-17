import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/userPost.dart';

class AllPost extends StatelessWidget {
  final UsrPost usp;
   AllPost({super.key, required this.usp});

  final GlobalColors _colors = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: _colors.grey200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(radius: 20, backgroundImage: AssetImage(usp.img)),
                const SizedBox(
                  width: 16,
                ),
                Text(usp.name),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              usp.img,
              height: 200,
              width: double.infinity,
            ),
            Align(alignment: Alignment.centerLeft, child: Text(usp.comment))
          ],
        ),
      ),
    );
  }
}
