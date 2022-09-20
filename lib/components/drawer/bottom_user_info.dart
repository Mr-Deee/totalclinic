import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalclinic/Pages/signin.dart';
import 'package:totalclinic/models/user_model.dart';



class BottomUserInfo extends StatelessWidget {
  final bool ?isCollapsed;

  const BottomUserInfo({
    Key? key,
    this.isCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isCollapsed! ? 70 : 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isCollapsed!
          ? Center(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://t3.ftcdn.net/jpg/02/99/21/98/360_F_299219888_2E7GbJyosu0UwAzSGrpIxS0BrmnTCdo4.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0,),
                          child: Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                children: [
                                  Container(

                                    child: Text(
                                      '',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                  if (Provider.of<UserModel>(context).userInfo?.FirstName != null)
                                    Text(
                                      Provider.of<UserModel>(context).userInfo!.FirstName!,


                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(

                            child: Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        onPressed: () {

                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Sign Out'),
                                backgroundColor: Colors.white,
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Are you certain you want to Sign Out?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      print('yes');
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, SignInPage.idScreen, (route) => false);
                                      // Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://t3.ftcdn.net/jpg/02/99/21/98/360_F_299219888_2E7GbJyosu0UwAzSGrpIxS0BrmnTCdo4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
