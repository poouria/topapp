import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topapp/blocs/register_bloc.dart';
import 'package:topapp/models/registerModel.dart';
import 'package:topapp/networking/api_response.dart';
import 'package:topapp/screens/confirmLogin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  RegisterBloc _registerBloc;
  final mobileNo = TextEditingController();
  @override
  void dispose() {
    mobileNo.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc();
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
              child: Column(children: [
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
                Row(children: [
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
                            {_registerBloc.fetchRegister(mobileNo.text)}
                        },
                      ),
                    ),
                  )
                ])
              ]),
            ),
            StreamBuilder<ApiResponse<RegisterModel>>(
              stream: _registerBloc.registerStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Container(
                          child: Text(snapshot.data.message.toString()));
                      break;
                    case Status.COMPLETED:
                      login(context, snapshot.data.data);
                      break;
                    case Status.ERROR:
                      return Container(
                          child: Text(snapshot.data.message.toString()));
                      break;
                  }
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }

  login(BuildContext context, data) async {
    if (data.FlowToken.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('mobileNo', mobileNo.text);
      Navigator.of(context).pushNamed(ConfirmLogin.routeName, arguments: {
        'flowToken': data.FlowToken.toString(),
        'registerMessage': data.ResponseCoreMessage.toString()
      });
    }
  }
}
