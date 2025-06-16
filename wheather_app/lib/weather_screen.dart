import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wheather_app/additional_info_item.dart' show AdditionalInfoItem;
import 'package:wheather_app/secretkey.dart';
import 'package:wheather_app/wethear_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  final VoidCallback onToggle;

  const WeatherScreen({super.key, required this.onToggle});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Taliparamba';
      final result = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey',
          //https://api.openweathermap.org/data/2.5/forecast?q=London&APPID=153077b42c61365c61a89d612c4b3826
        ),
      );

      final data = jsonDecode(result.body);

      if (data["cod"] != "200") {
        throw 'An unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: widget.onToggle,
          icon: Icon(Icons.toggle_on),
        ),

        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final double currentTemp = double.parse(
            (double.parse('${data['list'][0]['main']['temp']}') - 273.15)
                .toStringAsFixed(2),
          );

          final String currentWeather = data['list'][0]['weather'][0]['main'];

          final Map<String, IconData> iconMap = {
            "Clouds": Icons.cloud,
            "Clear": Icons.sunny,
            'Rain': Icons.cloudy_snowing,
          };

          final double currentWindSpeed = data['list'][0]['wind']['speed'];

          final int currentHumidity = data['list'][0]['main']['humidity'];
          final int currentPressure = data['list'][0]['main']['pressure'];

          final Map<String, String> timeMap = {
            '00:00': '12 AM',
            '01:00': '1 AM',
            '02:00': '2 AM',
            '03:00': '3 AM',
            '04:00': '4 AM',
            '05:00': '5 AM',
            '06:00': '6 AM',
            '07:00': '7 AM',
            '08:00': '8 AM',
            '09:00': '9 AM',
            '10:00': '10 AM',
            '11:00': '11 AM',
            '12:00': '12 PM',
            '13:00': '1 PM',
            '14:00': '2 PM',
            '15:00': '3 PM',
            '16:00': '4 PM',
            '17:00': '5 PM',
            '18:00': '6 PM',
            '19:00': '7 PM',
            '20:00': '8 PM',
            '21:00': '9 PM',
            '22:00': '10 PM',
            '23:00': '11 PM',
          };

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 238,
                  width: double.infinity,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Text(
                                "$currentTemp°C",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Icon(iconMap[currentWeather], size: 60),
                              SizedBox(height: 10),
                              Text(
                                currentWeather,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 145,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 17,
                    itemBuilder: (context, index) {
                      return WeatherForecastItem(
                        icon: Icon(
                          iconMap['${data['list'][index + 1]['weather'][0]['main']}'],
                        ),

                        temp: '${data['list'][index + 1]['main']['temp']}',
                        time:
                            timeMap['${data['list'][index + 1]['dt_txt'].substring(11, 16)}'] ??
                            '${data['list'][index + 1]['dt_txt'].substring(11, 16)}',
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Additional Information",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  children: [
                    AdditionalInfoItem(
                      propertName: "Humidity",
                      icon: Icon(Icons.water_drop),
                      propertyValue: "$currentHumidity",
                    ),
                    AdditionalInfoItem(
                      propertName: "Wind Speed",
                      icon: Icon(Icons.air),
                      propertyValue: "$currentWindSpeed",
                    ),
                    AdditionalInfoItem(
                      propertName: "Pressure",
                      icon: Icon(Icons.scale_rounded),
                      propertyValue: "$currentPressure",
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
