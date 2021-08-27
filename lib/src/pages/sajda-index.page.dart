import 'package:flutter/material.dart';

import '../assets.dart';
import '../nav.dart';
import '../services.dart';
import '../flares.dart';
import '../widgets.dart' show BackBtn, CustomTitle, CustomImage, WidgetAnimator;

class SajdaIndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final list = QuranData.getSajdas();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.fromLTRB(0, size.height * 0.2, 0, 0),
              child: ListView.separated(
                separatorBuilder: (_, __) => _divider,
                itemCount: list.length,
                itemBuilder: (context, index) =>
                    _buildItem(context, list[index]),
              ),
            ),
            BackBtn(),
            CustomTitle(title: "Sajda Index"),
            CustomImage(
              opacity: 0.3,
              height: size.height * 0.2,
              url: Images.roza,
              isFile: true,
            ),
            ...createFlares(size),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, SajdaInfo item) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return WidgetAnimator(
      ListTile(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => _SajdaInfo(item),
          );
        },
        leading: Text("${item.ayah.order}", style: bodyText1), // sajdaNumber
        title: Text("${item.surah.englishName}", style: bodyText1),
        subtitle: Text("${item.surah.englishNameTranslation}"),
        trailing: Text("${item.surah.name}", style: bodyText1),
        onTap: () => Nav.showSajda(context, item),
      ),
    );
  }

  final _divider = Divider(color: Color(0xffee8f8b), height: 2);
}

class _SajdaInfo extends StatefulWidget {
  final SajdaInfo item;

  _SajdaInfo(this.item);

  @override
  _SajdaInfoState createState() => _SajdaInfoState();
}

class _SajdaInfoState extends State<_SajdaInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  SajdaInfo get item => widget.item;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = SettingService.isDark;
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;
    final textTheme = Theme.of(context).textTheme;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: width * 0.75,
            height: height * 0.39,
            decoration: ShapeDecoration(
              color: isDark ? Colors.grey[800] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sajda Information",
                  style: textTheme.headline2,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.surah.englishName,
                      style: textTheme.bodyText1,
                    ),
                    Text(
                      item.surah.name,
                      style: textTheme.bodyText1,
                    ),
                  ],
                ),
                Text("Sajda Number: ${item.ayah.order}"),
                Text("Juz Number: ${item.ayah.juz}"),
                Text("Ruku Number: ${item.ayah.ruku}"),
                Text("Meaning: ${item.surah.englishNameTranslation}"),
                Text("Chapter Type: ${item.surah.revelationType}"),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: TextButton(
                    //color: Color(0xffee8f8b),
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
