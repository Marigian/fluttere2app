import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:logger/logger.dart'; // Import the logger package

import '../../../../config/translations/strings_enum.dart';
import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);

  // Initialize the logger
  static final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    logger.i("WelcomeView: Widget build started."); // Logging outside the widget tree

    // Use addPostFrameCallback at the start of the build process
    WidgetsBinding.instance.addPostFrameCallback((_) {
      logger.i("WelcomeView: Initial frame rendered.");
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(Constants.welcome, fit: BoxFit.fill),
          ),
          // Adding "Helping Hand" label
          Positioned(
            top: 50.h,
            left: 20.w,
            right: 20.w,
            child: Text(
              'Helping Hand',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ).animate().fade().slideY(
              duration: 300.ms,
              begin: -1,
              curve: Curves.easeInSine,
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              height: 360.h,
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 27.h),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                children: [
                  AnimatedSmoothIndicator(
                    activeIndex: 1,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: theme.primaryColor,
                      dotColor: theme.colorScheme.secondary,
                      dotWidth: 10.w,
                      dotHeight: 10.h,
                    ),
                  ),
                  24.verticalSpace,
                  Text(
                    Strings.welcomScreenTitle.tr,
                    style: theme.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ).animate().fade().slideY(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
                  16.verticalSpace,
                  Text(
                    Strings.welcomScreenSubtitle.tr,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1),
                    textAlign: TextAlign.center,
                  ).animate(delay: 300.ms).fade().slideY(
                    duration: 300.ms,
                    begin: -1,
                    curve: Curves.easeInSine,
                  ),
                  const Spacer(),
                  CustomButton(
                    onPressed: () {
                      logger.i("Get Started button clicked. Navigating to HOME.");
                      Get.toNamed(Routes.HOME);
                    },
                    text: Strings.getStarted.tr,
                    fontSize: 18.sp,
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    width: 265.w,
                    radius: 30.r,
                    verticalPadding: 20.h,
                  ).animate().fade().slideY(
                    duration: 300.ms,
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      logger.i("Login link tapped. Navigating to LOGIN.");
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Strings.alreadyHaveAnAccount.tr,
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: Strings.login.tr,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ).animate(delay: 300.ms).fade().slideY(
                      duration: 300.ms,
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                  ),
                ],
              ),
            ).animate().fade(duration: 300.ms),
          ),
        ],
      ),
    );
  }
}
