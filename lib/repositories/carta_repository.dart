import '../data/collections/carta.dart';
import '../data/dao/carta_dao.dart';

class CartaRepository {
  final CartaDao _dao = CartaDao();

  Future<Carta> addCarta(Carta carta) => _dao.createCarta(carta);

  Future<void> updateCarta(Carta carta) => _dao.updateCarta(carta);

  Future<void> removeCarta(String id) => _dao.deleteCarta(id);

  Future<List<Carta>> fetchCarteForUser(String userId) => _dao.getCarteByUserId(userId);
}
