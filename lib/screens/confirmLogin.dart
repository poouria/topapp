import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topapp/repository/register_repo.dart';
import 'package:topapp/widgets/countDown.dart';

class ConfirmLogin extends StatefulWidget {
  static const routeName = '/confirmLogin';

  @override
  _ConfirmLoginState createState() => _ConfirmLoginState();
}

RegisterRepository _registerRepository;

GlobalKey<State> _keyLoader = new GlobalKey<State>();
final _formKey = new GlobalKey<FormState>();
final pin = new TextEditingController();

class _ConfirmLoginState extends State<ConfirmLogin>
    with TickerProviderStateMixin {
  AnimationController _controller;
  int levelClock = 300;
  bool showResend = false;

  void resetClock() {
    setState(() {
      levelClock = 300;
    });
  }

  @override
  void dispose() {
    pin.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _registerRepository = RegisterRepository();
    _controller.forward();
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
                                {confirmLogin(context)}
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
                      onPressed: () => {Navigator.pop(context)},
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text('تغییر شماره'),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('منتظر دریافت کد فعالسازی')),
                  Countdown(
                    animation: StepTween(
                      begin: levelClock,
                      end: 0,
                    ).animate(_controller),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => {
                        reSendCode(context),
                        resetClock(),
                        _controller = AnimationController(
                            vsync: this,
                            duration: Duration(seconds: levelClock)),
                        _controller.forward(),
                        print(_controller),
                        showResend = false
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
}

confirmLogin(BuildContext context) {}

reSendCode(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await _registerRepository.fetchRegister(prefs.getString('mobileNo'));
}
