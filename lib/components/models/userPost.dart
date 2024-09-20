class UsrPost {
  final String img;
  final String name;
  final String comment;
  UsrPost({required this.img, required this.name, required this.comment});

  factory UsrPost.fromJson(Map<String, dynamic> json) =>
      UsrPost(img: json['img'], name: json['name'], comment: json['comment']);

  Map<String, dynamic> toJson() {
    return {'img': img, 'name': name, 'comment': comment};
  }
}
