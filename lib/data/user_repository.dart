import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_1/data/token.dart';

import '../models/user.dart';

class UserRepository {
  static const String baseUrl = 'https://yasser39.pythonanywhere.com/';
  Dio dio = Dio();

  Future<String> login(User user) async {
    try {
      var response = await dio.post(
        '${baseUrl}auth/jwt/create/',
        data: user.toJson(),
      );
      Token().setTokens(
        access: response.data['access'],
        refresh: response.data['refresh'],
      );

      return "completed";
    } on DioError catch (e) {
      String message =
          e.response == null ? e.message : e.response!.data['detail'];
      if (e.type == DioErrorType.other) {
        return 'no internet connection';
      }
      return message;
    } on Exception {
      return 'error';
    }
  }
}
