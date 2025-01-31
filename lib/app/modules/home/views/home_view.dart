import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

import '../../../../config/translations/strings_enum.dart';
import '../../../../utils/constants.dart';
import '../../../components/api_error_widget.dart';
import '../../../components/custom_icon_button.dart';
import '../../../components/my_widgets_animator.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_shimmer.dart';
import 'widgets/weather_card.dart';
import 'widgets/app_title_component.dart';
import 'widgets/your_notification_component.dart';
import 'widgets/calendar_component.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  static final Logger logger = Logger();

  void _openSpirosDisaster() async {
    final Uri url = Uri.parse('https://spiros-disaster.netlify.app/');
    logger.i("Attempting to open URL: $url");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      logger.e("Failed to launch URL: $url");
      throw 'Could not launch $url';
    }
    logger.i("Successfully launched URL: $url");
  }

  void _startNotificationTimer() {
    Timer(Duration(seconds: 3), () {
      logger.i("Widget did  not load properly");
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    logger.i("HomeView: Widget tree building started.");

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w),
          child: GetBuilder<HomeController>(
            builder: (_) {
              logger.d("Rendering content based on API call status.");
              return MyWidgetsAnimator(
                apiCallStatus: controller.apiCallStatus,
                loadingWidget: () {
                  logger.w("API call status: Loading.");
                  return const HomeShimmer();
                },
                errorWidget: () {
                  logger.e("API call status: Error.");
                  return ApiErrorWidget(
                    retryAction: () {
                      logger.i("Retrying API call for user location.");
                      controller.getUserLocation();
                    },
                  );
                },
                successWidget: () {
                  logger.i("API call status: Success. Rendering content.");
                  return ListView(
                    children: [
                      20.verticalSpace,
                      AppTitleComponent(),
                      20.verticalSpace,
                      YourNotificationComponent(
                        onClose: () {
                          logger.i("User closed the notification in HomeView.");
                        },
                      ),
                      Builder(
                        builder: (context) {
                          _startNotificationTimer();
                          return SizedBox.shrink();
                        },
                      ),
                      24.verticalSpace,
                      ElevatedButton(
                        onPressed: _openSpirosDisaster,
                        child: Text('Real-Time Disaster & Routes'),
                      ),
                      24.verticalSpace,
                      ElevatedButton(
                        onPressed: () {
                          logger.i("Reload button pressed.");
                          Get.forceAppUpdate();
                        },
                        child: Text('Reload Screen'),
                      ),
                      24.verticalSpace,
                      SizedBox(
                        height: 170.h,
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              logger.i(
                                  "Carousel page changed to: $index. Reason: $reason.");
                              controller.onCardSlided(index, reason);
                            },
                          ),
                          itemCount: 3,
                          itemBuilder: (context, itemIndex, pageViewIndex) {
                            logger.d("Rendering WeatherCard for index: $itemIndex.");
                            return WeatherCard(weather: controller.currentWeather);
                          },
                        ).animate().fade().slideY(
                          duration: 300.ms,
                          begin: 1,
                          curve: Curves.easeInSine,
                        ),
                      ),
                      24.verticalSpace,
                      CalendarComponent(),
                      16.verticalSpace,
                      GetBuilder<HomeController>(
                        id: controller.dotIndicatorsId,
                        builder: (_) {
                          final activeIndex = controller.activeIndex;
                          logger.d("Rendering dot indicators. Active index: $activeIndex");
                          return Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: activeIndex,
                              count: 3,
                              effect: WormEffect(
                                activeDotColor: theme.primaryColor,
                                dotColor: theme.colorScheme.secondary,
                                dotWidth: 10.w,
                                dotHeight: 10.h,
                              ),
                            ),
                          );
                        },
                      ),
                      24.verticalSpace,
                      Text(
                        Strings.aroundTheWorld.tr,
                        style: theme.textTheme.displayMedium,
                      ).animate().fade().slideX(
                        duration: 300.ms,
                        begin: -1,
                        curve: Curves.easeInSine,
                      ),
                      16.verticalSpace,
                      ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.weatherArroundTheWorld.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) {
                          logger.d(
                              "Rendering WeatherCard for around the world index: $index.");
                          return WeatherCard(
                            weather: controller.weatherArroundTheWorld[index],
                          ).animate(delay: (100 * index).ms).fade().slideY(
                            duration: 300.ms,
                            begin: 1,
                            curve: Curves.easeInSine,
                          );
                        },
                      ),
                      24.verticalSpace,
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
