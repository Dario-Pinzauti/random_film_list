import 'package:flutter/material.dart';
import 'package:random_film/dtos/user.dart';

import '../dtos/movie.dart';

class UserCard extends StatelessWidget {
  final RLUser user;
  final Function()? onTap;
  final Widget? button;

  const UserCard({Key? key, required this.user, required this.onTap, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          semanticContainer: true,
          borderOnForeground: true,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 100,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10)),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/",
                          height: 100,
                          errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/image_not_found.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListTile(

                          title: Text(user.name!),
                          subtitle: Text(
                            user.email,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    Expanded(child: button ?? Container())
                  ],
                ),
          )),
    );
  }
}



