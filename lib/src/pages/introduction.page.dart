import 'package:flutter/material.dart';
import '../widgets.dart';

import '../assets.dart' show Images;
import '../nav.dart';

class IntroductionPage extends StatelessWidget {
  final _pages = [
    PageModel(
      color: Colors.grey[700],
      url: Images.gradLogo,
      title: "The Holy Qur'an",
      body:
          "\"Indeed, It is We who sent down the Qur'an and indeed, We will be its Guardian\"\n",
      doAnimateImage: true,
    ),
    PageModel(
      color: const Color(0xff106791),
      url: Images.ui,
      title: "Fancy & Beautiful Design",
      body:
          "We have worked hard to choose beautiful Colors, Animations and overall an appealing Design for this Beautiful Book",
      doAnimateImage: true,
    ),
    PageModel(
      color: const Color(0xff664d7b),
      url: Images.sajdaIndex,
      title: "Sajda Index",
      body:
          "Now, with Sajda Index you can directly open any Sajda in Qur'an from the list along with brief information about it.",
      doAnimateImage: true,
    ),
    PageModel(
      color: const Color(0xff04364f),
      url: Images.easyNav,
      title: "Easy to Explore",
      body:
          "Open Juzz, Surah or Sajda directly from the index. Long press any Surah or Sajda will show brief information about it.",
      doAnimateImage: true,
    ),
    PageModel(
      color: Colors.grey[850],
      //imageAssetPath: ResImages.drawer3d,
      url: Images.drawer3d,
      title: "3D Animated Drawer",
      body:
          "We have introduced a unique 3D Animated drawer. Share your feedback about such ideas.",
      doAnimateImage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: _pages,
        showBullets: true,
        skipCallback: () => Nav.showHome(context),
        finishCallback: () => Nav.showHome(context),
      ),
    );
  }
}
