import 'package:flutter/material.dart';
import 'package:weatheros/model/weather.dart';
import 'package:weatheros/service/weather_api_client.dart';
import 'package:weatheros/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("Tunis");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Weatheros",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.indigo),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    currentWeather(Icons.wb_sunny_rounded, "${data!.temp}",
                        "${data!.cityName}")
                  ]);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          }),
    );
  }
}
