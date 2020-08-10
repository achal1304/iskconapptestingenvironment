import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  final String url;
  const ImageDialog({Key key, this.url}) : super(key: key);
  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width*1,
        height: MediaQuery.of(context).size.height*0.8,
        child: CachedNetworkImage(
          imageUrl: widget.url,
          placeholder: (context, url) => CircularProgressIndicator(),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}