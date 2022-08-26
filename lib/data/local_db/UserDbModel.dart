import 'package:objectbox/objectbox.dart';

@Entity()
class UserModelDb {
  String token;
  int id;

  UserModelDb({required this.token, required this.id});
}
