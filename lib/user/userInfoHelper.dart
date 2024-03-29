import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shimmer/shimmer.dart';

import '../consts/theme.dart';
import 'user.dart';

class UserInfoHelper extends StatefulWidget {
  final DocumentSnapshot? snapshot;

  UserInfoHelper({this.snapshot});
  @override
  _UserInfoHelperState createState() => _UserInfoHelperState();
}

class _UserInfoHelperState extends State<UserInfoHelper> {
  User? user;
  var height, width;

  @override
  void initState() {
    user = User.fromSnapshot(widget.snapshot!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ListView(
      children: <Widget>[
        _buildTopWidget(),
        _buildRestPage(),
        SizedBox(
          height: 0.15 * height,
        ),
        _buildBottomPage(),
      ],
    );
  }

  _buildBottomPage() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Container(
        height: 0.2 * height,
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: AppTheme.mainColor.withOpacity(0.3),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    // showDialog(
                    //     context: context,
                    //     barrierDismissible: true,
                    //     builder: (context) => InfoDialog());
                  },
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: FloatingActionButton(
                  child: Icon(Icons.content_copy),
                  onPressed: () {
                    Clipboard.getData(user!.uid!)
                        .then((result) {
                      final snackBar = SnackBar(
                        content: Text('Copied to Clipboard'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {},
                        ),
                      );
                      //Scaffold.of(context.showSnackBar(SnackBar));
                    });
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    user!.uid??"",
                    style: TextStyle(
                        fontSize: 25, fontFamily: AppTheme.fontFamily),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRestPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 4.0,
                  color: Colors.black38.withOpacity(0.1),
                  offset: Offset(0.0, 3.0),
                  spreadRadius: 3.0),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120.0),
                child: Container(
                  height: 60,
                  width: 60,
                  color: AppTheme.mainColor,
                  child: CachedNetworkImage(
                      imageUrl: user!.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.accessible_forward_sharp, color: AppTheme.iconColor),
                      placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            color: Colors.red,
                          ),
                          baseColor: AppTheme.shimmerBaseColor!,
                          highlightColor: AppTheme.shimmerEndingColor!)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Center(
                child: Text(user!.userName!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTopWidget() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            color: Theme.of(context).cardColor,
            height: 0.20 * height,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120.0),
              child: Hero(
                tag: 'userImage',
                child: Container(
                  height: 175,
                  width: 175,
                  color: AppTheme.mainColor,
                  child: CachedNetworkImage(
                      imageUrl: user!.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.accessible_forward_sharp, color: AppTheme.iconColor),
                      placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            color: Colors.red,
                          ),
                          baseColor: AppTheme.shimmerBaseColor!,
                          highlightColor: AppTheme.shimmerEndingColor!)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
