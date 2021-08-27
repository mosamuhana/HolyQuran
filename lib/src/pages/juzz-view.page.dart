import 'package:flutter/material.dart';

import '../services.dart';
import '../widgets.dart' show WidgetAnimator, FlexibleAppBar;

class JuzzViewPage extends StatelessWidget {
  final int juzz;

  const JuzzViewPage({Key? key, required this.juzz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context, QuranData.getJuzzInfo(juzz)),
    );
  }

  Widget _buildBody(BuildContext context, JuzzInfo info) {
    final isDark = SettingService.isDark;
    final size = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: isDark ? Colors.grey[850] : Colors.white,
          pinned: true,
          expandedHeight: size.height * 0.27,
          flexibleSpace: FlexibleAppBar(
            title: "Juzz No. ${info.index}",
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Starting Surah"),
                Text(
                  "${info.firstSurah.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.045,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            height: size.height * 0.7,
            width: size.width,
            child: ListView.builder(
              itemCount: info.ayahList.length,
              itemBuilder: (context, index) {
                final ayah = info.ayahList[index];
                return WidgetAnimator(
                  ListTile(
                    title: Text(
                      ayah.content,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: size.height * 0.03,
                        color: Colors.black,
                      ),
                    ),
                    trailing: CircleAvatar(
                      radius: size.height * 0.018,
                      backgroundColor: Color(0xff04364f),
                      child: CircleAvatar(
                        radius: size.height * 0.017,
                        backgroundColor: Colors.white,
                        child: Text(
                          ayah.id.toString(),
                          style: TextStyle(fontSize: size.height * 0.0135),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
