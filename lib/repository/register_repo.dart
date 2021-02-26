import 'dart:convert';

import 'package:topapp/models/register.dart';
import 'package:topapp/networking/api_base_helper.dart';

class RegisterRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Register>> fetchRegister() async {
    final response = await _helper.post(
        "party/register",
        jsonEncode({
          'MarketId': 80,
          'MobileNo': '09120476510',
        }));
    print(response);
    return RegisterResponse.fromJson(response).Data;
  }
}
