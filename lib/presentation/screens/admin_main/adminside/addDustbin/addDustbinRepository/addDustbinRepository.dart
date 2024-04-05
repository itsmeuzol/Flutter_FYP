import 'package:dio/dio.dart';
import 'package:finalyear/domain/addStaff/addStaffApi/addStaffApi.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbinModel/addDustbinModel.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/dustbinApi.dart';

class DustbinRepository {
  Future<bool> register(AddDustbinModel dustbin) async {
    return await AddDustbinApi().register(dustbin);
  }
}
