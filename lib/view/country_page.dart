import 'package:covid/model/service/service_place.dart';
import 'package:covid/view/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Country_model.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final searchController = TextEditingController();
  List<CountryModel> countryList = [];

  @override
  Widget build(BuildContext context) {
    ServicePlace servicePlace = ServicePlace();
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text("All Countries"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[300]),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: TextFormField(
                  controller: searchController,
                  onTap: () {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      hintText: "Search by country",
                      border: InputBorder.none,
                      prefixIcon: Icon(CupertinoIcons.search)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: servicePlace.getCountry(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  DetailsPage(
                                        name: snapshot.data![index]['country'].toString(),
                                        image: snapshot.data![index]['countryInfo']['flag'].toString(),
                                        totalCases: snapshot.data![index]['cases'].toString(),
                                        totalDeaths: snapshot.data![index]['deaths'].toString(),
                                        active: snapshot.data![index]['active'].toString(),
                                        critical: snapshot.data![index]['critical'].toString(),
                                        todayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                        test: snapshot.data![index]['tests'].toString(),
                                        totalRecovered: snapshot.data![index]['totalRecovered'].toString()
                                    ),
                                ),
                              );
                            },
                            leading: Container(
                              height: 50.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0)),
                              child: Image(
                                image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']
                                    .toString()),
                              ),
                            ),
                            title: Text(
                                snapshot.data![index]['country'].toString()),
                            subtitle: Text(
                                snapshot.data![index]['active'].toString()),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
