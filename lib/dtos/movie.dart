import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String? backdropPath;
  final String? originalTitle;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? releaseDate;
  final int? budget;
  final int id;
  final int? revenue;
  final List<String>? genres;
  bool? watch;
  Timestamp? insertDate;
  bool selected = false;

  Movie({this.backdropPath,
        this.originalTitle,
        this.title,
        this.overview,
        this.posterPath,
        this.releaseDate,
        this.budget,
        required this.id,
        this.revenue,
        this.genres,
        this.watch,
        this.insertDate
    });


  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        originalTitle: json["original_title"] ?? null,
        title: json["title"] ?? null,
        overview: json["overview"] ?? null,
        releaseDate: json["release_date"] ?? null,
        id: json["id"],
        revenue: json['revenue'] ?? null,
        budget: json['budget'] ?? null,
        posterPath: json['poster_path'] ?? null,
        backdropPath: json['backdrop_path'] ?? null,
        watch: json['watch'] ?? null,
        insertDate: json['insert_date'] ?? null,
        //TODO generes
      );

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path']=backdropPath;
    data['original_title']=originalTitle;
    data['title']=title;
    data['overview']=overview;
    data['poster_path']=posterPath;
    data['release_date']=releaseDate;
    data['budget']=budget;
    data['id']=id;
    data['revenue']=revenue;
    data['genre']=genres;
    data['insert_date']=insertDate;
    data['watch']=watch;
    return data;
  }

/*
  "backdrop_path" -> "/rr7E0NoGKxvbkb89eR1GwfoYjpA.jpg"
  "budget" -> 63000000
  "genres" -> [_GrowableList]
  "id" -> 550
  "original_title" -> "Fight Club"
  "overview" -> "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a sho..."
  "poster_path" -> "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"
  "release_date" -> "1999-10-15"
  "revenue" -> 100853753
  "title" -> "Fight Club"
**/

}
