import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import '../assets.dart';
import '../constants.dart';
import '../widgets.dart' show BackBtn, CustomTitle, AppVersion, ShimmerText;

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: ShimmerText(title: 'Share App'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.file(Images.gradLogo.toFile, height: 150),
          _buildButtons(context),
          _buildVersion(context),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        Text(
          "$APP_NAME App is also available as Open Source on GitHub!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 10),
        _IconButton(
          title: 'GitHub Repo',
          icon: ShareIcons.github,
          onPressed: () => Launcher.launch(GITHUB_LINK),
        ),
        if (Platform.isAndroid || Platform.isIOS)
          _IconButton(
            title: 'Share App',
            icon: Icons.share,
            onPressed: () => _shareApp(context),
          ),
        if (Platform.isAndroid)
          _IconButton(
            title: 'Rate & Feedback',
            icon: ShareIcons.google_play,
            onPressed: () => _launchAndroid(context),
          ),
        if (Platform.isIOS)
          _IconButton(
            title: 'Rate & Feedback',
            icon: Icons.ios_share,
            onPressed: () => _launchIOS(context),
          ),
      ],
    );
  }

  Widget _buildVersion(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          APP_NAME,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          "Version: $APP_VERSION\n",
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  String? get _storeName {
    if (Platform.isAndroid) return 'Play Store';
    if (Platform.isIOS) return 'App Store';
    return null;
  }

  String? get _appLink {
    if (Platform.isAndroid) {
      return ANDROID_APP_ID == null
          ? null
          : 'https://play.google.com/store/apps/details?id=$ANDROID_APP_ID';
    }
    if (Platform.isIOS) {
      //return IOS_APP_ID == null ? null : '....';
    }
    return null;
  }

  Future<void> _shareApp(BuildContext context) async {
    if (_appLink == null) {
      _notAvailable(context);
      return;
    }

    final box = context.findRenderObject() as RenderBox;
    final sharePositionOrigin = box.localToGlobal(Offset.zero) & box.size;
    await Share.share(
      "Download the latest Holy Qur'an App on $_storeName\n\n"
      "$_appLink \n\nShare More! It is Sadaq-e-Jaria :)",
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  Future<void> _launchAndroid(BuildContext context) async {
    if (ANDROID_APP_ID != null) {
      await LaunchReview.launch(androidAppId: ANDROID_APP_ID);
    } else {
      _notAvailable(context);
    }
  }

  Future<void> _launchIOS(BuildContext context) async {
    if (ANDROID_APP_ID != null) {
      await LaunchReview.launch(iOSAppId: IOS_APP_ID);
    } else {
      _notAvailable(context);
    }
  }

  void _notAvailable(BuildContext context) {
    _showSnackBar(context, 'Application not available on the $_storeName');
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _IconButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;

  const _IconButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.5,
        height: size.height * 0.055,
        // TODO:
        child: TextButton(
          //padding: EdgeInsets.all(5.0),
          //color: Color(0xffee8f8b),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: size.height * 0.03),
              SizedBox(width: 10),
              Text(title)
            ],
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final double height;

  CustomAppBar({
    required this.child,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: Colors.orange,
      alignment: Alignment.center,
      child: child,
    );
  }
}
