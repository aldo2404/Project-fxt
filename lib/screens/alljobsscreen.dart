import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fx_project/layout/cardlist.dart';
import 'package:fx_project/models/alljobsresponsemodel.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/services/alljobsservices.dart';

class AllJobsScreen extends StatefulWidget {
  final String alljobscount;
  const AllJobsScreen({super.key, required this.alljobscount});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  AllJobsResponesModel? allJob;
  String page = '';
  String nextPage = '&page';
  bool loading = true;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    allJob = await (AllJobsServices(
      service: Dio(BaseOptions(
          baseUrl: 'https://${baseurl1}/v1/jobs/?filter=active$page')),
    ).allJobsService());
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(
          () {},
        ));

    print("count: ${allJob?.count}");
    print("next: ${allJob!.next}");
    print(allJob);
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        //fetchData(offset);
        const CircularProgressIndicator();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var listcount = widget.alljobscount;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 48, 92),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('$listcount All Jobs'),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
            future: getUsers(),
            builder: (context, snapshot) {
              if (allJob != null) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Container(
                            alignment: Alignment.center,
                            width: 340,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.black)),
                            child: const Center(
                              child: Icon(
                                Icons.filter_list,
                                semanticLabel: 'Filter',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: allJob!.results!.length,
                          itemBuilder: (context, index) {
                            var property =
                                allJob?.results![index].property.toString();
                            var serviceType =
                                allJob?.results![index].serviceType.toString();
                            var id = allJob?.results![index].id.toString();
                            // var name =
                            //     allJob?.results![index].stage.name.toString();

                            var issueType =
                                allJob?.results![index].issueType.toString();
                            var priority =
                                allJob?.results![index].priority.toString();
                            var unit = allJob?.results![index].unit.toString();
                            var category =
                                allJob?.results![index].category.toString();

                            if (index == allJob!.results!.length) {
                              return loading
                                  ? Container(
                                      height: 100,
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : Container();
                            }

                            return cardListContainer(property!, serviceType!,
                                id!, issueType!, priority!, unit!, category!);
                          }),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('result: ${snapshot.data}');
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  getUsers() {}

  Future refresh() async {
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    allJob = await (AllJobsServices(
      service: Dio(
          BaseOptions(baseUrl: 'https://${baseurl1}/v1/jobs/?filter=active')),
    ).allJobsService());
    setState(() {
      allJob = allJob;
    });
  }
}
