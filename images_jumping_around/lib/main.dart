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
      home: Demo(),
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
          Image.network(image.url),
          Text(image.caption),
        ],
      ),
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
