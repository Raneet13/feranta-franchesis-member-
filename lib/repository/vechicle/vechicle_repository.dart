import 'dart:convert';

import 'package:dio/dio.dart';

import '../../configs/app_url.dart';
import '../../data/network/api_helper.dart';

class VehicleRepository {
  Future viewAllOwner({required member_id}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'member_id': member_id});
      response = await NetworkApiService()
          .postApi(url: AppUrl.getAllOwner, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future viewAllDriver({required member_id}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'member_id': member_id});
      response = await NetworkApiService()
          .postApi(url: AppUrl.getvehicleList, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future addCabRepo(
      {required member_id,
      required owner_id,
      required no_of_sit,
      required redg_no,
      required model_name,
      required vehicle_type,
      required insurance_img,
      required fit_doc,
      required pollurion_doc,
      required permit_doc,
      required vehicle_make,
      required vehicle_body,
      required engine_no,
      required chassis_no,
      required manufacture_yr,
      required vehicle_cc,
      required insurance_date_from,
      required insurance_date_to,
      required fit_expr,
      required polution_exp_date,
      required permit_expr_date,
      required booking_type,
      required rc_no,
      required rc_copy,
      required driver_id}) async {
    late var response;
    try {
      FormData formData = FormData.fromMap({
        'member_id': member_id,
        'owner_id': owner_id,
        'no_of_sit': no_of_sit,
        'redg_no': redg_no,
        'model_name': model_name,
        'vehicle_type': vehicle_type,
        'insurance_img': insurance_img,
        'fit_doc': fit_doc,
        'pollurion_doc': pollurion_doc,
        'permit_doc': permit_doc,
        'vehicle_make': vehicle_make,
        'vehicle_body': vehicle_body,
        'engine_no': engine_no,
        'chassis_no': chassis_no,
        'manufacture_yr': manufacture_yr,
        'vehicle_cc': vehicle_cc,
        'insurance_date_from': insurance_date_to,
        'insurance_date_to': insurance_date_to,
        'fit_expr': fit_expr,
        'polution_exp_date': polution_exp_date,
        'permit_expr_date': permit_expr_date,
        'booking_type': booking_type,
        'rc_no': rc_no,
        'rc_copy': rc_copy,
        'driver_id': driver_id
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.addVehicle, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future updateCabRepo(
      {required vehicleid,
      required member_id,
      required owner_id,
      required no_of_sit,
      required redg_no,
      required model_name,
      required vehicle_type,
      required insurance_img,
      required fit_doc,
      required pollurion_doc,
      required permit_doc,
      required vehicle_make,
      required vehicle_body,
      required engine_no,
      required chassis_no,
      required manufacture_yr,
      required vehicle_cc,
      required insurance_date_from,
      required insurance_date_to,
      required fit_expr,
      required polution_exp_date,
      required permit_expr_date,
      required booking_type,
      required rc_no,
      required rc_copy,
      required driver_id}) async {
    late var response;
    try {
      FormData formData = FormData.fromMap({
        'vehicle_id': vehicleid,
        'member_id': member_id,
        'owner_id': owner_id,
        'no_of_sit': no_of_sit,
        'redg_no': redg_no,
        'model_name': model_name,
        'vehicle_type': vehicle_type,
        'insurance_img': insurance_img,
        'fit_doc': fit_doc,
        'pollurion_doc': pollurion_doc,
        'permit_doc': permit_doc,
        'vehicle_make': vehicle_make,
        'vehicle_body': vehicle_body,
        'engine_no': engine_no,
        'chassis_no': chassis_no,
        'manufacture_yr': manufacture_yr,
        'vehicle_cc': vehicle_cc,
        'insurance_date_from': insurance_date_to,
        'insurance_date_to': insurance_date_to,
        'fit_expr': fit_expr,
        'polution_exp_date': polution_exp_date,
        'permit_expr_date': permit_expr_date,
        'booking_type': booking_type,
        'rc_no': rc_no,
        'rc_copy': rc_copy,
        'driver_id': driver_id
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.editVehicle, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future viewAllVechicle({required member_id}) async {
    late var response;

    try {
      FormData formData = FormData.fromMap({'member_id': member_id});
      response = await NetworkApiService()
          .postApi(url: AppUrl.getVehicle, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  // Future updateProfie(
  //     {required customer_id,
  //     required name,
  //     required email,
  //     required contact_no,
  //     required image}) async {
  //   late var response;

  //   try {
  //     FormData formData = FormData.fromMap({
  //       'customer_id': customer_id,
  //       'name': name,
  //       'email': email,
  //       'contact_no': contact_no,
  //       'image': image
  //     });
  //     response = await NetworkApiService()
  //         .postApi(url: AppUrl.updateProfile, formData: formData);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //   return response;
  // }
  Future vechicleasignOTPdriver(
      {required owner_id, required driver_id, required vehicle_id}) async {
    late var response;
    try {
      FormData formData = FormData.fromMap({
        'owner_id': owner_id,
        'driver_id': driver_id,
        'vehicle_id': vehicle_id
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.asigndriverOtp, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }

  Future verifyvechicleasignOTPdriver(
      {required owner_id,
      required driver_id,
      required vehicle_id,
      required otp}) async {
    late var response;
    try {
      FormData formData = FormData.fromMap({
        'owner_id': owner_id,
        'driver_id': driver_id,
        'vehicle_id': vehicle_id,
        'otp': otp
      });
      response = await NetworkApiService()
          .postApi(url: AppUrl.verifyAsignVechicleOTP, formData: formData);
    } catch (e) {
      throw Exception(e);
    }
    return response;
  }
}
