import 'package:dio/dio.dart';
import 'package:feranta_franchise/static/validator/all_textfield_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../configs/custom_text_field.dart';
import '../../../view_model/auth/login-viewmodel.dart';

class LognScreen extends StatefulWidget {
  const LognScreen({super.key});

  @override
  State<LognScreen> createState() => _LognScreenState();
}

class _LognScreenState extends State<LognScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<LoginViewmodel>(context, listen: false)
    //     .getDeviceTokenToSendNotification();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Provider.of<LoginViewmodel>(context, listen: false)
    //   ..isLoading = false
    //   ..mobNumber.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQry = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer<LoginViewmodel>(builder: (context, val, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQry.height * .40,
                width: double.infinity,
                child: Center(
                  child: SizedBox(
                    // height: 200,
                    // width: 200,
                    child: Image.asset(
                      "assets/logo/feranta_new_logo_.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 56,
                      width: MediaQuery.of(context).size.width * .85,
                      child: CustomTextField(
                        hint: "Enter Mobile Number",
                        controller:
                            Provider.of<LoginViewmodel>(context, listen: false)
                                .mobNumber,
                        inputFormater: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        KeyBoardType: TextInputType.number,
                        validator: (value) => ValidateAll.validateMobile(value),
                        autofocus: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 56,
                        width: MediaQuery.of(context).size.width * .85,
                        child: Card(
                          elevation: 0.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black38, width: 2.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextFormField(
                              maxLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !val.passwordVisible,
                              controller: val.password,
                              style: TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                    fontSize: 15,
                                    // fontFamily: "OpenSans",
                                    // fontWeight: FontWeight.w300,
                                    letterSpacing: 0.1,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "password",
                                  suffixIcon: InkWell(
                                    onTap: () => val.passwordVisibleupdate(),
                                    child: val.passwordVisible
                                        ? Icon(Icons.visibility)
                                        : Icon(Icons.visibility_off),
                                  )),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 75, right: 75),
                      child: ElevatedButton(
                          onPressed: () =>
                              val.isLoading ? null : val.submitLogin(context),
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child: val.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Login",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      )),
    );
  }
}
