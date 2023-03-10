import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/layout/dashboardbox.dart';
import 'package:fx_project/models/dashboardresponsemodel.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/dashboardservices.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashBoardResponesModel? bal;
  late String text1;
  late String text2;
  late String text3;
  late int t1;
  late int t2;
  late int t3;

  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    bal = await (DashBoardService(
      service: Dio(BaseOptions(baseUrl: 'https://${baseurl1}')),
    ).dashBoardService());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(
          () {},
        ));

    print("emergency: ${bal?.emergency}");
    print("jobs: ${bal?.all_jobs}");
    print(bal);
  }

  @override
  Widget build(BuildContext context) {
    dynamic baseurl1 = EnvironmentPageState.getBaseurl() as dynamic;
    var base = print('url${baseurl1}');

    print("emergency: ${bal?.emergency}");
    print("jobs: ${bal?.all_jobs}");
    t1 = bal?.emergency as int;
    text1 = t1.toString();
    t2 = bal?.all_jobs as int;
    text2 = t2.toString();
    t3 = bal?.assigned_to_me as int;
    text3 = t3.toString();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 1, 48, 92),
          leading: Image.asset('assets/image/splashlogo.png'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.power_settings_new, color: Colors.orange[900]))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 240,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 280),
                  children: [
                    DashBoardBox(Colors.amber[50], Icons.warning,
                        Colors.orange[900], text1, "Emergency"),
                    DashBoardBox(Colors.blue[50], Icons.wallet_travel,
                        Colors.orange[600], text2, "All Jobs"),
                    DashBoardBox(Colors.pink[50], Icons.check_box_outlined,
                        Colors.blue, text3, "Assigned To Me"),
                  ]),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 40,
                  width: 333,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 1, 32, 58)),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Create jobs',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
