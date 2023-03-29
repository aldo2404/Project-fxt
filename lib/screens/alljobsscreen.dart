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
  //int page = 1;
  // int? count ;
  int page = 1;
  List<Result>? result = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    //String url = '';
    _getData();
    //handleNext();
    _scrollController.addListener(_scrollListner);
    super.initState();
  }

  // _urlData() async {
  //   dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
  //   String baseurl = 'https://$baseurl1/v1/jobs/?filter=active';
  //   print(baseurl);
  //   return baseurl;
  // }

  Future<void> _getData() async {
    setState(() {
      loading = true;
    });
    dynamic baseurl1 = await EnvironmentPageState.getBaseurl() as dynamic;
    print(page);
    allJob = await (AllJobsServices(
      service: Dio(BaseOptions(
          baseUrl: 'https://$baseurl1/v1/jobs/?filter=active&page=$page')),
    ).allJobsService());

    //int incCount = pageCount + 1;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(
          () {
            //allJob = allJob;
            result = result! + allJob!.results!;
            // loading = false;
            //pageCount = incCount;
          },
        ));
    print("count: ${allJob?.count}");
    print("next: ${allJob!.next}");
    print("alljobs_$allJob");
  }

  Future<void> _scrollListner() async {
    if (loading) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      page = page + 1;
      print(page);
      setState(() {
        loading = true;
      });
      await _getData();
      // setState(() {
      //   loading = false;
      // });
    }
    print("next: ${allJob!.next}");
    print(allJob);
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
              if (result != null) {
                print(result!.length);
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
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: result!.length,

                          //loading ? result!.length + 1 : result!.length,
                          itemBuilder: (context, index) {
                            var property = result![index].property.toString();
                            var serviceType =
                                result![index].serviceType.toString();
                            var id = result![index].id.toString();
                            var name = result![index].stage.name.toString();

                            var issueType = result![index].issueType.toString();
                            var priority = result![index].priority.toString();
                            var unit = allJob?.results![index].unit.toString();
                            var category = result![index].category.toString();

                            if (index == result!.length) {
                              print(index);

                              return const SizedBox(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }
                            print('${result!.length}');
                            return cardListContainer(property, serviceType, id,
                                name, issueType, priority, unit, category);
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
      print(allJob!.results!.length);
    });
  }
}
