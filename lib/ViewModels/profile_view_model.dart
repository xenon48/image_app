import 'package:picturn/Models/profile.dart';

class ProfileViewModel {
  Profile profile;

  ProfileViewModel(this.profile);


  String get getAvatarImagePath =>
      this.profile.avatarImageUrl ?? 'res/images/no_avatar.png';


  int fetchCountPosts() {
    //TODO метод репозитория, которому кидаем профиль
    return 5;
  }

  int fetchCountLikes() {
    //TODO метод репозитория, которому кидаем профиль
    return 123;
  }
}
