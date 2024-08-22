import 'package:jemmah_rellish/components/models/userPost.dart';

class Reviews {
  List<UsrPost> userPost = [
    UsrPost(
        img: 'assets/image/HE-1114.png',
        name: 'Steve Johnson',
        comment: 'It was nice having to patronize you!'),
    UsrPost(
        img: 'assets/image/HE-1114.png',
        name: 'Wealth Gease',
        comment:
            'So far the store has been doing great and deservers more greatness!!'),
    UsrPost(
        img: 'assets/image/HE-1114.png',
        name: 'Storm Christian',
        comment: 'Greate job!!'),
    UsrPost(
        img: 'assets/image/kkki.png',
        name: 'Lovely Jordan',
        comment: 'Customer preference has been super awesome, thank you!'),
    UsrPost(
        img: 'assets/image/HE-1114.png',
        name: 'Mike Swart',
        comment: 'Delievery has been swift and inpirating to do more orders')
  ];

  get singlePost => userPost;
}
