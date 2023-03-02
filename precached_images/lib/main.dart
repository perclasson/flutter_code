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
  const ImageWidgetPlaceholder(
      {required this.image, required this.placeholder});

  final ImageProvider image;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded == true) {
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

class CatImage {
  const CatImage(
      {required this.width, required this.height, required this.caption});
  final double width;
  final double height;
  final String caption;

  get url => 'https://placekitten.com/$width/$height';
}

const List<CatImage> images = [
  CatImage(width: 150.0, height: 150.0, caption: 'Watch out'),
  CatImage(width: 150.0, height: 160.0, caption: 'Hmm'),
  CatImage(width: 160.0, height: 150.0, caption: 'Whats up'),
  CatImage(width: 140.0, height: 150.0, caption: 'Miaoo'),
  CatImage(width: 130.0, height: 150.0, caption: 'Hey'),
  CatImage(width: 155.0, height: 150.0, caption: 'Hello'),
];
