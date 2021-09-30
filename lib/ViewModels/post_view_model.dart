import 'package:flutter/cupertino.dart';
import 'package:picturn/Models/post.dart';
import 'package:picturn/Models/profile.dart';
import 'package:picturn/Repositories/post_repository.dart';

class PostViewModel extends ChangeNotifier {
  final Post post;

  PostViewModel({this.post});

  bool trySetLike() {
    this.post.isLiked = !this.post.isLiked;
    this.post.isLiked ? this.post.likesCount++ : this.post.likesCount--;
    return this.post.isLiked;
  }

  //TODO
  Future<void> updateLike() async {
    notifyListeners();
  }

  String get getImagePath => this.post.imagePath;

  int get getTimestamp => this.post.timestamp;

  String get getAuthor => this.post.profile.nickName;

  DateTime get getDate => this.post.date;

  Profile get getProfile => this.post.profile;

  String get getAvatarImagePath =>
      (this.post.profile.avatarImageUrl == null ||  this.post.profile.avatarImageUrl.isEmpty)
      ? 'res/images/no_avatar.png'
      : this.post.profile.avatarImageUrl;

  int get getLikesCount => this.post.likesCount;
}
