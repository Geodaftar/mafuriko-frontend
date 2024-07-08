import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mafuriko/features/onboarding/widgets/onboard_view.dart';
import 'package:mafuriko/gen/assets.gen.dart';
import 'package:mafuriko/gen/fonts.gen.dart';
import 'package:mafuriko/shared/theme/app_color_scheme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _page == 2.0
              ? Container()
              : Padding(
                  padding: EdgeInsets.only(right: 18.w),
                  child: InkWell(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      'Sauter',
                      style: TextStyle(
                        color: AppColorScheme.primary,
                        fontSize: 16.sp,
                        fontFamily: AppFonts.nunito,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
        ],
        backgroundColor: AppColorScheme.white,
      ),
      backgroundColor: AppColorScheme.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 6,
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      _page = value;
                    });
                  },
                  children: [
                    OnboardView(
                      img: AppImages.images.onboarding.illustrationOne.path,
                      desc: 'Suivez toute l’actualité\nsur les inondations',
                    ),
                    OnboardView(
                      img: AppImages.images.onboarding.illustrationTwo.path,
                      desc: 'Aidez nous a prévoir les futures inondations',
                    ),
                    OnboardView(
                      img: AppImages.images.onboarding.illustrationThree.path,
                      desc: 'Aidez nous a prévoir les futures inondations',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Column(
                      children: [
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: WormEffect(
                            activeDotColor: AppColorScheme.primary,
                            dotHeight: 10.h,
                            dotColor: AppColorScheme.gray,
                            spacing: 5.w,
                            dotWidth: 10.w,
                            type: WormType.underground,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Commencer',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontFamily: AppFonts.inter,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          onPressed: () {},
                          child: Text(
                            'Vous avez deja un compte?',
                            style: TextStyle(
                              color: const Color(0xFF6F6F6F),
                              fontSize: 14.sp,
                              fontFamily: AppFonts.lato,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                          child: TextButton(
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            onPressed: () {},
                            child: Text(' Ajouter un profil visiteur.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: AppFonts.lato,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
