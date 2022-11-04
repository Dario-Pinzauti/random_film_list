import 'package:random_film/dtos/movie.dart';

class SharedMovie extends Movie {
  final String? userId;

  SharedMovie(
      {required this.userId,
      required super.id,
      super.watch,
      super.insertDate,
      super.backdropPath,
      super.posterPath,
      super.overview,
      super.title,
      super.budget,
      super.genres,
      super.originalTitle,
      super.releaseDate,
      super.revenue})
      : super();

  factory SharedMovie.fromJson(Map<String, dynamic> json) => SharedMovie(
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
      userId: json['user_id'] ?? null,
      //TODO generes
  );

  factory SharedMovie.fromMovie(Movie movie,String userId) => SharedMovie(
      originalTitle: movie.originalTitle,
      title: movie.title,
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      id: movie.id,
      revenue: movie.revenue,
      budget: movie.budget,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      watch: movie.watch,
      insertDate: movie.insertDate,
      userId: userId,
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
      data['user_id']=userId;
      return data;
  }



}
