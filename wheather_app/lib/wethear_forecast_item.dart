import 'package:flutter/material.dart';

class WeatherForecastItem extends StatelessWidget {
  final String temp;
  final Icon icon;
  final String time;
  const WeatherForecastItem({
    super.key,
    required this.icon,
    required this.temp,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(15)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                icon,
                SizedBox(height: 15),
                Text(
                  "${double.parse((double.parse(temp) - 273.15).toStringAsFixed(2))}°C",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
