import '../data/collections/user.dart';
import '../data/dao/user_dao.dart';

class UserRepository {
  final UserDao _dao = UserDao();

  Future<User?> fetchUserById(String id) => _dao.getUserById(id);

  Future<void> createUser(User user) => _dao.createUser(user);

  Future<void> updateUser(User user) => _dao.updateUser(user);

  Future<void> deleteUser(String id) => _dao.deleteUser(id);

  Stream<List<User>> watchUsers() => _dao.watchAllUsers();
}
