// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// import '../../../static/color.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../../view_model/auth/login-viewmodel.dart';

// class OtpVerify extends StatefulWidget {
//   // final String phoneNumber;
//   // final String otp;
//   // const OtpVerify({required this.phoneNumber, required this.otp, super.key});

//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }

// class _OtpVerifyState extends State<OtpVerify> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Provider.of<LoginViewmodel>(context, listen: false).startTimer();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     // otpController.dispose();
//     Provider.of<LoginViewmodel>(context, listen: false)
//       ..timer.cancel()
//       ..otpController.text = '';
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: InkWell(
//           onTap: () {
//             Provider.of<LoginViewmodel>(context, listen: false)
//               ..timer.cancel()
//               ..otpController.text = "";
//             context.pop();
//             // setState(() {});
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Consumer<LoginViewmodel>(builder: (context, log, _) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   padding:
//                       EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 10),
//                         child: FittedBox(
//                           child: Text(
//                             "OTP Verification",
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                         ),
//                       ),
//                       FittedBox(
//                           fit: BoxFit.none,
//                           child: Text("we has send the code to the nuber")),
//                       // FittedBox(child: Text("+91 ${widget.phoneNumber}")),
//                     ],
//                   ),
//                 ),
//                 PinCodeTextField(
//                   cursorColor: Theme.of(context).primaryColor,
//                   length: 6,
//                   controller: log.otpController,
//                   autoDisposeControllers: false,
//                   textStyle: const TextStyle(
//                       color: Colors.blue, fontWeight: FontWeight.w400),
//                   appContext: (context),
//                   onChanged: (value) {},
//                   keyboardType: TextInputType.number,
//                   pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderWidth: 1.5,
//                       borderRadius: BorderRadius.circular(10),
//                       activeFillColor: Colors.black,
//                       selectedColor: Colors.blue,
//                       activeColor: Colors.amber,
//                       inactiveColor: Colors.amber,
//                       errorBorderColor: Colo.black,
//                       fieldOuterPadding: EdgeInsets.zero),
//                 ),
//                 // Padding(
//                 //   padding:
//                 //       EdgeInsets.only(top: 10, left: 10, bottom: 20, right: 10),
//                 //   child: OTPTextField(
//                 //     controller: log.otpController,
//                 //     length: 3,
//                 //     width: MediaQuery.of(context).size.width,
//                 //     textFieldAlignment: MainAxisAlignment.spaceEvenly,
//                 //     // fieldWidth: 30,
//                 //     fieldStyle: FieldStyle.box,
//                 //     // outlineBorderRadius: 15,
//                 //     otpFieldStyle: OtpFieldStyle(
//                 //         focusBorderColor: Colors.amber,
//                 //         disabledBorderColor: Colors.amber,
//                 //         enabledBorderColor: Colors.amber,
//                 //         errorBorderColor: Colors.red),
//                 //     isDense: true,
//                 //     style: TextStyle(fontSize: 17, color: Colors.black),
//                 //     onChanged: (pin) {
//                 //       log.otppin = pin;
//                 //     },

//                 //     // onCompleted: (pin) {
//                 //     //   otppin = pin;
//                 //     //   // otpVerify(pin);}
//                 //   ),
//                 // ),

//                 SizedBox(
//                     height: 48,
//                     width: double.infinity,
//                     child: ElevatedButton(
//                         onPressed: () =>
//                             log.isLoading ? null : log.gotoHome(context),
//                         child: log.isLoading
//                             ? CircularProgressIndicator()
//                             : Text(
//                                 "Verify",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                         style: Theme.of(context).elevatedButtonTheme.style)),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Provider.of<LoginViewmodel>(context, listen: false).showResend
//                     ? TextButton(
//                         onPressed: () {
//                           log.start = 30;
//                           log.startTimer();
//                           log.showResend = false;
//                           log.sendOtpagainestPhone();
//                         },
//                         child: Text(
//                           "Resend OTP",
//                           style:
//                               TextStyle(decoration: TextDecoration.underline),
//                         ))
//                     //  ElevatedButton(
//                     //     onPressed: () {
//                     //       log.start = 30;
//                     //       log.startTimer();
//                     //       log.showResend = false;
//                     //       log.sendOtpagainestPhone();
//                     //       // setState(() {});
//                     //     },
//                     //     child: const Text("Resend"))
//                     : Text.rich(
//                         TextSpan(
//                           children: [
//                             const TextSpan(text: 'Resend code in '),
//                             TextSpan(
//                               text: '00:${log.start}',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.red),
//                             ),
//                           ],
//                         ),
//                       )
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
