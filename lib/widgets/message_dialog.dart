import 'package:flutter/material.dart';

class MessageDialog {
  static Future<void> showMessageDialog(BuildContext context, GlobalKey key,
      String title, String content, List<Widget> actions) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new WillPopScope(
          onWillPop: () async => true,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Column(children: [
                Icon(
                  Icons.error_outline,
                  size: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(title),
                )
              ]),
              content: Text(
                content,
                textAlign: TextAlign.center,
              ),
              actions: actions,
            ),
          ),
        );
      },
    );
  }
}
