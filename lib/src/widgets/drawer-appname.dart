import 'package:flutter/material.dart';

import '../assets.dart';
import '../services.dart';

class DrawerAppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = SettingService.isDark;
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.scale(
              scale: 1.5,
              child: Switch(
                inactiveThumbImage: FileImage(Images.sun.toFile),
                activeThumbImage: FileImage(Images.moon.toFile),
                activeColor: Colors.grey[900],
                value: isDark,
                onChanged: (v) => SettingService.isDark = v,
              ),
            ),
            Text(
              "\nThe",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.025,
                color: isDark ? Colors.grey[200] : Colors.black54,
              ),
            ),
            Text(
              "Holy\nQur'an",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.grey[200] : Colors.black54,
                fontSize: height * 0.035,
              ),
            )
          ],
        ),
        Image.file(Images.gradLogo.toFile, height: height * 0.17)
      ],
    );
  }
}
