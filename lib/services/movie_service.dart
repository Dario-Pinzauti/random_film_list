import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_film/dtos/movie.dart';
import 'package:random_film/services/dmdb_service.dart';

class MovieService {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Future<Movie> getMovieById(int id) async{
    var response = await RFService().getService.get("/movie/$id");
    return Movie.fromJson(response.data);
  }

  Future<List<Movie>> findMovies(String title) async{
    Map<String,dynamic> queryParam = {"query":title};
    var response = await RFService().getService.get("/search/movie",queryParameters: queryParam);
    List<Movie> movies = [];
    response.data['results'].forEach((value){
      movies.add(Movie.fromJson(value));
    });
    return movies;
  }

  Future<List<int>> addFilmToList(Movie movie) async{
    var userList = db.collection("lists").doc(auth.currentUser?.uid).collection("list");
    userList.doc(movie.id.toString()).set(movie.toJson());
    var querySnapshot = await userList.get();
    var movieList = querySnapshot.docs.map((e) => Movie.fromJson(e.data()));
    return movieList.map((e) => e.id).toList();
  }

  Future<List<int>> getFilmListId() async{
    var userList = db.collection("lists").doc(auth.currentUser?.uid).collection("list");
    var querySnapshot = await userList.get();
    var movieList = querySnapshot.docs.map((e) => Movie.fromJson(e.data()));
    return movieList.map((e) => e.id).toList();
  }

  Future<List<Movie>> getFilmList() async{
    var userList = db.collection("lists").doc(auth.currentUser?.uid).collection("list");
    var querySnapshot = await userList.get();
    Iterable<Movie> movieList = querySnapshot.docs.map((e) => Movie.fromJson(e.data()));
    int order(Movie a,Movie b) => a.insertDate!.compareTo(b.insertDate!);
    var list = movieList.toList();
    list.sort(order);
    return list;
  }

  Future<void> removeFilmByList(Movie movie) async{
    var userList = db.collection("lists").doc(auth.currentUser?.uid).collection("list");
   await userList.doc(movie.id.toString()).delete();
  }

  Future<void> setFilmWatched(Movie movie) async{
    var userList = db.collection("lists").doc(auth.currentUser?.uid).collection("list");
    movie.watch = !movie.watch!;
    await userList.doc(movie.id.toString()).set(movie.toJson());
  }

}