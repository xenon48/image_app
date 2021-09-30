import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:picturn/Models/post.dart';
import 'package:picturn/Models/profile.dart';
import 'package:picturn/Repositories/post_repository.dart';
import 'package:picturn/Views/auth.dart';

class AddingPostViewModel{
  var postRepository = PostRepository();

  Future<void> addFilePost(File imageFile) async{
    var imageUrl = await uploadImageToFirebase(imageFile);
    var user = getCurrentUser();
    var userId = (user!=null)?user.email:"eshinsergey@gmail.com";
    var nickName = (user!=null)?user.displayName:"eshinsergey@gmail.com";
    var avatarUrl = (user!=null)?user.photoUrl:"";
    Post post = Post(Profile(userId,avatarUrl,nickName), DateTime.now(),DateTime.now().millisecondsSinceEpoch , imageUrl, 0);
    postRepository.savePost(post);
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    String fileName = basename(imageFile.path);
    Reference storageReference = FirebaseStorage.instance.ref().child('uploads/$fileName');
    await storageReference.putFile(imageFile);
    return storageReference.getDownloadURL();
  }
}