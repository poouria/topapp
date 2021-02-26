import 'dart:async';

import 'package:topapp/models/register.dart';
import 'package:topapp/networking/api_response.dart';
import 'package:topapp/repository/register_repo.dart';

class RegisterBloc {
  RegisterRepository _registerRepository;

  StreamController _registerResController;

  StreamSink<ApiResponse<List<Register>>> get registerResSink =>
      _registerResController.sink;

  Stream<ApiResponse<List<Register>>> get registerStream =>
      _registerResController.stream;

  RegisterBloc() {
    _registerResController = StreamController<ApiResponse<List<Register>>>();
    _registerRepository = RegisterRepository();
  }

  fetchRegister() async {
    registerResSink.add(ApiResponse.loading('Fetching Register'));
    try {
      List<Register> register = await _registerRepository.fetchRegister();
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
