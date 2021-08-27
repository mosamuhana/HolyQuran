import 'package:flutter/material.dart';

import '../assets.dart';
import '../nav.dart';
import '../services.dart';
import '../flares.dart';
import '../widgets.dart' show CustomImage, BackBtn, CustomTitle, WidgetAnimator;

class SurahIndexPage extends StatelessWidget {
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
              child: _buildList(context, QuranData.surahs, size.height),
            ),
            CustomImage(
              opacity: 0.3,
              height: size.height * 0.17,
              url: Images.kaaba,
              isFile: true,
            ),
            BackBtn(),
            CustomTitle(title: "Surah Index"),
            ...createFlares(size),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Surah> surahs, double height) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(0, height * 0.2, 0, 0),
      child: ListView.separated(
        separatorBuilder: (context, index) => _listDivider,
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return WidgetAnimator(
            ListTile(
              leading: Text("${surah.id}", style: bodyText1),
              title: Text("${surah.englishName}", style: bodyText1),
              subtitle: Text("${surah.englishNameTranslation}"),
              trailing: Text("${surah.name}", style: bodyText1),
              onLongPress: () {
                showDialog(context: context, builder: (_) => _SurahInfo(surah));
              },
              onTap: () => Nav.showSurah(context, surah),
            ),
          );
        },
      ),
    );
  }

  final _listDivider = Divider(color: Color(0xffee8f8b), height: 2);
}

class _SurahInfo extends StatefulWidget {
  final Surah surah;

  _SurahInfo(this.surah);

  @override
  _SurahInfoState createState() => _SurahInfoState();
}

class _SurahInfoState extends State<_SurahInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  String ayatCount = '...';

  Surah get surah => widget.surah;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() => setState(() {}));
    controller.forward();

    ayatCount = '${QuranData.getSurahAyatCount(surah.id)}';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: width * 0.75,
            height: height * 0.37,
            decoration: ShapeDecoration(
              color: SettingService.isDark ? Colors.grey[800] : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Surah Information",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${surah.englishName}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '${surah.name}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text("Ayahs: $ayatCount"),
                Text("Surah Number: ${surah.id}"),
                Text("Chapter: ${surah.revelationType}"),
                Text("Meaning: ${surah.englishNameTranslation}"),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.05,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffee8f8b),
                      shape: StadiumBorder(),
                    ),
                    //color: Color(0xffee8f8b),
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
