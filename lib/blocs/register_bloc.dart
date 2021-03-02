import 'dart:async';

import 'package:topapp/models/registerModel.dart';
import 'package:topapp/networking/api_response.dart';
import 'package:topapp/repository/register_repo.dart';

class RegisterBloc {
  RegisterRepository _registerRepository;

  StreamController _registerResController;

  StreamSink<ApiResponse<RegisterModel>> get registerResSink =>
      _registerResController.sink;

  Stream<ApiResponse<RegisterModel>> get registerStream =>
      _registerResController.stream;

  RegisterBloc() {
    _registerResController = StreamController<ApiResponse<RegisterModel>>();
    _registerRepository = RegisterRepository();
  }

  fetchRegister(String mobileNo) async {
    registerResSink.add(ApiResponse.loading('Fetching Register'));
    try {
      RegisterModel register =
          await _registerRepository.fetchRegister(mobileNo);
      registerResSink.add(ApiResponse.completed(register));
    } catch (e) {
      registerResSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _registerResController?.close();
  }
}
