import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../../static/color.dart';
import '../../../view_model/vechicle_viewwModel/vechicle_view_model.dart';

void verifyOtpVehicleDriver(
    {required BuildContext context,
    required driverId,
    required vechicleId,
    required ownerID}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Consumer<VehicleViewmodel>(builder: (context, val, _) {
          return Dialog(
            backgroundColor: Colors.white,

            insetPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            // scrollable: true,
            // title:Text('Enter OTP'),
            child: Container(
              padding: EdgeInsets.all(16.0),
              // width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PinCodeTextField(
                    cursorColor: Theme.of(context).primaryColor,
                    length: 6,
                    controller: val.otpController,
                    autoDisposeControllers: false,
                    textStyle: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w400),
                    appContext: (context),
                    onChanged: (value) {},
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderWidth: 1.5,
                        borderRadius: BorderRadius.circular(10),
                        activeFillColor: Colors.black,
                        selectedColor: Colors.black,
                        activeColor: Colors.black,
                        inactiveColor: Colors.black,
                        errorBorderColor: Colo.black,
                        fieldOuterPadding: EdgeInsets.zero),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade100),
                        child: Text(
                          'No',
                          style: TextStyle(
                              // decoration: TextDecoration.underline,
                              color: Colors.redAccent),
                        ),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          context.pop();
                          //  Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.black,
                            elevation: 4,
                            side: BorderSide(
                                color: Colors.transparent,
                                width:
                                    .3), // Change border color and width here
                            // Text color
                          ),
                          child: Text(
                            'verify',
                            // style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () async {
                            // Navigator.of(context).pop();

                            // Navigator.of(context).pop();
                            await Provider.of<VehicleViewmodel>(context,
                                    listen: false)
                                .verifyOtp(
                              driver_id: driverId,
                              vehicle_id: vechicleId,
                              ownerId: ownerID,
                              otp: val.otpController.text.toString(),
                            );
                            context.pop();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      });
}
