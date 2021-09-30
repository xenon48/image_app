class Profile {
  String email;
  String nickName;
  String avatarImageUrl;

  Profile(this.email, this.avatarImageUrl,this.nickName);

  bool isSameById(Profile profile){
    return profile.email == email;
  }
}
