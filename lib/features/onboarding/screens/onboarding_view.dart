import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mafuriko/core/routes/constant_path.dart';
import 'package:mafuriko/features/authentication/presentation/blocs/bloc/auth_bloc.dart';
import 'package:mafuriko/features/onboarding/cubit/count_cubit.dart';
import 'package:mafuriko/features/onboarding/widgets/onboard_view.dart';
import 'package:mafuriko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:mafuriko/gen/gen.dart';
import 'package:mafuriko/shared/theme/app_color_scheme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess && state.request == Request.checkUser) {
          context.goNamed(Paths.home);
          context.read<ProfileBloc>().add(LoadUserProfile(state.user));
        }
        if (state.runtimeType == AuthUnauthenticated) {
          context.go(Paths.initialPath);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            context.watch<CountCubit>().state.pagePos == 2.0
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(Paths.signUp);
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
                      context.read<CountCubit>().positionChanged(value);
                    },
                    children: [
                      OnboardView(
                        img: AppImages.images.onboarding.illustrationOne.path,
                        desc: 'Suivez toute l’actualité\nsur les inondations',
                      ),
                      OnboardView(
                        img: AppImages.images.onboarding.illustrationTwo.path,
                        desc: 'Aidez nous à collecter \nles données',
                      ),
                      OnboardView(
                        img: AppImages.images.onboarding.illustrationThree.path,
                        desc: 'Soyez informés des \nfutures inondations',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      Column(
                        children: [
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            onDotClicked: (index) {
                              double offset = index.toDouble() *
                                  _controller.position.viewportDimension;
                              Duration duration =
                                  const Duration(milliseconds: 300);
                              Curve curve = Curves.easeInOut;

                              _controller.animateTo(
                                offset,
                                duration: duration,
                                curve: curve,
                              );
                            },
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
                                  onPressed: () {
                                    context.pushNamed(Paths.signUp);
                                  },
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
                        ],
                      ),
                    ],
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
