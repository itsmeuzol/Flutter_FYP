import 'package:finalyear/presentation/screens/admin_main/adminside/pickup/wastepickup/wastepickup.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/pickup/wastepickupapi/wastepickupapi.dart';

class WastepickupRepository {
  Future<bool> register(Wastepickup waste) async {
    return await WastepickupApi().register(waste);
  }
}
