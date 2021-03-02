import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topapp/blocs/register_bloc.dart';
import 'package:topapp/repository/confirm_login_repo.dart';
import 'package:topapp/screens/login.dart';

class ConfirmLogin extends StatefulWidget {
  static const routeName = '/confirmLogin';

  @override
  _ConfirmLoginState createState() => _ConfirmLoginState();
}

class _ConfirmLoginState extends State<ConfirmLogin> {
  ConfirmLoginRepo _confirmLoginRepo;
  RegisterBloc _registerBloc;

  final _formKey = new GlobalKey<FormState>();
  final pin = new TextEditingController();

  Timer _timer;
  int _start = 300;
  bool showResend = false;

  void startTimer() {
    _start = 300;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            showResend = true;
          });
        } else {
          setState(() {
            _start--;
            showResend = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    pin.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _confirmLoginRepo = ConfirmLoginRepo();
    _registerBloc = RegisterBloc();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final flowToken = routeArgs['flowToken'];
    final registerMessage = routeArgs['registerMessage'];

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
                    child: Text('کد فعال سازی را وارد نمایید'),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: pin,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        maxLength: 4,
                        decoration:
                            InputDecoration(hintText: 'xxxx', counterText: ''),
                        validator: (pin) {
                          if (pin.isEmpty) {
                            return 'لطفا کد ارسال شده را وارد کنید';
                          }
                          if (pin.length != 4) {
                            return 'کد وارد شده صحیح نیست';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        registerMessage,
                        textAlign: TextAlign.center,
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
                                {confirmLogin(flowToken)}
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => {
                        changeNumber()
                      },
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text('تغییر شماره'),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('منتظر دریافت کد فعالسازی')),
                  Text(durationToString(_start)),
                  if (showResend == true)
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => {
                          reSendCode(),
                        },
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text('ارسال مجدد'),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  confirmLogin(String flowToken) async {
    var registerRes =
        await _confirmLoginRepo.getConfirmLogin(pin.text, flowToken);
    if (registerRes.Token.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', registerRes.Token);
    }
  }

  reSendCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _registerBloc.fetchRegister(prefs.getString('mobileNo'));
    startTimer();
  }

  changeNumber() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.of(context)
      .pushReplacementNamed(Login.routeName, arguments: {
      'mobileNo': prefs.getString('mobileNo'),
    });
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }
}
