import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:feranta_franchise/static/flutter_toast_message/toast_messge.dart';

import '../../configs/app_url.dart';
import '../../data/network/api_helper.dart';

class ResisterRepository {
  Future resisterDriver({
    required name,
    required email,
    required contact,
    required altcontact,
    required state,
    required city,
    required String pincode,
    required address1,
    required address2,
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
    required member_id,
    required branch_name,
    required block,
    required ditrict,
    required father_name,
    required blood_group,
    required cheque,
    required spouse_name,
    required license_expire_date,
    required dob,
    required mother_name,
    required nominee_name,
    required nominee_rltn,
    required nominee_add,
    required nominee_dob,
    required license_type,
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
        'address2': address2,
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
        'member_id': member_id,
        'branch_name': branch_name,
        'block': block,
        'ditrict': ditrict,
        'father_name': father_name,
        'blood_group': blood_group,
        'cheque': cheque,
        'spouse_name': spouse_name,
        'license_expire_date': license_expire_date,
        'dob': dob,
        'mother_name': mother_name,
        'nominee_name': nominee_name,
        'nominee_rltn': nominee_rltn,
        'nominee_add': nominee_add,
        'nominee_dob': nominee_dob,
        'license_type': license_type,
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

  Future resisterOwner(
      {required member_id,
      required full_name,
      required contact_no,
      required email,
      required city,
      required img,
      required frontimg,
      required backimg,
      required license_img,
      required altcontact,
      required state,
      required String pincode,
      required address1,
      required address2,
      required adharno,
      required password,
      required license_no,
      required ac_name,
      required bank_name,
      required acc_no,
      required ifsc,
      required is_driver, //
      required branch_name,
      required block,
      required ditrict,
      required father_name,
      required blood_group,
      required cheque,
      required spouse_name,
      required license_expire_date,
      required dob,
      required mother_name,
      required nominee_name,
      required nominee_rltn,
      required nominee_add,
      required nominee_dob}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'member_id': member_id,
        'full_name': full_name,
        'contact_no': contact_no,
        'email': email,
        'city': city,
        'img': img,
        'frontimg': frontimg,
        'backimg': backimg,
        'license_img': license_img,
        'altcontact': altcontact,
        'state': state,
        'pincode': pincode,
        'address1': address1,
        'address2': address2,
        'adharno': adharno,
        'password': password,
        'license_no': license_no,
        'ac_name': ac_name,
        'bank_name': bank_name,
        'acc_no': acc_no,
        'ifsc': ifsc,
        'is_driver': is_driver, //
        'branch_name': branch_name,
        'block': block,
        'ditrict': ditrict,
        'father_name': father_name,
        'blood_group': blood_group,
        'cheque': cheque,
        'spouse_name': spouse_name,
        'license_expire_date': license_expire_date,
        'dob': dob,
        'mother_name': mother_name,
        'nominee_name': nominee_name,
        'nominee_rltn': nominee_rltn,
        'nominee_add': nominee_add,
        'nominee_dob': nominee_dob
      });

      response = await NetworkApiService()
          .postApi(url: AppUrl.resisterOwner, formData: formData);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }

  Future updateResisterOwner(
      {required ownerty,
      required user_id,
      required member_id,
      required full_name,
      required contact_no,
      required email,
      required city,
      required img,
      required frontimg,
      required backimg,
      required license_img,
      required altcontact,
      required state,
      required String pincode,
      required address1,
      required address2,
      required adharno,
      required password,
      required license_no,
      required ac_name,
      required bank_name,
      required acc_no,
      required ifsc,
      required is_driver, //
      required branch_name,
      required block,
      required ditrict,
      required father_name,
      required blood_group,
      required cheque,
      required spouse_name,
      required license_expire_date,
      required dob,
      required mother_name,
      required nominee_name,
      required nominee_rltn,
      required nominee_add,
      required nominee_dob}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({
        'user_id': user_id,
        'member_id': member_id,
        'full_name': full_name,
        'contact_no': contact_no,
        'email': email,
        'city': city,
        'img': img,
        'frontimg': frontimg,
        'backimg': backimg,
        'license_img': license_img,
        'altcontact': altcontact,
        'state': state,
        'pincode': pincode,
        'address1': address1,
        'address2': address2,
        'adharno': adharno,
        'password': password,
        'license_no': license_no,
        'ac_name': ac_name,
        'bank_name': bank_name,
        'acc_no': acc_no,
        'ifsc': ifsc,
        'is_driver': is_driver, //
        'branch_name': branch_name,
        'block': block,
        'ditrict': ditrict,
        'father_name': father_name,
        'blood_group': blood_group,
        'cheque': cheque,
        'spouse_name': spouse_name,
        'license_expire_date': license_expire_date,
        'dob': dob,
        'mother_name': mother_name,
        'nominee_name': nominee_name,
        'nominee_rltn': nominee_rltn,
        'nominee_add': nominee_add,
        'nominee_dob': nominee_dob
      });

      response = await NetworkApiService()
          .postApi(url: AppUrl.update_boarding_mmber, formData: formData);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }

  Future updatecustomerRegiRepo(
      {required user_id,
      required member_id,
      required name,
      required phone,
      required email,
      required profile_image,
      required wp_contact}) async {
    late var response;
    try {
      FormData formData = FormData.fromMap({
        'user_id': user_id,
        'member_id': member_id,
        'name': name,
        'phone': phone,
        'email': email,
        'profile_image': profile_image,
        'wp_contact': wp_contact
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.update_boarding_mmber, formData: formData);
    } catch (e) {}
    return response;
  }

  Future updateresisterDriver(
      {required userI,
      required name,
      required email,
      required contact,
      required altcontact,
      required state,
      required city,
      required String pincode,
      required address1,
      required String address2,
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
      required member_id,
      required branch_name,
      required block,
      required ditrict,
      required father_name,
      required blood_group,
      required cheque,
      required spouse_name,
      required license_expire_date,
      required dob,
      required mother_name,
      required nominee_name,
      required nominee_rltn,
      required nominee_add,
      required nominee_dob}) async {
    late var response;
    ShowToast(msg: "village:${address2}");
    try {
      FormData formData = FormData.fromMap({
        'user_id': userI,
        'full_name': name,
        'email': email,
        'contact_no': contact,
        'altcontact': altcontact,
        'state': state,
        'city': city,
        'pincode': pincode,
        'address1': address1,
        'address2': address2,
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
        'member_id': member_id,
        'branch_name': branch_name,
        'block': block,
        'ditrict': ditrict,
        'father_name': father_name,
        'blood_group': blood_group,
        'cheque': cheque,
        'spouse_name': spouse_name,
        'license_expire_date': license_expire_date,
        'dob': dob,
        'mother_name': mother_name,
        'nominee_name': nominee_name,
        'nominee_rltn': nominee_rltn,
        'nominee_add': nominee_add,
        'nominee_dob': nominee_dob
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.update_boarding_mmber, formData: formData);
    } catch (e) {
      throw Exception(e);
    }

    return response;
  }
}
