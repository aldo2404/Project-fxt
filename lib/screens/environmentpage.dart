import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fx_project/layout/alertbox.dart';
import 'package:fx_project/layout/background_screen.dart';
import 'package:fx_project/layout/bottomnavigation.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/environment_box.dart';
import 'package:fx_project/models/login_response_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fx_project/services/dashboardservices.dart';

class EnvironmentPage extends StatefulWidget {
  final List<DomainModel> domains;
  const EnvironmentPage({super.key, required this.domains});

  @override
  State<EnvironmentPage> createState() => EnvironmentPageState();
}

class EnvironmentPageState extends State<EnvironmentPage> {
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    int currentIndex = 1;
    int _currentSlide = 0;

    print("domains in environment: ${widget.domains}");
    var domains = widget.domains as List<DomainModel>;

    for (var d in domains) {
      print("name: ${d.name}");
      print("host: ${d.host}");
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          BackGroundImg().Images(),
          Positioned(
            child: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Environment",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 300,
                  child: Text(
                    "Choose which environment you want to enter",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 300,
                  //height: 100,
                  //padding: const EdgeInsets.all(20),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                    ),
                    itemCount: domains.length,
                    itemBuilder: (context, i, id) {
                      print('url${id}');
                      String baseUrls = domains[i].host!;

                      return GestureDetector(
                        child: Container(
                          //height: 120,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            //value :selected,
                            onTap: () {
                              baseUrl(baseUrls);
                              DashBoardService(
                                service: Dio(
                                    BaseOptions(baseUrl: 'https://$baseUrls')),
                              ).dashBoardService();
                            },
                            // onHover: (value) {
                            //   setState(() {
                            //     selected = value;
                            //   });
                            // },
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Text(
                                  domains[i].name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                clickButton(
                  child: const Text("Enter"),
                  () async {
                    dynamic base = await getBaseurl() as dynamic;

                    if (base != null) {
                      print('gi_${base}');
                      return Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const BottomNaviBar()));
                    } else {
                      print('error');
                      // ignore: use_build_context_synchronously
                      ReuseAlertDialogBox().alertDialog(
                          context, "Alert", "Kindly select any environment");
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Future<void> baseUrl(String baseurl) async {
    await storage.write(key: "baseurl", value: baseurl);
  }

  static Future<String?> getBaseurl() async {
    dynamic baseurl = await storage.read(key: "baseurl");
    print('ds_$baseurl');
    return baseurl;
  }
}
