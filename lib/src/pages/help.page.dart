import 'package:flutter/material.dart';

import '../assets.dart';
import '../widgets.dart' show CustomImage, BackBtn, CustomTitle, AppVersion;
import '../constants.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomImage(
              url: Images.gradLogoSmall,
              opacity: 0.5,
              height: h * 0.18,
              isFile: true,
            ),
            BackBtn(),
            CustomTitle(title: "Help Guide"),
            _buildList(h),
            AppVersion(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(double h) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.fromLTRB(0, h * 0.2, 0, h * 0.1),
      child: ListView.builder(
        itemCount: _guidList.length,
        itemBuilder: (context, index) {
          final item = _guidList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "\n${index + 1}. ${item.title}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: h * 0.03),
                Text(
                  item.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: h * 0.020),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Guide {
  final String title;
  final String description;

  _Guide({
    required this.title,
    required this.description,
  });
}

final _guidList = <_Guide>[
  _Guide(
    title: "Internet Connectivity",
    description:
        "For now, the app is NOT available in Offline reading mode. So, internet connection is a must for getting all the data.",
  ),
  _Guide(
    title: "Juzz - Surah Index",
    description:
        "Open any Juzz, Surah or Sajda directly from index. It has all 30 chapters and 114 surahs." +
            " Press and hold any Surah or Sajda for viewing a brief information about it.",
  ),
  _Guide(
    title: "Sajda Index",
    description: "Open any Sajda Ayah directly from index. It has all 15 Sajdas." +
        " Further there will be information about every Sajda inside, including Juzz, Ruku and Chapter type of Surah",
  ),
  _Guide(
    title: "Introduction Tab",
    description:
        "It will re-open the introduction of app that you might have saw when opened the app for the first time",
  ),
  _Guide(
    title: "Rate & Feedback",
    description:
        "You can give your precious feedback and rate our app on Google play store.",
  ),
  _Guide(
    title: "Reporting a Mistake",
    description:
        "If you see any mistake in context of this Holy Book please report at the following link:" +
            "\n\nhttps://api.alquran.cloud",
  ),
  _Guide(
    title: "Code Available",
    description: "Code for v1.0.0 is available at the following link: " +
        "\n\n$GITHUB_LINK" +
        "\n\nThe code is only for learning purposes, it has proper LICENSE that you are not allowed to publish this app.",
  ),
  _Guide(
    title: "Developer's Info",
    description:
        "Name: $DEVELOPER_NAME \nEmail: $EMAIL_ADDRESS \nGitHub: @$GITHUB_USER \nWebsite: $WEBSITE",
  ),
];
