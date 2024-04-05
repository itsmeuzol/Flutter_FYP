import 'package:finalyear/domain/signup/http_services.dart';
import 'package:finalyear/presentation/screens/admin_main/adminside/addDustbin/addDustbinModel/addDustbinModel.dart';
import 'package:finalyear/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AddDustbinApi {
  Future<bool> register(AddDustbinModel dustbin) async {
    bool isAdded = false;
    Response response;
    var url = baseUrl + addDustbinUrl;
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: dustbin.toJson(),
      );
      if (response.statusCode == 200) {
        print("Dustbin added successfully: ${response.data}");
        return true;
      } else {
        debugPrint("Received status code: ${response.statusCode}");
        debugPrint("Response data: ${response.data}");
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }

    return isAdded;
  }
}
