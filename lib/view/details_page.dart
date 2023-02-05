import 'package:covid/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailsPage extends StatefulWidget {
  String name;
  String image;
  String totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailsPage(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.totalRecovered,
      Key? key})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final system = const SystemUiOverlayStyle(statusBarColor: Colors.black);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(system);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const Text(
                      'Country',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Image(
                    image: NetworkImage(widget.image),
                  ),
                ),
              ],
            ),
          ),
          NewWidget(keys: 'Active', values: widget.active),
          NewWidget(keys: 'Cases', values: widget.totalCases),
          NewWidget(keys: 'Recovered', values: widget.totalRecovered),
          NewWidget(keys: 'Deaths', values: widget.totalDeaths),
          NewWidget(keys: 'Test', values: widget.test),
          NewWidget(keys: 'Critical', values: widget.critical),
        ],
      ),
    );
  }
}
