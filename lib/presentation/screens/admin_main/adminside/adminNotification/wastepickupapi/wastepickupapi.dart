import 'package:finalyear/domain/addStaff/addStaffModel/addStaffModel.dart';
import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/adminNotification/wastepickup/wastepickup.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';

class WastepickupApi {
  Future<bool> register(Wastepickup user) async {
    bool isRegister = false;
    Response response;
    var url = baseUrl + wastepickupAddTime;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 200) {
        print("Response data isss wastepickup: ${response.data}");
        return true;
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isRegister;
  }
}
