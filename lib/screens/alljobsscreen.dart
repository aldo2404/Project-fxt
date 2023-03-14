import 'package:flutter/material.dart';
import 'package:fx_project/layout/cardlist.dart';

class AllJobsScreen extends StatefulWidget {
  final String alljobscount;
  const AllJobsScreen({super.key, required this.alljobscount});

  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  @override
  Widget build(BuildContext context) {
    var listcount = widget.alljobscount;
    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 333,
                    height: 40,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.filter_list,
                          semanticLabel: 'Filter',
                        ),
                        label: const Text('Fliter'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            cardListContainer(),
          ],
        ),
      ),
    );
  }
}
