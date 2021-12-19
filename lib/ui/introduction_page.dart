import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation_app/constants/colors.dart';
import 'package:graduation_app/ui/home_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
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
        title: 'int1_t'.tr(),
        body: 'int1_b'.tr(),
        decoration: decoration,
      ),
      PageViewModel(
        image: introImage('assets/images/image0.jpeg', 60.w, 25.h),
        title: 'int2_t'.tr(),
        body: 'int2_b'.tr(),
        decoration: decoration,
      ),
      PageViewModel(
        image: introImage('assets/images/image4.png', 60.w, 25.h),
        title: 'int3_t'.tr(),
        body: 'int3_b'.tr(),
        decoration: decoration,
      ),
      PageViewModel(
        image: introImage('assets/images/image2.png', 60.w, 25.h),
        title: 'int4_t'.tr(),
        body: 'int4_b'.tr(),
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
      /*
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Image.asset('assets/icons/app-icon-512.png', width: 10.w),
          ),
        ),
      ),
      */
      //rtl: true, // Display as right-to-left
      skip: Text('int_s'.tr()),
      next: const Icon(Icons.arrow_forward),
      done: Text('int_d'.tr(),
          style: const TextStyle(fontWeight: FontWeight.w700)),
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
