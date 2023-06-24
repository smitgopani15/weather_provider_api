import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/api_helper.dart';
import '../modal/home_modal.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? homeProviderTrue;
  HomeProvider? homeProviderFalse;

  @override
  Widget build(BuildContext context) {
    homeProviderTrue = Provider.of<HomeProvider>(context, listen: true);
    homeProviderFalse = Provider.of<HomeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/images/1.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black26,
            ),
            FutureBuilder(
              future: ApiHelper().weatherApiCall(homeProviderTrue!.city == null
                  ? "Gujarat"
                  : "${homeProviderTrue!.city}"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                if (snapshot.hasData) {
                  WeatherModel? h1 = snapshot.data;
                  return Stack(
                    children: [
                      Container(
                        height: 80,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Text(
                                "${h1!.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.black12,
                                        shape: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        actions: [
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextField(
                                                  controller:
                                                      homeProviderTrue!.txtcity,
                                                  cursorColor: Colors.white,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  decoration: InputDecoration(
                                                    label: Text(
                                                      "Search City",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        20,
                                                      ),
                                                    ),
                                                  ),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    homeProviderTrue!.search();
                                                    Navigator.pop(context);
                                                    homeProviderTrue!.txtcity
                                                        .clear();
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        15,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 240,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(h1.main!.temp! - 273).toStringAsFixed(0)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 90,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Text(
                                  "°",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 75,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 11),
                                child: Text(
                                  "C",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${h1.weather![0].description}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${DateTime.now().weekday == 1 ? "Monday" : ""}${DateTime.now().weekday == 2 ? "Tuesday" : ""}${DateTime.now().weekday == 3 ? "Wednesday" : ""}${DateTime.now().weekday == 4 ? "Thursday" : ""}${DateTime.now().weekday == 5 ? "Friday" : ""}${DateTime.now().weekday == 6 ? "Saturday" : ""}${DateTime.now().weekday == 7 ? "Sunday" : ""} ,${DateTime.now().day} ${DateTime.now().month == 1 ? "Jan" : ""}${DateTime.now().month == 2 ? "Feb" : ""}${DateTime.now().month == 3 ? "Mar" : ""}${DateTime.now().month == 4 ? "Apr" : ""}${DateTime.now().month == 5 ? "May" : ""}${DateTime.now().month == 6 ? "Jun" : ""}${DateTime.now().month == 7 ? "July" : ""}${DateTime.now().month == 8 ? "Aug" : ""}${DateTime.now().month == 9 ? "Sep" : ""}${DateTime.now().month == 10 ? "Oct" : ""}${DateTime.now().month == 11 ? "Nov" : ""}${DateTime.now().month == 12 ? "Dec" : ""} ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                height: 10,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.air,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "${(h1.wind!.speed)!.toStringAsFixed(1)} km/h",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Wind",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.water_drop_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "${(h1.main!.humidity)!.toStringAsFixed(0)} %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Humidity",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.cloud_queue_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "${(100 - h1.clouds!.all!).toStringAsFixed(0)} %",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            "Chance of rain",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Visibility - ${h1.visibility} m",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 10,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
