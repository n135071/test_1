
import 'package:dio/dio.dart';
import 'package:test_1/data/token.dart';
import 'package:test_1/models/response_model.dart';

import '../models/pic_and_location_api.dart';

class PictureRepository {
  Dio dio = Dio();

  Future<ResponseModel<String>> submit(PictureAndLocation pictureAndLocation) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(pictureAndLocation.image!.path),
        "latitude": pictureAndLocation.latitude ?? '0',
        "longitude": pictureAndLocation.longitude ?? '0',
        "kind": pictureAndLocation.type,
      });

      Map<String, String?> headers = {
        "Authorization": "JWT ${await Token().accessToken}",

      };

     var response = await dio.post(
        'https://yasser39.pythonanywhere.com/attendance/records/',
        data: formData,
        options: Options(headers: headers),
      );

      return ResponseModel.complete(data: response.data);
    } on DioError catch (e) {
      String message =
          e.response == null ? e.message : e.response!.data['detail'];
      if (e.type == DioErrorType.other) {
        return ResponseModel.withError(message: e.message);
      }
      return ResponseModel.withError(message: message);
    } on Exception catch (e){
      return ResponseModel.withError(message: e.toString());
    }
  }
}
