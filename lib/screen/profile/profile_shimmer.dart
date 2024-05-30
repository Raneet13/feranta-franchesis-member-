import 'package:flutter/material.dart';

import '../../configs/custom_elivated_button.dart';
import '../../static/color.dart';

Widget profileShimmer(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Transform.translate(
        offset: Offset(0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Material(
                  elevation: 10.0,
                  color: Colors.white,
                  shape: CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Icon(
                        Icons.account_circle,
                        size: 60,
                      ),
                      // child: CircleAvatar(
                      //     radius: 30,
                      //     backgroundColor: Colors.transparent,
                      //     backgroundImage:
                      //         CachedNetworkImageProvider(
                      //       "https://source.unsplash.com/300x300/?portrait",
                      //     )),
                    ),
                  ),
                ),
                Text(
                  "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextButton.icon(
                    onPressed: () => null,
                    style: ButtonStyle(
                      // shape: MaterialStateProperty.all<
                      //     RoundedRectangleBorder>(
                      //   RoundedRectangleBorder(
                      //       borderRadius:
                      //           BorderRadius.circular(18.0),
                      //       side: BorderSide(color: Colors.black)),
                      // ),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                    ),
                    icon: Icon(
                      Icons.edit,
                      color: Colo.yellow,
                    ),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.amber, fontSize: 14),
                    )),
              ],
            ),
          ],
        ),
      ),
      Divider(),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Feranta",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
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
                            leading: const Icon(
                              Icons.security,
                              size: 20,
                            ),
                            title: Text("Privacy Policy",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                            leading: const Icon(
                              Icons.description,
                              size: 20,
                            ),
                            title: Text("Terms & Conditions",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                            leading: const Icon(
                              Icons.support_agent,
                              size: 20,
                            ),
                            title: Text("Customer care",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomElButton(
                buttoonname: "Logout",
                onclick: () => null,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
