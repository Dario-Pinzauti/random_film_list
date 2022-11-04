import 'dart:io';

import 'package:dio/dio.dart';
class RFService {
  static final RFService _service = RFService._internal();
  static var dio = null;

  static const String movieDbToken = String.fromEnvironment(
    'MOVIE_DB_TOKEN',
  );

  static intService(){
    dio = Dio();
    dynamic token = movieDbToken;
    dio.options
      ..baseUrl = 'https://api.themoviedb.org/3/'
      ..connectTimeout = 5000 //5s
      ..receiveTimeout = 5000
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..queryParameters.addAll({'api_key':token})
      ..headers = {
        HttpHeaders.userAgentHeader: 'dio',
      };
  }

  factory RFService(){
    if(dio == null){
      intService();
    }
    return _service;
  }

  RFService._internal();

  Dio get getService{
    if(dio != null){
      return dio;
    } else{
      intService();
      return dio;
    }
  }
}
