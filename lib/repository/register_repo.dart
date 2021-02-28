import 'dart:convert';

import 'package:topapp/models/registerModel.dart';
import 'package:topapp/models/responseCoreModel.dart';
import 'package:topapp/networking/api_base_helper.dart';

class RegisterRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<RegisterModel> fetchRegister(String mobileNo) async {
    final response = await _helper.post(
        "party/register",
        jsonEncode({
          'MarketId': 80,
          'MobileNo': mobileNo,
        }));
    var responseCore = ResponseCoreModel.fromJson(response);
    var result = jsonDecode(responseCore.DataString);
    result["ResponseCoreMessage"] = responseCore.Message;

    return RegisterModel.fromJson(result);
  }
}
