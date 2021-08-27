import 'package:flutter/material.dart';

import '../services.dart';
import '../widgets.dart' show DrawerAppName, AppVersion;

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = SettingService.isDark;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.835,
      height: size.height,
      child: Material(
        color: isDark ? Colors.grey[800] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerAppName(),
              Column(
                children: [
                  _buildListTile(
                    context,
                    size.height,
                    Icons.format_list_bulleted,
                    "Juzz Index",
                    "/juzzIndex",
                    isDark ? Colors.grey[700]! : Colors.white,
                  ),
                  _buildListTile(
                    context,
                    size.height,
                    Icons.format_list_numbered,
                    "Surah Index",
                    "/surahIndex",
                    isDark ? Colors.grey[700]! : Colors.white,
                  ),
                  _buildListTile(
                    context,
                    size.height,
                    Icons.format_align_left,
                    "Sajda Index",
                    "/sajdaIndex",
                    isDark ? Colors.grey[700]! : Colors.white,
                  ),
                  _buildListTile(
                    context,
                    size.height,
                    Icons.help,
                    "Help Guide",
                    "/help",
                    isDark ? Colors.grey[700]! : Colors.white,
                  ),
                  _buildListTile(
                    context,
                    size.height,
                    Icons.info,
                    "Introduction",
                    "/introduction",
                    isDark ? Colors.grey[700]! : Colors.white,
                  ),
                  _buildListTile(
                    context,
                    size.height,
                    Icons.share,
                    "Share App",
                    "/shareApp",
                    isDark ? Colors.grey[700]! : Colors.white,
                  ),
                ],
              ),
              AppVersion()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    double height,
    IconData tileIcon,
    String title,
    String pushName,
    Color color,
  ) {
    return Card(
      color: color,
      child: ListTile(
        leading: Icon(tileIcon, size: height * 0.035),
        title: Text(title),
        onTap: () => Navigator.pushNamed(context, pushName),
      ),
    );
  }
}
