import 'package:flutter/material.dart';

import 'greeter.dart';
import 'english_greeter.dart' deferred as english_greeter;
import 'swedish_greeter.dart' deferred as swedish_greeter;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Demo(),
        ),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String locale = 'en';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowGreeter(
          locale: locale,
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('English'),
              onPressed: () {
                setState(() {
                  locale = 'en';
                });
              },
            ),
            SizedBox(width: 20),
            RaisedButton(
              child: Text('Swedish'),
              onPressed: () {
                setState(() {
                  locale = 'sv';
                });
              },
            ),
          ],
        )
      ],
    );
  }
}

class ShowGreeter extends StatelessWidget {
  const ShowGreeter({Key key, this.locale}) : super(key: key);

  final String locale;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locale == 'sv'
          ? swedish_greeter.loadLibrary()
          : english_greeter.loadLibrary(),
      builder: (context, snapshot) {
        Greeter greeter;
        if (locale == 'sv') {
          greeter = swedish_greeter.SwedishGreeter();
        } else {
          greeter = english_greeter.EnglishGreeter();
        }
        return Text(greeter.greet('World'));
      },
    );
    ;
  }
}
