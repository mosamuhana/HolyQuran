import 'package:flutter/material.dart';

import '../assets.dart';
import '../nav.dart';
import '../services.dart';
import '../flares.dart';
import '../widgets.dart' show BackBtn, CustomImage, CustomTitle, WidgetAnimator;

class JuzzIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(0, size.height * 0.2, 0, 0),
              child: GridView.builder(
                itemCount: 30,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: _itemBuilder,
              ),
            ),
            BackBtn(),
            CustomImage(
              opacity: 0.3,
              height: size.height * 0.2,
              url: Images.quranRail,
              isFile: true,
            ),
            CustomTitle(title: "Juzz Index"),
            ...createFlares(size),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final isDark = SettingService.isDark;
    return WidgetAnimator(
      GestureDetector(
        onTap: () => Nav.showJuzz(context, index + 1),
        child: Card(
          shape: isDark ? StadiumBorder() : RoundedRectangleBorder(),
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.white70,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.white, width: 1),
            ),
            alignment: Alignment.center,
            child: Text(
              "${index + 1}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
