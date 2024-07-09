import 'package:feranta_franchise/screen/past_record/vechicle/show_verify_otp_driver.dart';
import 'package:feranta_franchise/view_model/vechicle_viewwModel/vechicle_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../static/color.dart';

void showModalBottomSheetDriverList(
    {required BuildContext context, required vehicleId, required ownerID}) {
  var mediaQuery = MediaQuery.of(context).size;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: mediaQuery.height * .8,
        color: Colors.white,
        child: Consumer<VehicleViewmodel>(builder: (context, val, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(15),
                  height: 48,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colo.blackShade45, width: .5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          // color: Color(0xFFFFE082),
                          blurRadius: 2,
                        )
                      ]),
                  child: TextField(
                    style: Theme.of(context).textTheme.bodySmall,
                    controller: val.driverFind,
                    onTap: () async {
                      val.visibleDriver = true;
                      // if (val.ownerFind.text==""||val.ownerFind==null) {
                      val.allDriverListViewModel();
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
                          ..visibleDriver = true
                          ..allFindDriverList = null
                          ..select_DriverIndex = null
                          ..allDriverListViewModel();
                      } else {
                        val
                          ..visibleDriver = true
                          ..findDriverAll(numbe);
                      }
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 20, right: 10, top: 10),
                        border: InputBorder.none,
                        hintText: "Enter Driver Name/Phone",
                        suffixIcon: Icon(
                          Icons.search,
                        )),
                  )),
              Consumer<VehicleViewmodel>(builder: (context, vehicle, _) {
                return vehicle.allFindDriverList == null
                    ? vehicle.memberWiseVehicleListModel == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: mediaQuery.height * .7,
                            color: Colors.white,
                            child: ListView.builder(
                                itemCount: vehicle.memberWiseVehicleListModel!
                                    .response!.driverlist!.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(4),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      // vehicle.driverIndexSelect(index);
                                      // vehicle.driverFind.text = vehicle
                                      //         .memberWiseVehicleListModel!
                                      //         .response!
                                      //         .driverlist![index]
                                      //         .fullName ??
                                      //     "";
                                      // vehicle.driverId = vehicle
                                      //     .memberWiseVehicleListModel!
                                      //     .response!
                                      //     .driverlist![index]
                                      //     .id;
                                      // vehicle
                                      //   ..visibleDriver = false
                                      //   ..allFindDriverList = null;
                                      await vehicle.vechicleAsignOTPDriver(
                                          driver_id: vehicle
                                                  .memberWiseVehicleListModel!
                                                  .response!
                                                  .driverlist![index]
                                                  .id ??
                                              "",
                                          vehicle_id: vehicleId ?? "");
                                      verifyOtpVehicleDriver(
                                          context: context,
                                          driverId: vehicle
                                                  .memberWiseVehicleListModel!
                                                  .response!
                                                  .driverlist![index]
                                                  .id ??
                                              "",
                                          vechicleId: vehicleId ?? "",
                                          ownerID: ownerID);
                                      context.pop();
                                    },
                                    child: Container(
                                      // margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(
                                          top: 8, left: 15, right: 15),
                                      decoration: BoxDecoration(
                                          color: vehicle.select_DriverIndex ==
                                                  index
                                              ? Colo.primaryColor
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    vehicle.select_DriverIndex ==
                                                            index
                                                        ? Colo.white
                                                        : Colors.black,
                                                blurRadius:
                                                    vehicle.select_DriverIndex ==
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
                                                  width: mediaQuery.width * 0.3,
                                                  child: Text(
                                                    'Name',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                  )),
                                              Text(
                                                "${vehicle.memberWiseVehicleListModel!.response!.driverlist![index].fullName ?? ""}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: mediaQuery.width * 0.3,
                                                  child: Text(
                                                    'Contact',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                  )),
                                              Text(
                                                "${vehicle.memberWiseVehicleListModel!.response!.driverlist![index].contactNo ?? ""}",
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
                                }),
                          )
                    : ListView.builder(
                        itemCount: vehicle.allFindDriverList!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(4),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              // vehicle.driverIndexSelect(index);

                              // vehicle.driverFind.text =
                              //     vehicle.allFindDriverList![index].fullName ??
                              //         "";
                              // vehicle.driverId =
                              //     vehicle.allFindDriverList![index].id;

                              // vehicle
                              //   ..visibleDriver = false
                              //   ..allFindDriverList = null;
                              await vehicle.vechicleAsignOTPDriver(
                                  driver_id:
                                      vehicle.allFindDriverList![index].id ??
                                          "",
                                  vehicle_id: vehicleId ?? "");
                              verifyOtpVehicleDriver(
                                  context: context,
                                  driverId:
                                      vehicle.allFindDriverList![index].id ??
                                          "",
                                  vechicleId: vehicleId ?? "",
                                  ownerID: ownerID);
                              context.pop();
                            },
                            child: Container(
                              // margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              margin:
                                  EdgeInsets.only(top: 8, left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: vehicle.select_DriverIndex == index
                                      ? Colo.primaryColor
                                      : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            vehicle.select_DriverIndex == index
                                                ? Colo.white
                                                : Colors.black,
                                        blurRadius:
                                            vehicle.select_DriverIndex == index
                                                ? 5
                                                : 2)
                                  ],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: mediaQuery.width * 0.3,
                                          child: Text(
                                            'Name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )),
                                      Text(
                                        "${vehicle.allFindDriverList![index].fullName ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: mediaQuery.width * 0.3,
                                          child: Text(
                                            'Contact',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                          )),
                                      Text(
                                        "${vehicle.allFindDriverList![index].contactNo ?? ""}",
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
              })
            ],
          );
        }),
      );
    },
  );
}
