import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services.dart';
import '../widgets.dart' show SajdaImage, WidgetAnimator, FlexibleAppBar;

class SajdaViewPage extends StatelessWidget {
  final SajdaInfo info;

  const SajdaViewPage({Key? key, required this.info}) : super(key: key);

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
            flexibleSpace: FlexibleAppBar(
              title: info.surah.englishName,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(info.surah.englishNameTranslation),
                  Text(
                    info.surah.name,
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(5.0),
              width: size.width,
              height: size.height * 0.692,
              child: Stack(
                children: [
                  SajdaImage(),
                  Column(
                    children: [
                      SizedBox(height: size.height * 0.05),
                      Text(
                        "Sajda Ayah",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      WidgetAnimator(
                        ListTile(
                          trailing: CircleAvatar(
                            radius: size.height * 0.013,
                            backgroundColor: Color(0xff04364f),
                            child: CircleAvatar(
                              radius: size.height * 0.012,
                              backgroundColor: Colors.white,
                              child: Text(
                                info.ayah.id.toString(),
                                style: TextStyle(fontSize: size.height * 0.015),
                              ),
                            ),
                          ),
                          title: Text(
                            info.ayah.content,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.height * 0.03,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.grey,
                        enabled: true,
                        child: Column(
                          children: [
                            Text(
                              "--- Sajda Info ---\n",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _infoText("Juz", info.ayah.juz.toString(), size),
                            _infoText("Ruku", info.ayah.ruku.toString(), size),
                            _infoText(
                                "Chapter", info.surah.revelationType, size)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoText(String leading, String info, Size size) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          leading + ": ",
          style: TextStyle(
            color: Colors.black,
            fontSize: size.height * 0.025,
          ),
        ),
        Text(
          info,
          style: TextStyle(
            color: Colors.black87,
            fontSize: size.height * 0.025,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
