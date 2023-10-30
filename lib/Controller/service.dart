import 'dart:developer';

import 'package:dio/dio.dart';
 Dio dio=Dio();
class DioService {
  
  Future<dynamic>getMusic(String url){

   dio.options.headers['Content-type']='application/json';
    return dio.get(
    url,
    options: Options(
      method: 'Get',
     responseType: ResponseType.json
    )).then((value) {

         log(value.toString());
      return value;


    }).catchError((e){
      if (e is DioException) {
        print(e.toString());
      }
    });
  }

  





}