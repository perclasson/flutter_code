import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Example',
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => HomePage(),
        OverviewPage.route: (context) => OverviewPage(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  static String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Overview page'),
          onPressed: () {
            // Navigate to the overview page using a named route.
            Navigator.of(context).pushNamed(OverviewPage.route);
          },
        ),
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  static String route = '/overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to the home screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
