import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class ImageLoader extends StatefulWidget {
  final String imageUrl;

  ImageLoader({required this.imageUrl});

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  bool isImageLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(NetworkImage(widget.imageUrl), context).then((value) {
      setState(() {
        isImageLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isImageLoaded
          ? Image.network(widget.imageUrl, fit: BoxFit.fill)
          : const CircularProgressIndicator(
              color: color6,
              strokeWidth: 4,
            ),
    );
  }
}
