import 'package:dio/dio.dart';
import 'package:finalyear/domain/addStaff/addStaffApi/addStaffApi.dart';
import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/wastepickup/wastepickup.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/wastepickupapi/wastepickupapi.dart';

class WastepickupRepository {
  Future<bool> register(Wastepickup waste) async {
    return await WastepickupApi().register(waste);
  }
}
