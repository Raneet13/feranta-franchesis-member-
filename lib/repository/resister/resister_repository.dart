import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs/app_url.dart';
import '../../data/network/api_helper.dart';

class ResisterRepository {
  Future resisterDriver(
      {required name,
      required email,
      required contact,
      required altcontact,
      required state,
      required city,
      required pincode,
      required address1,
      required license_no,
      required password,
      required ac_name,
      required bank_name,
      required acc_no,
      required ifsc,
      required exp_year,
      required img,
      required frontimg,
      required backimg,
      required license_img,
      required adharno,
      required member_id}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'full_name': name,
        'email': email,
        'contact_no': contact,
        'altcontact': altcontact,
        'state': state,
        'city': city,
        'pincode': pincode,
        'address1': address1,
        'license_no': license_no,
        'password': password,
        'ac_name': ac_name,
        'bank_name': bank_name,
        'acc_no': acc_no,
        'ifsc': ifsc,
        'exp_year': exp_year,
        'img': img,
        'frontimg': frontimg,
        'backimg': backimg,
        'license_img': license_img,
        'adharno': adharno,
        'member_id': member_id
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.driverResister, formData: formData);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }

  Future getMasterrepo() async {
    late var response;
    try {
      response = await NetworkApiService().getApi(url: AppUrl.getallMaster);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future customerRegiRepo(
      {required member_id,
      required name,
      required phone,
      required email,
      required profile_image,
      required wp_contact}) async {
    late var response;
    try {
      FormData formData = FormData.fromMap({
        'member_id': member_id,
        'name': name,
        'phone': phone,
        'email': email,
        'profile_image': profile_image,
        'wp_contact': wp_contact
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.customerRegistation, formData: formData);
    } catch (e) {}
    return response;
  }

  Future resisterOwner({
    required name,
    required email,
    required contact,
    required altcontact,
    required state,
    required city,
    required pincode,
    required address1,
    required license_no,
    required password,
    required ac_name,
    required bank_name,
    required acc_no,
    required ifsc,
    required img,
    required frontimg,
    required backimg,
    required license_img,
    required adharno,
    required member_id,
    required is_driver,
  }) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'full_name': name,
        'email': email,
        'contact_no': contact,
        'altcontact': altcontact,
        'state': state,
        'city': city,
        'pincode': pincode,
        'address1': address1,
        'license_no': license_no,
        'password': password,
        'ac_name': ac_name,
        'bank_name': bank_name,
        'acc_no': acc_no,
        'ifsc': ifsc,
        'img': img,
        'frontimg': frontimg,
        'backimg': backimg,
        'license_img': license_img,
        'adharno': adharno,
        'member_id': member_id,
        'is_driver': is_driver
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.driverResister, formData: formData);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }
}
