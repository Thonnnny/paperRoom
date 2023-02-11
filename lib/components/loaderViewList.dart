import 'package:flutter/material.dart';
import 'package:freshbuyer/constants.dart';

class ImageLoaderListView extends StatefulWidget {
  final String imageUrl;

  ImageLoaderListView({required this.imageUrl});

  @override
  _ImageLoaderListViewState createState() => _ImageLoaderListViewState();
}

class _ImageLoaderListViewState extends State<ImageLoaderListView> {
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
          ? Image.network(widget.imageUrl,
              width: 150, height: 150, fit: BoxFit.cover)
          : const Center(
              child: CircularProgressIndicator(
                color: color6,
                strokeWidth: 4,
              ),
            ),
    );
  }
}
