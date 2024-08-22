import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/userPost.dart';

class AllPost extends StatelessWidget {
  final UsrPost usp;
  const AllPost({super.key, required this.usp});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              usp.img,
              height: 40,
              width: 40,
            ),
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
    );
  }
}
