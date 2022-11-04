import 'package:flutter/material.dart';

import '../dtos/movie.dart';

class FilmCard extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;
  final Color borderColor;
  final Widget? button;

  const FilmCard({Key? key, required this.movie, required this.onTap, required this.borderColor, this.button}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          semanticContainer: true,
          borderOnForeground: true,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor),
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
                          "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                          height: 100,
                          errorBuilder: (context, error, stackTrace) => Image.asset("assets/images/image_not_found.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListTile(

                          title: Text(movie.title!),
                          subtitle: Text(
                            movie.overview!,
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



