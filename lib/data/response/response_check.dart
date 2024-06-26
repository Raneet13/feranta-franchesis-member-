import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feranta_franchise/data/response/exception.dart';

dynamic checkREsponse(response) {
  if (response.statusCode == 201) {
    var data = response.data;
    // ShowToast(msg: data);
    return data;
  } else if (response.statusCode == 400) {
    return BadRequestException(response.data.toString());
  } else {
    return FetchDataException(
        "Error Occured while communicate the server with status code: ${response.statusCode}");
  }
}
