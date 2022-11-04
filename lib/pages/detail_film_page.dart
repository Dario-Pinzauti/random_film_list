import 'package:flutter/material.dart';
import 'package:random_film/dtos/movie.dart';

class DetailListPage extends StatelessWidget {
  final Movie film;

  const DetailListPage({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Stack(alignment: AlignmentDirectional.topStart, children: [
        Stack(
          children: [
            Image.network(
                "https://image.tmdb.org/t/p/w500/${film.backdropPath}"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Card(
            margin: EdgeInsetsGeometry.lerp(
                EdgeInsets.all(0), EdgeInsets.all(0), 0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/${film.posterPath}",
                          height: 150,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/images/image_not_found.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        title: Text(film.title!,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Expanded(
                      child: Text(
                    film.overview!,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      film.revenue != null
                          ? Text("Costo : ${film.revenue!}")
                          : Container(),
                      film.releaseDate != null
                          ? Text("Data di uscita : ${film.releaseDate!}")
                          : Container(),
                      film.budget != null
                          ? Text("Budget : ${film.budget!}")
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
