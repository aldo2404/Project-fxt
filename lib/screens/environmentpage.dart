import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  State<EnvironmentPage> createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    bool selected = false;
    int currentIndex = 1;
    int _currentSlide = 0;

    print("domains in environment: ${widget.domains}");
    var domains = widget.domains as List<DomainModel>;

    for (var d in domains) {
      print("host: ${d.host}");
      print("name: ${d.name}");
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
                  //padding: const EdgeInsets.all(20),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                    ),
                    itemCount: domains.length,
                    itemBuilder: (context, i, id) {
                      print('v${id}');
                      String baseUrls = domains[i].host!;

                      return Container(
                        //height: 120,
                        child: InkWell(
                          //value :selected,
                          onTap: () {
                            baseUrl(baseUrls);
                            DashBoardService(
                              service: Dio(
                                  BaseOptions(baseUrl: 'https://${baseUrls}')),
                            ).dashBoardService();
                          },
                          onHover: (value) {
                            setState(() {
                              selected = value;
                            });
                          },
                          child: Card(
                            shape: selected
                                ? RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 230, 81, 0),
                                        width: 4.0),
                                    borderRadius: BorderRadius.circular(10.0))
                                : RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white, width: 4.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                            child: environmentBox(domains[i].name!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                clickButton(
                  child: const Text("submit"),
                  () async {
                    dynamic base = await getBaseurl() as dynamic;
                    if (base != null) {
                      print('gi${base}');
                      return Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const BottomNaviBar()));
                    } else {
                      print('error');
                      return ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Kindly select any environment')));
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
    print('ds$baseurl');
    return baseurl;
  }
}
