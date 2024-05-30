import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs/app_url.dart';
import '../../data/network/api_helper.dart';

class ProfileRepository {
  Future viewProfie({required member_id}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'user_id': member_id});
      response = await NetworkApiService()
          .postApi(url: AppUrl.profile, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future updateProfie(
      {required customer_id,
      required name,
      required email,
      required contact_no,
      required image}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'customer_id': customer_id,
        'name': name,
        'email': email,
        'contact_no': contact_no,
        'image': image
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.updateProfile, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}
