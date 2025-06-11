import '../data/models/user.dart';
import '../data/dao/user_dao.dart';

class UserRepository {
  final UserDao _dao = UserDao();

  Future<UserModel?> fetchUserById(String id) => _dao.getUserById(id);

  Future<void> createUser(UserModel user) => _dao.createUser(user);

  Future<void> updateUser(UserModel user) => _dao.updateUser(user);

  Future<void> deleteUser(String id) => _dao.deleteUser(id);

  Stream<List<UserModel>> watchUsers() => _dao.watchAllUsers();
}
