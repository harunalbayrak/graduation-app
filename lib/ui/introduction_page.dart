import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/ui/home_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  void _onIntroEnd(context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return const HomePage();
      },
    ), (Route<dynamic> route) => false);
  }

  Widget introImage(String assetName, double width, double height) {
    //widget to show intro image
    return Column(
      children: [
        SizedBox(height: height),
        Align(
          child: Image.asset(assetName, width: width),
          alignment: Alignment.topCenter,
        ),
      ],
    );
  }

  PageDecoration decoration = PageDecoration(
    titleTextStyle:
        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: gray),
    bodyTextStyle: TextStyle(fontSize: 17.sp, color: gray),
    contentMargin: EdgeInsets.symmetric(horizontal: 7.w),
    fullScreen: true,
    bodyFlex: 5,
    imageFlex: 10,
    pageColor: darkBlue,
  );

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: introImage('assets/images/image5.png', 60.w, 20.h),
        title: 'Personal Firewall',
        body:
            'Firewall protection is effective as possible against hackers, espionage, and known spy, dangerous servers.',
        decoration: decoration,
      ),
      PageViewModel(
        image: introImage('assets/images/image4.png', 60.w, 25.h),
        title: "Block Apps with One Click",
        body:
            'Avoid unauthorized sending of personal data or connections to intelligence services, and control internet access depending on the network type.',
        decoration: decoration,
      ),
      PageViewModel(
        image: introImage('assets/images/image4.png', 60.w, 25.h),
        title: "Monitor Activities",
        body:
            'Monitor internet access and statistics of your phone and applications on your phone. In this way, avoid unnecessary internet access.',
        decoration: decoration,
      ),
      PageViewModel(
        image: introImage('assets/images/image2.png', 60.w, 25.h),
        title: "Filter DNS",
        body:
            'Restrict access to various known and dangerous hosts with domain filtering. Increase your security.',
        decoration: decoration,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: darkBlue,
      globalHeader: const Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, right: 16),
            child: Icon(Icons.ac_unit_outlined),
          ),
        ),
      ),
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(5.w),
      controlsPadding: EdgeInsets.all(2.2.w),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      onDone: () {
        _onIntroEnd(context);
      },
      onSkip: () {
        _onIntroEnd(context);
      },
      pages: getPages(),
    );
  }
}
