import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.yellow,
        pageTransitionsTheme: NoTransitionsOnWeb(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
        '/demo': (context) => Demo(),
      },
    );
  }
}

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (CatImage image in images) {
      precacheImage(NetworkImage(image.url), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cat Demo')),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 50),
        child: TextButton(
          child: Text('Welcome!'),
          onPressed: () {
            Navigator.of(context).pushNamed('/demo');
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cat Demo')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: [for (CatImage image in images) ImageCaption(image)],
        ),
      ),
    );
  }
}

class ImageCaption extends StatelessWidget {
  const ImageCaption(this.image);

  final CatImage image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidgetPlaceholder(
            image: NetworkImage(image.url),
            placeholder: SizedBox(
              width: image.width,
              height: image.height,
            ),
          ),
          Text(image.caption),
        ],
      ),
    );
  }
}

class ImageWidgetPlaceholder extends StatelessWidget {
  const ImageWidgetPlaceholder({Key key, this.image, this.placeholder})
      : super(key: key);

  final ImageProvider image;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      frameBuilder: (BuildContext context, Widget child, int frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: frame != null ? child : placeholder,
          );
        }
      },
    );
  }
}

class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    route,
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    if (kIsWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

class CatImage {
  const CatImage({this.width, this.height, this.caption});
  final double width;
  final double height;
  final String caption;

  get url => 'https://placekitten.com/$width/$height';
}

const List<CatImage> images = [
  CatImage(width: 150, height: 150, caption: 'Watch out'),
  CatImage(width: 150, height: 160, caption: 'Hmm'),
  CatImage(width: 160, height: 150, caption: 'Whats up'),
  CatImage(width: 140, height: 150, caption: 'Miaoo'),
  CatImage(width: 130, height: 150, caption: 'Hey'),
  CatImage(width: 155, height: 150, caption: 'Hello'),
];
