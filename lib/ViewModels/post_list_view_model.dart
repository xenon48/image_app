import 'package:flutter/cupertino.dart';
import 'package:picturn/Models/post.dart';
import 'package:picturn/Repositories/post_repository.dart';
import 'package:picturn/ViewModels/post_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';

enum PostListType { all, profile }

class PostListViewModel extends ChangeNotifier {
  List<PostViewModel> postViewModels = <PostViewModel>[];
  PostListType _type;
  ProfileViewModel profileViewModel;

  PostListViewModel(this._type, {this.profileViewModel}){
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    updatePosts(await loadPosts());
  }

  Future<List<Post>> loadPosts() async{
    List<Post> results;

    switch (this._type) {
      case PostListType.all:
        results = await PostRepository().fetchPosts();
        break;
      case PostListType.profile:
        results = await PostRepository()
            .fetchProfilePosts(this.profileViewModel.profile.email);
        break;
    }
    return results;
  }

  Future<void> fetchLatestPost() async {
    List<Post> results;
    if (postViewModels.isEmpty) {
      results = await PostRepository().fetchPosts();
    } else {
      results = await PostRepository()
          .fetchLatestPosts(postViewModels.last.getTimestamp);
    }
    updatePosts(results);
  }

  void updatePosts(List<Post> posts) {
    if (posts != null && posts.isNotEmpty) {
      this.postViewModels += posts.map((item) => PostViewModel(post: item)).toList();
      notifyListeners();
    }
  }

  Future<void> refresh() async{
    postViewModels.clear();
    fetchPosts();
  }
}
