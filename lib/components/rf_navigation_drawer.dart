import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RfNavigationDrawer extends StatelessWidget {
  final List<Widget> listItems;
  const RfNavigationDrawer({Key? key, required this.listItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    List<Widget> localList = [
      UserAccountsDrawerHeader(
        otherAccountsPictures: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
        accountName: Text(currentUser!.displayName != null
            ? currentUser.displayName!
            : ''),
        accountEmail: Text(currentUser.email!),
        currentAccountPicture: Image.network(currentUser.photoURL != null
            ? currentUser.photoURL!
            : 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png'),
      )
    ];
    localList.addAll(listItems);


    return Drawer(
      child: ListView(
        children: localList,
      ),
    );
  }
}

