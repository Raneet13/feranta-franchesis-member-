// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:feranta_franchise/model/resister/master_model.dart' as master;
import 'package:feranta_franchise/static/validator/all_textfield_validator.dart';
import 'package:feranta_franchise/view_model/vechicle_viewwModel/vechicle_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../model/vechicle/vechicle_record_model.dart';
import '../../../../static/color.dart';
import '../../../../static/flutter_toast_message/toast_messge.dart';

class AddVechicle extends StatefulWidget {
  VehicleList? vehicleDetails;
  AddVechicle({required this.vehicleDetails, super.key});

  @override
  State<AddVechicle> createState() => _AddVechicleState();
}

class _AddVechicleState extends State<AddVechicle> {
  // TextEditingController vechicleNo = TextEditingController();
  // // // TextEditingController lname = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController phoone = TextEditingController();
  // TextEditingController altPhone = TextEditingController();
  // // TextEditingController image = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey();
  // final items = ['CAB', 'AMBULANCE', 'LIFT'];
  // String selectedValue = 'CAB';
  // String? file1;
  // String? file2;
  // String? path;
  // File? profileImage;

  int index = 0;
  @override
  void initState() {
    // TODO: implement initState

    // var provider = Provider.of<signProvider>(context, listen: false);
    // provider.deliveryBoyLoginProfile;

    // address2 = TextEditingController(text: widget.address["adress2"]);
    // cityName = widget.address["cityname"];
    // areaName = widget.address["cityname"];
    // pincode = widget.address["pincode"];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<VehicleViewmodel>(context, listen: false)
        ..getAllMaster()
        ..allDriverListViewModel()
        ..allOwnerListViewModel().then((value) async {
          if (VehicleList != null) {
            await Provider.of<VehicleViewmodel>(context, listen: false)
                .initVehicle(widget.vehicleDetails!);
          }
        });
    });
  }

  Validate(input) {
    if (input.isEmpty) {
      return 'Please type something';
    }
    return null;
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   Provider.of<VehicleViewmodel>(context, listen: false).isLoading = false;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[100],
          leading: InkWell(
            onTap: () async {
              await Provider.of<VehicleViewmodel>(context, listen: false)
                  .clearDriverAddDett();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "${widget.vehicleDetails != null ? "Update" : "Add"}  Vechicle",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar:
            Provider.of<VehicleViewmodel>(context, listen: true).visibleOwner
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Consumer<VehicleViewmodel>(
                        builder: (context, loginD, _) {
                      return SizedBox(
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (widget.vehicleDetails != null) {
                                  loginD.updateCabView(context, loginD.ownerId,
                                      widget.vehicleDetails!.id.toString());
                                  ShowToast(msg: "UpdateVechicle");
                                } else if (loginD.vechiceCabCategry != "" ||
                                    loginD.ownerId != null) {
                                  loginD.addCab(
                                      context, loginD.ownerId); //need to update
                                } else {
                                  ShowToast(
                                      msg:
                                          "Input All the Field: Owner, Booking Type & Vehicle Type");
                                }
                              }
                            },
                            child: loginD.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "${widget.vehicleDetails == null ? "Add" : "Update"}")),
                      );
                    }),
                  ),
        body: Consumer<VehicleViewmodel>(builder: (context, val, _) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      // physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        // SizedBox(
                        //   height: 16,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   height: 16,
                              // ),
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Text("Assigned Driver"),
                              //     SizedBox(
                              //       height: 48,
                              //       child: TextFormField(
                              //         maxLines: 1,
                              //         readOnly: true,
                              //         controller: val.driverFind,
                              //         // validator: (value) =>
                              //         //     ValidateAll.inputValidate(value),
                              //         keyboardType: TextInputType.emailAddress,
                              //         style: TextStyle(
                              //           color: Colors.black,
                              //           fontSize: 12,
                              //         ),
                              //         decoration: InputDecoration(
                              //           fillColor: Colors.grey.shade200,
                              //           filled: true,
                              //           errorStyle: TextStyle(fontSize: 0),
                              //           contentPadding:
                              //               EdgeInsets.only(left: 15, right: 5),
                              //           focusedBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //             borderSide: BorderSide(
                              //               color: Colors.amber, // Border color
                              //               width: 2.0, // Border width
                              //             ),
                              //           ),
                              //           enabledBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //             borderSide: BorderSide(
                              //               color: Colo
                              //                   .blackShade45, // Border color
                              //               width: 2.0, // Border width
                              //             ),
                              //           ),
                              //           // labelStyle: Theme.of(context)
                              //           //     .textTheme
                              //           //     .bodyMedium,
                              //           disabledBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //             borderSide: BorderSide(
                              //               color: Colo
                              //                   .blackShade45, // Border color
                              //               width: 2.0, // Border width
                              //             ),
                              //           ),
                              //           border: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10.0),
                              //             borderSide: BorderSide(
                              //               color: Colo
                              //                   .blackShade45, // Border color
                              //               width: 2.0, // Border width
                              //             ),
                              //           ),
                              //           // enabled: true,
                              //           // label: Text("Enter email"),
                              //           // floatingLabelAlignment:
                              //           //     FloatingLabelAlignment.start,
                              //           hintText: "Driver Name",
                              //           // suffixIcon: Container(
                              //           //   height: 40,
                              //           //   color: Colors.amber,
                              //           //   alignment: null,
                              //           //   child: Text("Choose Location"),
                              //           // ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Enter Vechicle Number"),
                                      Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.redg_no,
                                      validator: (value) =>
                                          ValidateAll.inputValidate(value),
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter email"),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Vechicle Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Enter Chassis Number"),
                                      Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.chassis_no,
                                      validator: (value) =>
                                          ValidateAll.inputValidate(value),
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Cheese Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("Enter Engine Number"),
                                      Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.engine_no,
                                      validator: (value) =>
                                          ValidateAll.inputValidate(value),
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Engine Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      "Enter Vehicle Registration Number"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.rc_no,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "RC Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Vechicle Make"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.vehicle_make,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter email"),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Vechicle Make",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Enter Vechicle Model Name"),
                                      Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.model_name,
                                      validator: (value) =>
                                          ValidateAll.inputValidate(value),
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "model Name",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Vechicle Body"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.vehicle_body,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Vechicle Body",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Vechicle Cubic Capacity (CC)"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.vehicle_cc,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Vehicle CC",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Passenger Sit"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.no_of_sit,
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colo
                                                .blackShade45, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Vechicle Sit",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              // select type of cab by choosing option
                              Container(
                                height: 48,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(color: Colo.black),
                                    borderRadius: BorderRadius.circular(10)),
                                // color: Colors.grey.shade300,
                                // dropdown below..
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Select Booking Type"),
                                    DropdownButton<String>(
                                      // value:val.state==""? val
                                      //     .masterModel!.response!.state!.first:val.state,
                                      hint: Text(val.selectedVech),
                                      onChanged: (newValue) =>
                                          val.updateVehicleType(newValue!),
                                      items: val.vehicleType
                                          .map<DropdownMenuItem<String>>(
                                              (value) =>
                                                  DropdownMenuItem<String>(
                                                    value: value,
                                                    child:
                                                        Text(value.toString()),
                                                  ))
                                          .toList(),

                                      // add extra sugar..
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 42,
                                      underline: SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              val.selectedVech == "Ambulance"
                                  ? SizedBox()
                                  : val.selectedVech == "Cab"
                                      ? Container(
                                          height: 48,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              border:
                                                  Border.all(color: Colo.black),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          // color: Colors.grey.shade300,
                                          // dropdown below..
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                  "Select Vechicle Type"),
                                              DropdownButton<
                                                  master.VehicleType>(
                                                // value:val.state==""? val
                                                //     .masterModel!.response!.state!.first:val.state,
                                                hint:
                                                    Text(val.vechiceCabCategry),
                                                onChanged: (newValue) {
                                                  val.selectedVech == ""
                                                      ? ShowToast(
                                                          msg:
                                                              "First Select Booking Type")
                                                      : val
                                                          .updateVehicleCategoryType(
                                                              newValue!);
                                                },
                                                items: val.masterModel!
                                                    .response!.vehicleType!
                                                    .map<
                                                            DropdownMenuItem<
                                                                master
                                                                .VehicleType>>(
                                                        (value) =>
                                                            DropdownMenuItem<
                                                                master
                                                                .VehicleType>(
                                                              value: value,
                                                              child: Text(value
                                                                  .typeName
                                                                  .toString()),
                                                            ))
                                                    .toList(),

                                                // add extra sugar..
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                iconSize: 42,
                                                underline: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 48,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              border:
                                                  Border.all(color: Colo.black),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          // color: Colors.grey.shade300,
                                          // dropdown below..
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                  "Select Vechicle Type"),
                                              DropdownButton<String>(
                                                // value:val.state==""? val
                                                //     .masterModel!.response!.state!.first:val.state,
                                                hint: Text(
                                                    val.vechiceLiftCategry),
                                                onChanged: (newValue) => val
                                                            .selectedVech ==
                                                        ""
                                                    ? ShowToast(
                                                        msg:
                                                            "First Select Booking Type")
                                                    : val
                                                        .updateLiftCategoryType(
                                                            newValue!),
                                                items: val.liftSub
                                                    .map<
                                                        DropdownMenuItem<
                                                            String>>((value) =>
                                                        DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(
                                                              value.toString()),
                                                        ))
                                                    .toList(),

                                                // add extra sugar..
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                iconSize: 42,
                                                underline: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        ),

                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Insurance Date From"),
                                  InkWell(
                                    onTap: () => val.chooseDate(
                                        context, "insuranceFrom"),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.insurance_date_from != null
                                            ? Text(
                                                "${DateFormat('dd/MM/yyyy').format(val.insurance_date_from!)}")
                                            : Text("Choose Date")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Insurance Date To"),
                                  InkWell(
                                    onTap: () =>
                                        val.chooseDate(context, "insurance"),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.insurance_date_to != null
                                            ? Text(
                                                "${DateFormat('dd/MM/yyyy').format(val.insurance_date_to!)}")
                                            : Text("Choose Date")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Insurance Image"),
                                  InkWell(
                                    onTap: () => context.push('/imageupload',
                                        extra: {'file': "InsuranceImg"}),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.insurance_img != null
                                            ? Text("${val.insurance_img!.path}")
                                            : const Text(
                                                "Upload Insurance Image")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Fitness Document"),
                                  InkWell(
                                    onTap: () => context.push('/imageupload',
                                        extra: {'file': "fitness"}),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.fit_doc != null
                                            ? Text("${val.fit_doc!.path}")
                                            : const Text(
                                                "Upload Fitness Document")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Fitness Expiry"),
                                  InkWell(
                                    onTap: () =>
                                        val.chooseDate(context, "fitness"),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.fit_expr != null
                                            ? Text(
                                                "${DateFormat('dd/MM/yyyy').format(val.fit_expr!)}")
                                            : const Text("Choose Date")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Permit"),
                                  InkWell(
                                    onTap: () => context.push('/imageupload',
                                        extra: {'file': "Permit"}),
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: val.permit_doc != null
                                          ? Text("${val.permit_doc!.path}")
                                          : const Text("Upload Permit"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Permit Expiry Date"),
                                  InkWell(
                                    onTap: () =>
                                        val.chooseDate(context, "permit"),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.permit_expr_date != null
                                            ? Text(
                                                "${DateFormat('dd/MM/yyyy').format(val.permit_expr_date!)}")
                                            : const Text("Choose Date")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Pollution"),
                                  InkWell(
                                    onTap: () => context.push('/imageupload',
                                        extra: {'file': "Polution"}),
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: val.pollurion_doc != null
                                          ? Text("${val.pollurion_doc!.path}")
                                          : const Text("Upload Pollution"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      "Enter registration certificate Document"),
                                  InkWell(
                                    onTap: () => context.push('/imageupload',
                                        extra: {'file': "rc"}),
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: val.rc_copy != null
                                          ? Text("${val.rc_copy!.path}")
                                          : const Text("Upload R.C. Document"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Enter Pollution Expiry Date"),
                                  InkWell(
                                    onTap: () =>
                                        val.chooseDate(context, "Polution"),
                                    child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all(
                                                color: Colors.black38),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: val.polution_exp_date != null
                                            ? Text(
                                                "${DateFormat('dd/MM/yyyy').format(val.polution_exp_date!)}")
                                            : const Text("Choose Date")),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 16,
                        // ),

                        // ,Text(
                        //   "Document Details",
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 8),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Align(
                        //         alignment: Alignment.centerLeft,
                        //         child: Text("Licence Detais"),
                        //       ),
                        //       SizedBox(
                        //         height: 16,
                        //       ),
                        //       //select type of cab by choosing option
                        //       // Container(
                        //       //   height: 48,
                        //       //   padding:
                        //       //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //       //   decoration: BoxDecoration(
                        //       //       // color: Colors.grey.shade300,
                        //       //       border: Border.all(color: Colors.grey.shade300),
                        //       //       borderRadius: BorderRadius.circular(10)),
                        //       //   // color: Colors.grey.shade300,
                        //       //   // dropdown below..
                        //       //   child: Row(
                        //       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       //     children: [
                        //       //       Text("Vechicle type"),
                        //       //       DropdownButton<String>(
                        //       //         value: selectedValue,
                        //       //         onChanged: (newValue) =>
                        //       //             setState(() => selectedValue = newValue!),
                        //       //         items: items
                        //       //             .map<DropdownMenuItem<String>>(
                        //       //                 (String value) =>
                        //       //                     DropdownMenuItem<String>(
                        //       //                       value: value,
                        //       //                       child: Text(value),
                        //       //                     ))
                        //       //             .toList(),

                        //       //         // add extra sugar..
                        //       //         icon: Icon(Icons.arrow_drop_down),
                        //       //         iconSize: 42,
                        //       //         underline: SizedBox(),
                        //       //       ),
                        //       //     ],
                        //       //   ),
                        //       // ),
                        //       // SizedBox(
                        //       //   height: 16,
                        //       // ),
                        //       Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text("Enter Licence No."),
                        //           SizedBox(
                        //             height: 48,
                        //             child: TextFormField(
                        //               maxLines: 1,
                        //               controller: val.license_no,
                        //               keyboardType: TextInputType.emailAddress,
                        //
                        //               style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontSize: 12,
                        //               ),
                        //               decoration: InputDecoration(
                        //                 fillColor: Colors.grey.shade200,
                        //                 filled: true,
                        //                 errorStyle: TextStyle(fontSize: 0),
                        //                 contentPadding:
                        //                     EdgeInsets.only(left: 15, right: 5),
                        //                 focusedBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.circular(10.0),
                        //                   borderSide: BorderSide(
                        //                     color: Colors.amber, // Border color
                        //                     width: 2.0, // Border width
                        //                   ),
                        //                 ),
                        //                 enabledBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.circular(10.0),
                        //                   borderSide: BorderSide(
                        //                     color:
                        //                         Colors.grey.shade200, // Border color
                        //                     width: 2.0, // Border width
                        //                   ),
                        //                 ),
                        //                 // labelStyle:
                        //                 //     Theme.of(context).textTheme.bodyMedium,
                        //                 disabledBorder: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.circular(10.0),
                        //                   borderSide: BorderSide(
                        //                     color:
                        //                         Colors.grey.shade100, // Border color
                        //                     width: 2.0, // Border width
                        //                   ),
                        //                 ),
                        //                 border: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.circular(10.0),
                        //                   borderSide: BorderSide(
                        //                     color:
                        //                         Colors.grey.shade100, // Border color
                        //                     width: 2.0, // Border width
                        //                   ),
                        //                 ),
                        //                 // enabled: true,
                        //                 // label: Text("Enter Vechicle No."),
                        //                 // floatingLabelAlignment:
                        //                 //     FloatingLabelAlignment.start,
                        //                 hintText: "OD 2312",
                        //                 // suffixIcon: Container(
                        //                 //   height: 40,
                        //                 //   color: Colors.amber,
                        //                 //   alignment: null,
                        //                 //   child: Text("Choose Location"),
                        //                 // ),
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 16,
                        //       ),
                        //       Column(
                        //         children: [
                        //           Align(
                        //             alignment: Alignment.centerLeft,
                        //             child: Text("upload licence"),
                        //           ),
                        //           SizedBox(
                        //             height: 4,
                        //           ),
                        //           InkWell(
                        //             onTap: () => Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(
                        //                     builder: (context) => Document_Upload(
                        //                           fileName: "Licence",
                        //                         ))),
                        //             child: Container(
                        //               height: 48,
                        //               width: double.infinity,
                        //               padding: EdgeInsets.only(left: 15),
                        //               alignment: Alignment.centerLeft,
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey.shade200,
                        //                   border: Border.all(color: Colors.black38),
                        //                   borderRadius: BorderRadius.circular(10)),
                        //               child: val.license_img != null
                        //                   ? Text("${val.license_img!.path}")
                        //                   : Text("Upload Licence"),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         height: 16,
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 0,
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.all(15),
                          height: 48,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colo.blackShade45, width: .5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black38,
                                  // color: Color(0xFFFFE082),
                                  blurRadius: 2,
                                )
                              ]),
                          child: TextField(
                            style: Theme.of(context).textTheme.bodySmall,
                            controller: val.ownerFind,
                            onTap: () async {
                              val.visibleOwner = true;
                              // if (val.ownerFind.text==""||val.ownerFind==null) {
                              val.allOwnerListViewModel();
                              // }else{
                              //   val.
                              // }

                              // print("On tap textfield call in this screen");
                            },
                            // onTapOutside: (event) async {
                            //   // print('onTapOutside');
                            //   FocusManager.instance.primaryFocus?.unfocus();
                            //   await val
                            //     ..updateownerVisible()
                            //     ..allFindOwnerList = null;
                            //   // print("On tap textfield call in this screen");
                            // },
                            onChanged: (numbe) {
                              if (numbe == "") {
                                val
                                  ..visibleOwner = true
                                  ..allFindOwnerList = null
                                  ..select_OwnerIndex = null
                                  ..allOwnerListViewModel();
                              } else {
                                val
                                  ..visibleOwner = true
                                  ..findOwnerAll(numbe);
                              }
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 10, top: 10),
                                border: InputBorder.none,
                                hintText: "Enter Owner Number/Phone",
                                suffixIcon: Icon(
                                  Icons.search,
                                )),
                          )),
                      // Container(
                      //     margin: EdgeInsets.all(15),
                      //     height: 48,
                      //     alignment: Alignment.centerLeft,
                      //     decoration: BoxDecoration(
                      //         color: Colors.grey.shade100,
                      //         borderRadius: BorderRadius.circular(8),
                      //         border: Border.all(
                      //             color: Colo.blackShade45, width: .5),
                      //         boxShadow: const [
                      //           BoxShadow(
                      //             color: Colors.black38,
                      //             // color: Color(0xFFFFE082),
                      //             blurRadius: 2,
                      //           )
                      //         ]),
                      //     child: TextField(
                      //       style: Theme.of(context).textTheme.bodySmall,
                      //       controller: val.driverFind,
                      //       onTap: () async {
                      //         val.visibleDriver = true;
                      //         // if (val.ownerFind.text==""||val.ownerFind==null) {
                      //         val.allDriverListViewModel();
                      //         // }else{
                      //         //   val.
                      //         // }

                      //         // print("On tap textfield call in this screen");
                      //       },
                      //       // onTapOutside: (event) async {
                      //       //   // print('onTapOutside');
                      //       //   FocusManager.instance.primaryFocus?.unfocus();
                      //       //   await val
                      //       //     ..updateownerVisible()
                      //       //     ..allFindOwnerList = null;
                      //       //   // print("On tap textfield call in this screen");
                      //       // },
                      //       onChanged: (numbe) {
                      //         if (numbe == "") {
                      //           val
                      //             ..visibleDriver = true
                      //             ..allFindDriverList = null
                      //             ..select_DriverIndex = null
                      //             ..allDriverListViewModel();
                      //         } else {
                      //           val
                      //             ..visibleDriver = true
                      //             ..findDriverAll(numbe);
                      //         }
                      //       },
                      //       decoration: InputDecoration(
                      //           contentPadding: EdgeInsets.only(
                      //               left: 20, right: 10, top: 10),
                      //           border: InputBorder.none,
                      //           hintText: "Enter Driver Name/Phone",
                      //           suffixIcon: Icon(
                      //             Icons.search,
                      //           )),
                      //     )),
                    ],
                  ),
                ),
              ),
              // val.visibleDriver
              //     ? Visibility(
              //         child: Positioned(
              //           top: 70,
              //           left: 0,
              //           right: 0,
              //           child: Consumer<VehicleViewmodel>(
              //               builder: (context, vehicle, _) {
              //             return vehicle.allFindDriverList == null
              //                 ? vehicle.memberWiseVehicleListModel == null
              //                     ? Center(
              //                         child: CircularProgressIndicator(),
              //                       )
              //                     : Container(
              //                         height: mediaQuery.height * 1,
              //                         color: Colors.white,
              //                         child: ListView.builder(
              //                             itemCount: vehicle
              //                                 .memberWiseVehicleListModel!
              //                                 .response!
              //                                 .driverlist!
              //                                 .length,
              //                             shrinkWrap: true,
              //                             padding: EdgeInsets.all(4),
              //                             itemBuilder: (context, index) {
              //                               return GestureDetector(
              //                                 onTap: () {
              //                                   vehicle
              //                                       .driverIndexSelect(index);
              //                                   vehicle
              //                                       .driverFind.text = vehicle
              //                                           .memberWiseVehicleListModel!
              //                                           .response!
              //                                           .driverlist![index]
              //                                           .fullName ??
              //                                       "";
              //                                   vehicle.driverId = vehicle
              //                                       .memberWiseVehicleListModel!
              //                                       .response!
              //                                       .driverlist![index]
              //                                       .id;
              //                                   vehicle
              //                                     ..visibleDriver = false
              //                                     ..allFindDriverList = null;
              //                                 },
              //                                 child: Container(
              //                                   // margin: EdgeInsets.all(10),
              //                                   padding: EdgeInsets.all(10),
              //                                   margin: EdgeInsets.only(
              //                                       top: 8,
              //                                       left: 15,
              //                                       right: 15),
              //                                   decoration: BoxDecoration(
              //                                       color:
              //                                           vehicle.select_DriverIndex ==
              //                                                   index
              //                                               ? Colo.primaryColor
              //                                               : Colors.white,
              //                                       boxShadow: [
              //                                         BoxShadow(
              //                                             color:
              //                                                 vehicle.select_DriverIndex ==
              //                                                         index
              //                                                     ? Colo.white
              //                                                     : Colors
              //                                                         .black,
              //                                             blurRadius:
              //                                                 vehicle.select_DriverIndex ==
              //                                                         index
              //                                                     ? 5
              //                                                     : 2)
              //                                       ],
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               12)),
              //                                   child: Column(
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.center,
              //                                     // mainAxisSize: MainAxisSize.min,
              //                                     children: [
              //                                       Row(
              //                                         children: [
              //                                           SizedBox(
              //                                               width: mediaQuery
              //                                                       .width *
              //                                                   0.3,
              //                                               child: Text(
              //                                                 'Name',
              //                                                 style: Theme.of(
              //                                                         context)
              //                                                     .textTheme
              //                                                     .labelSmall,
              //                                               )),
              //                                           Text(
              //                                             "${vehicle.memberWiseVehicleListModel!.response!.driverlist![index].fullName ?? ""}",
              //                                             style:
              //                                                 Theme.of(context)
              //                                                     .textTheme
              //                                                     .bodyMedium,
              //                                           ),
              //                                         ],
              //                                       ),
              //                                       Row(
              //                                         children: [
              //                                           SizedBox(
              //                                               width: mediaQuery
              //                                                       .width *
              //                                                   0.3,
              //                                               child: Text(
              //                                                 'Contact',
              //                                                 style: Theme.of(
              //                                                         context)
              //                                                     .textTheme
              //                                                     .labelSmall,
              //                                               )),
              //                                           Text(
              //                                             "${vehicle.memberWiseVehicleListModel!.response!.driverlist![index].contactNo ?? ""}",
              //                                             style:
              //                                                 Theme.of(context)
              //                                                     .textTheme
              //                                                     .bodyMedium,
              //                                           ),
              //                                         ],
              //                                       ),
              //                                     ],
              //                                   ),
              //                                 ),
              //                               );
              //                             }),
              //                       )
              //                 : ListView.builder(
              //                     itemCount: vehicle.allFindDriverList!.length,
              //                     shrinkWrap: true,
              //                     padding: EdgeInsets.all(4),
              //                     itemBuilder: (context, index) {
              //                       return GestureDetector(
              //                         onTap: () {
              //                           vehicle.driverIndexSelect(index);

              //                           vehicle.driverFind.text = vehicle
              //                                   .allFindDriverList![index]
              //                                   .fullName ??
              //                               "";
              //                           vehicle.driverId = vehicle
              //                               .allFindDriverList![index].id;

              //                           vehicle
              //                             ..visibleDriver = false
              //                             ..allFindDriverList = null;
              //                         },
              //                         child: Container(
              //                           // margin: EdgeInsets.all(10),
              //                           padding: EdgeInsets.all(10),
              //                           margin: EdgeInsets.only(
              //                               top: 8, left: 15, right: 15),
              //                           decoration: BoxDecoration(
              //                               color: vehicle.select_DriverIndex ==
              //                                       index
              //                                   ? Colo.primaryColor
              //                                   : Colors.white,
              //                               boxShadow: [
              //                                 BoxShadow(
              //                                     color:
              //                                         vehicle.select_DriverIndex ==
              //                                                 index
              //                                             ? Colo.white
              //                                             : Colors.black,
              //                                     blurRadius:
              //                                         vehicle.select_DriverIndex ==
              //                                                 index
              //                                             ? 5
              //                                             : 2)
              //                               ],
              //                               borderRadius:
              //                                   BorderRadius.circular(12)),
              //                           child: Column(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.start,
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.center,
              //                             // mainAxisSize: MainAxisSize.min,
              //                             children: [
              //                               Row(
              //                                 children: [
              //                                   SizedBox(
              //                                       width:
              //                                           mediaQuery.width * 0.3,
              //                                       child: Text(
              //                                         'Name',
              //                                         style: Theme.of(context)
              //                                             .textTheme
              //                                             .labelSmall,
              //                                       )),
              //                                   Text(
              //                                     "${vehicle.allFindDriverList![index].fullName ?? ""}",
              //                                     style: Theme.of(context)
              //                                         .textTheme
              //                                         .bodyMedium,
              //                                   ),
              //                                 ],
              //                               ),
              //                               Row(
              //                                 children: [
              //                                   SizedBox(
              //                                       width:
              //                                           mediaQuery.width * 0.3,
              //                                       child: Text(
              //                                         'Contact',
              //                                         style: Theme.of(context)
              //                                             .textTheme
              //                                             .labelSmall,
              //                                       )),
              //                                   Text(
              //                                     "${vehicle.allFindDriverList![index].contactNo ?? ""}",
              //                                     style: Theme.of(context)
              //                                         .textTheme
              //                                         .bodyMedium,
              //                                   ),
              //                                 ],
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     });
              //           }),
              //         ),
              //       )
              //     : SizedBox(),

              val.visibleOwner
                  ? Visibility(
                      child: Positioned(
                        top: 70,
                        left: 0,
                        right: 0,
                        child: Consumer<VehicleViewmodel>(
                            builder: (context, vehicle, _) {
                          return vehicle.allFindOwnerList == null
                              ? vehicle.ownerModel == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Container(
                                      height: mediaQuery.height * 1,
                                      color: Colors.white,
                                      child: ListView.builder(
                                          itemCount: vehicle.ownerModel!
                                              .response!.ownerlist!.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(4),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                vehicle.ownerIndexSelect(index);
                                                vehicle.ownerFind.text = vehicle
                                                        .ownerModel!
                                                        .response!
                                                        .ownerlist![index]
                                                        .fullName ??
                                                    "";
                                                vehicle.ownerId = vehicle
                                                    .ownerModel!
                                                    .response!
                                                    .ownerlist![index]
                                                    .id;
                                                vehicle
                                                  ..visibleOwner = false
                                                  ..allFindOwnerList = null;
                                              },
                                              child: Container(
                                                // margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.all(10),
                                                margin: EdgeInsets.only(
                                                    top: 8,
                                                    left: 15,
                                                    right: 15),
                                                decoration: BoxDecoration(
                                                    color:
                                                        vehicle.select_OwnerIndex ==
                                                                index
                                                            ? Colo.primaryColor
                                                            : Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              vehicle.select_OwnerIndex ==
                                                                      index
                                                                  ? Colo.white
                                                                  : Colors
                                                                      .black,
                                                          blurRadius:
                                                              vehicle.select_OwnerIndex ==
                                                                      index
                                                                  ? 5
                                                                  : 2)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: mediaQuery
                                                                    .width *
                                                                0.3,
                                                            child: Text(
                                                              'Name',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall,
                                                            )),
                                                        Text(
                                                          "${vehicle.ownerModel!.response!.ownerlist![index].fullName ?? ""}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                            width: mediaQuery
                                                                    .width *
                                                                0.3,
                                                            child: Text(
                                                              'Contact',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall,
                                                            )),
                                                        Text(
                                                          "${vehicle.ownerModel!.response!.ownerlist![index].contactNo ?? ""}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                              : ListView.builder(
                                  itemCount: vehicle.allFindOwnerList!.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(4),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        vehicle.ownerIndexSelect(index);

                                        vehicle.ownerFind.text = vehicle
                                                .allFindOwnerList![index]
                                                .fullName ??
                                            "";
                                        vehicle.ownerId =
                                            vehicle.allFindOwnerList![index].id;

                                        vehicle
                                          ..visibleOwner = false
                                          ..allFindOwnerList = null;
                                      },
                                      child: Container(
                                        // margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.only(
                                            top: 8, left: 15, right: 15),
                                        decoration: BoxDecoration(
                                            color: vehicle.select_OwnerIndex ==
                                                    index
                                                ? Colo.primaryColor
                                                : Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      vehicle.select_OwnerIndex ==
                                                              index
                                                          ? Colo.white
                                                          : Colors.black,
                                                  blurRadius:
                                                      vehicle.select_OwnerIndex ==
                                                              index
                                                          ? 5
                                                          : 2)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.3,
                                                    child: Text(
                                                      'Name',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )),
                                                Text(
                                                  "${vehicle.allFindOwnerList![index].fullName ?? ""}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.3,
                                                    child: Text(
                                                      'Contact',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall,
                                                    )),
                                                Text(
                                                  "${vehicle.allFindOwnerList![index].contactNo ?? ""}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                        }),
                      ),
                    )
                  : SizedBox()
            ],
          );
        }));
  }
}
