import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageFull extends StatefulWidget {
  final String url;

  const ImageFull({Key key, this.url}) : super(key: key);

  @override
  _ImageFullState createState() => _ImageFullState();
}

class _ImageFullState extends State<ImageFull> {
  bool isLoading = false;
  int _progress = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: CachedNetworkImage(
          imageUrl: widget.url,
          placeholder: (context, url) => CircularProgressIndicator(),
          fit: BoxFit.fitWidth,
        ),

        // decoration: BoxDecoration(
        //   image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: FaIcon(
            FontAwesomeIcons.download,
            color: Colors.white,
          ),
          onPressed: () async {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: new Row(
              children: <Widget>[
                new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                new Text("     Downloading Image")
              ],
            )));
            var imageId = await ImageDownloader.downloadImage(widget.url,
                destination: AndroidDestinationType.custom(
                    directory: "ISKCON Daily Darshan"));

            _displaySnackBar(context, imageId);
            // _scaffoldKey.currentState.showSnackBar(
            //   SnackBar(
            //     content: Text('Image Downloaded'),
            //     duration: Duration(seconds: 4),
            //     action: SnackBarAction(
            //         label: "View Image",
            //         onPressed: () async {
            //           var path = await ImageDownloader.findPath(imageId);
            //           await ImageDownloader.open(path).catchError((error) {
            //             _scaffoldKey.currentState.showSnackBar(SnackBar(
            //               content: Text((error as PlatformException).message),
            //             ));
            //           });
            //         }),
            //   ),
            // );
          }),
    );
  }

  _displaySnackBar(BuildContext context, var imageId) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Image Downloaded'),
        duration: Duration(seconds: 4),
        action: SnackBarAction(
            label: "View Image",
            onPressed: () async {
              var path = await ImageDownloader.findPath(imageId);
              await ImageDownloader.open(path).catchError((error) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text((error as PlatformException).message),
                ));
              });
            }),
      ),
    );
  }
}
