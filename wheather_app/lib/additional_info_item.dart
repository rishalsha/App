import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final Icon icon;
  final String propertName;
  final String propertyValue;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.propertName,
    required this.propertyValue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: Column(
        children: [
          icon,
          SizedBox(height: 10),
          Text(
            propertName,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),

          SizedBox(height: 10),

          Text(
            propertyValue,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
