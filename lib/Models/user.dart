import 'package:picturn/Models/profile.dart';

class User {
  final String login;
  String password;
  String eMail;
  final Profile profile;

  User(this.login, this.password, this.eMail, this.profile);
}
