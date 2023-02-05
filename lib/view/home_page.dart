import 'package:covid/model/service/service_place.dart';
import 'package:covid/view/country_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final system = SystemUiOverlayStyle(statusBarColor: Colors.grey[200]);
  List<Color> colorList = [
    const Color(0xFF0071FF),
    const Color(0xFFFF8C00),
    const Color(0xFF00FF00),
    const Color(0xFFFF7F50),
    const Color(0xFFFF1493),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(system);
    ServicePlace servicePlace = ServicePlace();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[200],
        title: const Text(
          "Covid Report",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: FutureBuilder(
        future: servicePlace.getAll(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      "Active Report",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  PieChart(
                    dataMap: {
                      'Death': double.parse(snapshot.data!.cases.toString()),
                      'Active': double.parse(snapshot.data!.active.toString()),
                      'Critical':
                          double.parse(snapshot.data!.critical.toString()),
                      'Recovered':
                          double.parse(snapshot.data!.recovered.toString()),
                      'Population':
                          double.parse(snapshot.data!.population.toString()),
                    },
                    chartRadius: 170.0,
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NewWidget(
                          keys: 'Population',
                          values: snapshot.data!.population.toString(),
                        ),
                        NewWidget(
                          keys: 'Active',
                          values: snapshot.data!.active.toString(),
                        ),
                        NewWidget(
                          keys: 'Updated',
                          values: snapshot.data!.updated.toString(),
                        ),
                        NewWidget(
                          keys: 'Recovered',
                          values: snapshot.data!.recovered.toString(),
                        ),
                        NewWidget(
                          keys: 'Today Case',
                          values: snapshot.data!.todayCases.toString(),
                        ),
                        NewWidget(
                          keys: 'Death',
                          values: snapshot.data!.deaths.toString(),
                        ),
                        NewWidget(
                          keys: 'Critical',
                          values: snapshot.data!.critical.toString(),
                        ),
                        NewWidget(
                          keys: 'Today',
                          values: snapshot.data!.todayCases.toString(),
                        ),
                        NewWidget(
                          keys: 'Test',
                          values: snapshot.data!.tests.toString(),
                        ),
                        NewWidget(
                          keys: 'Cases',
                          values: snapshot.data!.cases.toString(),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CountryPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              height: 50.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.black),
                              child: const Center(
                                child: Text(
                                  "View Countries",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  final String keys;
  final String values;
  const NewWidget({Key? key, required this.keys, required this.values})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(5.0)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  keys,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  values,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
