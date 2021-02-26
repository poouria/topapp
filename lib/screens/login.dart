import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topapp/blocs/register_bloc.dart';
import 'package:topapp/networking/api_response.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

GlobalKey<State> _keyLoader = new GlobalKey<State>();
final _formKey = GlobalKey<FormState>();
RegisterBloc _bloc;

class _LoginState extends State<Login> {
  final mobileNo = TextEditingController();

  @override
  void dispose() {
    mobileNo.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bloc = RegisterBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(children: [
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/logo_fa_front.png',
                      width: 200,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
                    child: Text('شماره موبایل خود را وارد کنید'),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: mobileNo,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        maxLength: 11,
                        decoration: InputDecoration(
                            hintText: '09xxxxxxxxx', counterText: ''),
                        validator: (mobileNo) {
                          if (mobileNo.isEmpty) {
                            return 'لطفا شماره موبایل خود را وارد کنید';
                          }
                          if (mobileNo.length != 11) {
                            return 'شماره وارد شده صحیح نیست';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonTheme(
                          height: 50,
                          buttonColor: Theme.of(context).buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: RaisedButton(
                            child: Text(
                              'تایید',
                            ),
                            elevation: 0,
                            onPressed: () async => {
                              if (_formKey.currentState.validate())
                                {login(context)}
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

login(BuildContext context) async {
  _bloc.fetchRegister();
  _bloc.registerStream.listen((value) {
    if (value.status.toString().isNotEmpty) {
      switch (value.status) {
        case Status.LOADING:
          return 'Loading(loadingMessage: snapshot.data.message)';
          break;
        case Status.COMPLETED:
          return 'MovieList(movieList: snapshot.data.data)';
          break;
        case Status.ERROR:
          return 'Error(errorMessage: value.message)';
          break;
      }
    }
  });
}
//
//Future<String> login(BuildContext context) async {
//  SpinnerDialog.showLoadingDialog(context, _keyLoader);
//
//  var payload = getEncrypted({
//    'MarketId':80,
//    'MobileNo':'09120476510',
//  });
//
//  print(payload);
//  var response = await http.post(
//    HttpConfig.register,
//    headers: apiHeaders,
//    body: jsonEncode({'value':payload}),
//  );
//  Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
//  if (response.statusCode == 200) {
//    Map responseMap = jsonDecode(response.body);
//    print(response.body);
//    var loginResponse = RegisterResponse.fromJson(responseMap);
//  } else {
//    print(response.statusCode.toString());
//  }
//  return null;
//}
