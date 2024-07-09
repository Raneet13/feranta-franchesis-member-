import 'package:feranta_franchise/static/color.dart';
import 'package:feranta_franchise/static/flutter_toast_message/toast_messge.dart';
import 'package:feranta_franchise/view_model/auth/login-viewmodel.dart';
import 'package:feranta_franchise/view_model/map_viewmodel/mao_view_modedl_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 40,
        // leading: Container(
        //   height: 30,
        //   // width: 20,
        //   decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       image: DecorationImage(
        //           fit: BoxFit.fill,
        //           image: AssetImage("assets/logo/feranta_new_logo_.png"))),
        // ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/logo/feranta_new_logo_.png"))),
            ),
            Text("TEAM"),
          ],
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 12),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colo.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Consumer<LoginViewmodel>(builder: (context, val, _) {
          return val.isLoading
              ? Center(
                  child: Text("Processing..."),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () => val.isCheckIn
                          ? null
                          : Provider.of<MapViewModelProvider>(context,
                                  listen: false)
                              .checkCurrentLocation()
                              .then((value) => val.showPickerDialog(
                                  lat: value.latitude, lng: value.longitude))
                              .catchError((e) {
                              ShowToast(
                                  msg: "First Location Permission Allowed");
                            }),
                      child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: val.isCheckIn ? null : Colo.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text("CheckIn",
                              style: Theme.of(context).textTheme.displaySmall)),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () => val.isCheckIn
                          ? Provider.of<MapViewModelProvider>(context,
                                  listen: false)
                              .checkCurrentLocation()
                              .then((value) => val.showPickerDialog(
                                  lat: value.latitude, lng: value.longitude))
                              .catchError((e) {
                              ShowToast(
                                  msg: "First Location Permission Allowed");
                            })
                          : null,
                      child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: val.isCheckIn ? Colo.primaryColor : null,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "CheckOut",
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
                    ))
                  ],
                );
        }),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              // height: 50,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade100,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 5.0)
                  ]),
              child: ListTile(
                onTap: () =>
                    context.go('/home/ownerResister', extra: {'id': "0"}),
                leading: SizedBox(
                  height: 25,
                  width: 25,
                  child: Icon(
                    Icons.account_circle,
                    color: Colo.primaryColor,
                  ),
                ),
                title: Text("Owner Registration ",
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // height: 50,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade100,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 5.0)
                  ]),
              child: ListTile(
                onTap: () =>
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             CheckoutPage())),
                    context.go('/home/resister_driver',
                        extra: {'id': "0"}), //ownerResister
                leading: Icon(
                  Icons.local_taxi,
                  color: Colo.primaryColor,
                ),
                title: Text("Driver Registration ",
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // height: 50,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade100,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 5.0)
                  ]),
              child: ListTile(
                onTap: () =>
                    context.go('/home/customerResister', extra: {'id': "0"}),
                leading: Icon(
                  Icons.account_circle,
                  color: Colo.primaryColor,
                ),
                title: Text("Customer Registration ",
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              // height: 50,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey.shade100,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, blurRadius: 5.0)
                  ]),
              child: ListTile(
                onTap: () => context.go('/home/addVehicle', extra: {'id': "0"}),
                leading: Icon(
                  Icons.local_taxi,
                  color: Colo.primaryColor,
                ),
                title: Text("Vehicle Registration ",
                    style: Theme.of(context).textTheme.bodyMedium),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
