import 'package:flutter/material.dart';

import '../services.dart';
import '../widgets.dart' show WidgetAnimator, FlexibleAppBar;

class SurahViewPage extends StatelessWidget {
  final Surah surah;
  final List<Ayah> ayat;

  SurahViewPage(this.surah) : this.ayat = QuranData.getAyatInSurah(surah.id);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:
                SettingService.isDark ? Colors.grey[850] : Colors.white,
            pinned: true,
            expandedHeight: size.height * 0.27,
            //flexibleSpace: _flexibleAppBar(context, size.height),
            flexibleSpace: FlexibleAppBar(
              title: surah.englishName,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(surah.englishNameTranslation),
                  Text(
                    surah.name,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
          ),
          _buildList(size),
        ],
      ),
    );
  }

  Widget _buildList(Size size) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildAyah(ayat[index], size),
        childCount: ayat.length,
      ),
    );

    /*
    return FutureBuilder<List<Ayah>>(
      future: Database().getAyatInSurah(surah.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final ayat = snapshot.data!;
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildAyah(ayat[index], size),
            childCount: ayat.length,
          ),
        );
      },
    );
    */
  }

  Widget _buildAyah(Ayah ayah, Size size) {
    final w = size.width;
    final h = size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.015, 0, 0, 0),
      child: WidgetAnimator(
        ListTile(
          trailing: CircleAvatar(
            radius: h * 0.013,
            backgroundColor: Color(0xff04364f),
            child: CircleAvatar(
              radius: h * 0.012,
              backgroundColor: Colors.white,
              child: Text(
                ayah.order.toString(),
                style: TextStyle(fontSize: h * 0.015),
              ),
            ),
          ),
          title: Text(
            ayah.content,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: h * 0.03,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
