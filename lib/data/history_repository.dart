import 'package:dio/dio.dart';
import 'package:test_1/data/token.dart';
import 'package:test_1/models/response_model.dart';

import '../models/history.dart';

class HistoryRepository {
  Dio dio = Dio();

  Future<ResponseModel<List<History>>> getHistory() async {
    try {
      Map<String, String?> headers = {
        "Authorization": "JWT ${await Token().accessToken}",
      };

      var response = await dio.get(
        'https://yasser39.pythonanywhere.com/attendance/records/',
        options: Options(headers: headers),
      );

      List<History> history = [];
      for (var i in response.data) {
        history.add(History.fromJson(i));
      }
      return ResponseModel.complete(data: history);
    } on DioError catch (e) {
      String message =
          e.response == null ? e.message : e.response!.data['detail'];
      if (e.type == DioErrorType.other) {
        return ResponseModel.withError(message: message);
      }
      return ResponseModel.withError(message: message);
    } on Exception catch (e) {
      return ResponseModel.withError(message: e.toString());
    }
  }
}
