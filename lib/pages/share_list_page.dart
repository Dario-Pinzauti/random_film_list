import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/components/rf_navigation_drawer.dart';
import 'package:random_film/drawers/page_drawer.dart';
import 'package:random_film/dtos/shared_list.dart';
import 'package:random_film/pages/add_user_page.dart';
import 'package:random_film/pages/shared_list_detail.dart';

import '../blocs/manage_shared_lists/manage_shared_lists_bloc.dart';

class ShareListPage extends StatelessWidget {
  const ShareListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: RfNavigationDrawer(listItems: _drawerMenu(context)),
      floatingActionButton: _floatingActionButton(context),
      appBar: _appBar(),
      body: _sharedList(context),
    );
  }
}

PreferredSizeWidget _appBar() => AppBar(title: Text('Liste Condivise'));

Widget _sharedList(BuildContext context) => BlocProvider(
      create: (context) => ManageSharedListsBloc(),
      child: BlocBuilder<ManageSharedListsBloc, ManageSharedListsState>(
        builder: (context, state) {
          return Builder(builder: (context) {
            if (state is GettingSharedLists) {
              return const SpinKitWave(size: 60, color: Colors.orange);
            } else {
              return GridView.builder(
                itemCount:
                    state is GottenSahredLists ? state.sharedLists.length : 0,
                itemBuilder: (context, index) {
                  if (state is GottenSahredLists) {
                    return _cardSharedList(
                        context, state.sharedLists[index], state);
                  } else {
                    return Container();
                  }
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
              );
            }
          });
        },
      ),
    );

Widget _cardSharedList(BuildContext context, SharedList sharedList,
        ManageSharedListsState state) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SharedListDetail(state: state, listId: sharedList.id!)));
      },
      child: Card(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: Image.network(FirebaseAuth
                                    .instance.currentUser?.photoURL !=
                                null
                            ? FirebaseAuth.instance.currentUser!.photoURL!
                            : 'https://cdn-icons-png.flaticon.com/512/1946/1946429.png')
                        .image,
                    radius: 35,
                  ),
                ),
              ],
            ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(FirebaseAuth.instance.currentUser!.displayName!,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                           Text(FirebaseAuth.instance.currentUser!.email!)
                    ],
                  ),
                ),
          ],
        ),
      ),
    );

List<Widget> _drawerMenu(BuildContext context) => [
      ListTile(
          title: Text('La tua Lista'),
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PageDrawer()),
                ModalRoute.withName('/'));
          },
          leading: Icon(Icons.view_list_rounded)),
      Divider(),
      ListTile(
        selected: true,
        title: Text('Liste condvise'),
        onTap: () {
          Navigator.pop(context);
        },
        leading: Icon(Icons.share),
      ),
      Divider(),
    ];

Widget _floatingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddUserPage()),
        );
      },
      child: Icon(Icons.share),
    );
