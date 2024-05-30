import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FRANCHISES"),
        centerTitle: true,
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
                  child: Image.asset(
                    "assets/logo/feranta_new_logo_.png",
                  ),
                ),
                title: Text("Owner Register",
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
                onTap: () => context.go('/home/resister_driver',
                    extra: {'id': "0"}), //ownerResister
                leading: Icon(Icons.local_taxi),
                title: Text("Driver Resister",
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
                leading: Icon(Icons.account_circle),
                title: Text("Customer Register",
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
