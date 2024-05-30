import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feranta_franchise/configs/app_url.dart';

import '../response/exception.dart';
import '../response/response_check.dart';

class NetworkApiService {
  var dio = Dio();
  // Future<dynamic> getApi(String urll, {Map<String, String>? header}) async {
  //   late var jsonResponse;
  //   try {
  //     var response =
  //         await http.get(Uri.parse("${base_url + urll}"), headers: header);
  //     // print(response);
  //     jsonResponse = checkREsponse(response);
  //   } on SocketException {
  //     // print("No Internet");
  //     throw FetchDataException("No internet");
  //   }
  //   return jsonResponse;
  // }

  Future postApi({required url, required FormData formData}) async {
    late var jsonResponse;

    try {
      var response = await dio.post(
        "${AppUrl.baseUrl}${url}",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );
      // print(response);
      jsonResponse = checkREsponse(response);
    } on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }

  Future getApi({required url}) async {
    late var jsonResponse;

    try {
      var response = await dio.get(
        "${AppUrl.baseUrl}${url}",
      );
      // print(response);
      jsonResponse = checkREsponse(response);
    } on SocketException {
      // print("No Internet");
      throw FetchDataException("No internet");
    }
    return jsonResponse;
  }
}
