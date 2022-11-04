import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_film/blocs/search_film/search_film_bloc.dart';
import 'package:random_film/blocs/search_users/search_users_bloc.dart';
import 'package:random_film/components/user_card.dart';
import 'package:random_film/services/shared_list_service.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            title: const Text('Aggiungi un utente')),
        body: BlocProvider(
          create: (context) => SearchUsersBloc(),
          child: BlocBuilder<SearchUsersBloc, SearchUsersState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged:
                              context.watch<SearchUsersBloc>().searchUser,
                          decoration: InputDecoration(
                              label: const Text('Cerca'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )),
                  Expanded(
                    flex: 6,
                    child: Builder(builder: (context) {
                      if (state is SearchingUser) {
                        return const SpinKitWave(size: 60, color: Colors.green);
                      } else {
                        return ListView.builder(
                            itemCount:
                                state is SearchedUser ? state.users.length : 0,
                            itemBuilder: (context, index) {
                              if (state is SearchedUser) {
                                return UserCard(
                                    user: state.users[index]!, onTap: () {
                                      SharedListService().createSharedList(state.users[index]!.id);
                                      Navigator.pop(context);
                                });
                              } else {
                                return Container();
                              }
                            });
                      }
                    }),
                  )
                ],
              );
            },
          ),
        ));
  }
}
