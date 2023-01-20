import 'package:flutter/material.dart';
import 'package:totalclinic/user/userInfoHelper.dart';
import '../consts/theme.dart';
import '../data/sharedPrefs.dart';
import 'UserRepo.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String ?uid;

  _getUId() {
    dynamic val = sharedPrefs.getValueFromSharedPrefs("uid");
    this.uid = val;
  }

  @override
  void initState() {
    _getUId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.add_a_photo_sharp,
            color: AppTheme.iconColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info,
              color: AppTheme.iconColor,
            ),
            onPressed: () {
              // showDialog(
              //     context: context,
              //     barrierDismissible: true,
              //     builder: (context) => UseOfDataDialog());
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "User info",
          style: TextStyle(color: AppTheme.iconColor),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: UserRepo().getReferenceSnapshots(uid!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return UserInfoHelper(snapshot: snapshot.data);
          } else if (snapshot.hasError ||
              snapshot == null ||
              snapshot.connectionState == ConnectionState.none) {
            return _errorBuilder();
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  _errorBuilder() {
    return Center(
      child: Text("An error Occured"),
    );
  }
}
