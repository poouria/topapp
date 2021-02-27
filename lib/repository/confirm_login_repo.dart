import 'dart:convert';

import 'package:topapp/models/confirmLoginModel.dart';
import 'package:topapp/models/responseCoreModel.dart';
import 'package:topapp/networking/api_base_helper.dart';

class ConfirmLoginRepo {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<ConfirmLoginModel> getConfirmLogin(pin, flowToken) async {
    final response = await _helper.post(
      "party/register",
      jsonEncode(
        {'Code': pin, 'ClientVersion': '1.0.7', 'FlowToken': flowToken},
      ),
    );
    var responseCore = ResponseCoreModel.fromJson(response);
    var result = jsonDecode(responseCore.DataString);
    result["ResponseCoreMessage"] = responseCore.Message;

    return ConfirmLoginModel.fromJson(result);
  }
}
