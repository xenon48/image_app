import 'package:picturn/Models/post.dart';
import 'package:picturn/Models/profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'database_provider.dart';

class PostRepository {
  var databaseProvider = DatabaseProvider();


  Future<void> savePost(Post post) async {
    this.databaseProvider.savePost(post);
  }

  Future<List<Post>> fetchPosts() async {
    return await this.databaseProvider.getAllPosts();
  }

  Future<List<Post>> fetchLatestPosts(int timestamp) async {
    var list = await this.databaseProvider.getLatestPosts(timestamp);
    return list.where((post) => post.timestamp !=timestamp).toList();
  }

  Future<List<Post>> fetchProfilePosts(String nickName) async {
    //TODO get запрос получения постов пользователя
    var list = await databaseProvider.getAllPosts();
    return list.where((post) => post.profile.email == nickName).toList();
  }

  Future<bool> sendPostLikes(
      String imagePath, String nickName, bool isLiked) async {
    //TODO запрос на добавление/удаление лайка пользователя к посту
    print('сервер получил лайк');
    return await Future.delayed(Duration(seconds: 0), () => true);
  }

  Future<int> fetchPostLikes(String imagePath) async {
    //TODO get запрос получения кол-ва лайков поста
    int count = await Future.delayed(Duration(seconds: 0), () => 15);
    return count;
  }
}
