import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_film/dtos/movie.dart';
import 'package:random_film/dtos/shared_list.dart';
import 'package:random_film/dtos/shared_movie.dart';
import 'package:random_film/dtos/user.dart';

class SharedListService {
  var db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  Future<SharedList> createSharedList(String requestUserId) async {
    var id = [requestUserId, auth.currentUser!.uid.toString()];
    id.sort();
    var doc = db.collection("shared_list").doc(id.join()).collection("list");
    var sharedList = SharedList(filmNumber: 5, usersId: id);
    await db.collection("shared_list").doc(id.join()).set(
        sharedList.toJson());
    return sharedList;
  }

  Future<List<SharedList>?> getSharedLists() async {
    var doc = db.collection("shared_list").where("users_id",arrayContains:auth.currentUser!.uid );
    var future = await doc.get();
    var map = future.docs.map((e)=>SharedList.fromJson(e.data()));
    return map.toList();
  }

  Future<List<SharedMovie>?> getMoviesBySharedListId(String id) async {
    var doc = db.collection("shared_list").doc(id).collection("list");
    var future = await doc.get();
    var map = future.docs.map((e)=>SharedMovie.fromJson(e.data()));
    return map.toList();
  }

  Future<void> addMoviesInToSharedList(String sharedListId , SharedMovie movie) async {
    var doc = db.collection("shared_list").doc(sharedListId).collection("list");
    var future = await doc.doc(movie.id.toString()).set(movie.toJson());
  }


  Future<void> watchMovieInSharedList(String sharedListId  ,SharedMovie movie) async {
    var doc = db.collection("shared_list").doc(sharedListId).collection("list");
    movie.watch = !movie.watch!;
    var future = await doc.doc(movie.id.toString()).set(movie.toJson());
  }

  Future<void> removeMovieInSharedList(String sharedListId  ,SharedMovie movie) async {
    var doc = db.collection("shared_list").doc(sharedListId).collection("list");
    var future = await doc.doc(movie.id.toString()).delete();
  }

  Future<List<int>> getSharedFilmListId(String listId) async{
    var doc = db.collection("shared_list").doc(listId).collection("list");
    var future = await doc.get();
    var movieList = future.docs.map((e) => Movie.fromJson(e.data()));
    return movieList.map((e) => e.id).toList();
  }

  Future<List<SharedMovie>?> getFilmList(String listId) async{
    var userList = db.collection("lists").doc(auth.currentUser?.uid).collection("list");
    var querySnapshot = await userList.get();
    var sharedFilmListId = await getSharedFilmListId(listId);
    Iterable<Movie> movieList = querySnapshot.docs.map((e) => Movie.fromJson(e.data()));
    int order(Movie a,Movie b) => a.insertDate!.compareTo(b.insertDate!);
    var list = movieList.where((element) => !sharedFilmListId.contains(element.id)).toList();
    list.sort(order);
    return list.map((e) => SharedMovie.fromMovie(e,auth.currentUser!.uid)).toList();
  }

}
