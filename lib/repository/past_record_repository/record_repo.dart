import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs/app_url.dart';
import '../../data/network/api_helper.dart';

class RecordApiRepository {
  Future recordRepo({required member_id}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'member_id': member_id});
      response = await NetworkApiService()
          .postApi(url: AppUrl.getList, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}
