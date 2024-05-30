import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs/app_url.dart';
import '../../data/network/api_helper.dart';

class AuthApiRepository {
  Future loginRepo({required phone, required password}) async {
    late var response;

    try {
      FormData formData =
          FormData.fromMap({'phone': phone, 'password': password});
      response = await NetworkApiService()
          .postApi(url: AppUrl.login, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  // Future verifyotpHome({required phoneNo, required otp}) async {
  //   late var response;

  //   try {
  //     FormData formData = FormData.fromMap({
  //       'phone': phoneNo.toString(),
  //       'entered_otp': otp.toString()
  //       // 'age': 25,
  //       // 'file':
  //       //     await MultipartFile.fromFile('./text.txt', filename: 'upload.txt')
  //     });
  //     response = await NetworkApiService()
  //         .postApi(url: AppUrl.verifyOtpLogin, formData: formData);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //   return response;
  // }
}
