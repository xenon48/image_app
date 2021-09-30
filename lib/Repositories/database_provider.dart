import 'package:firebase_database/firebase_database.dart';
import 'package:picturn/Models/post.dart';

class DatabaseProvider {
  final databaseReference = FirebaseDatabase.instance.reference();

  final database = FirebaseDatabase.instance.reference();

  DatabaseReference savePost(Post post) {
    var id = databaseReference.child('posts/').push();
    id.set(post.toJson());
    return id;
  }

  void updatePost(Post post, DatabaseReference id) {
    id.update(post.toJson());
  }


  Future<List<Post>> getAllPosts() async {
    return queryToList(databaseReference.child('posts/').orderByChild('timestamp'));
  }

  Future<List<Post>> getLatestPosts(int timestamp, {int limit = 100}) async {
    return queryToList(databaseReference
        .child('posts/')
        .limitToLast(limit)
        .startAt(timestamp)
        .orderByChild('timestamp'));
  }

  Future<List<Post>> snapshotToList(DatabaseReference ref) async {
    DataSnapshot dataSnapshot = await ref.once();
    List<Post> posts = [];
    print('qqqqqqqqqqqqqqqq');
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        Post post = Post.createPost(value);
        posts.add(post);
        print(post.profile.email);
        //print(formatDate(post.date, [yyyy, '-', mm, '-', dd]));
      });
    }
    return posts;
  }

  Future<List<Post>> queryToList(Query query) async {
    DataSnapshot dataSnapshot = await query.once();

    List<Post> posts = [];
    // query.onChildAdded.forEach((event) {
    //   posts.add(Post.createPost(event.snapshot.value));
    // });
    print('qqqqqqqqqqqqqqqq');
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        Post post = Post.createPost(value);
        posts.add(post);
        print(post.profile.email);
        //print(formatDate(post.date, [yyyy, '-', mm, '-', dd]));
      });
    }
    return posts;
  }
}
