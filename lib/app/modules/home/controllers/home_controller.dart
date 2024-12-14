import 'package:get/get.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../../config/translations/localization_service.dart';
import '../../../../utils/constants.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/weather_model.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../services/location_service.dart';
import '../views/widgets/location_dialog.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // get the current language code
  var currentLanguage = LocalizationService.getCurrentLocal().languageCode;

  // hold current weather data
  late WeatherModel currentWeather;

  // hold the weather around the world
  List<WeatherModel> weatherArroundTheWorld = [];

  // for update
  final dotIndicatorsId = 'DotIndicators';
  final themeId = 'Theme';

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.loading;

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for weather slider and dot indicator
  var activeIndex = 1;

  // Observable for the notification message
  var notificationMessage = ''.obs;

  @override
  void onInit() async {
    if (!await LocationService().hasLocationPermission()) {
      Get.dialog(const LocationDialog());
    } else {
      getUserLocation();
    }
    super.onInit();
  }

  /// Get the user location
  getUserLocation() async {
    var locationData = await LocationService().getUserLocation();
    if (locationData != null) {
      await getCurrentWeather('${locationData.latitude},${locationData.longitude}');
    }
  }

  /// Get current weather data
  getCurrentWeather(String location) async {
    await BaseClient.safeApiCall(
      Constants.currentWeatherApiUrl,
      RequestType.get,
      queryParameters: {
        Constants.key: Constants.mApiKey,
        Constants.q: location,
        Constants.lang: currentLanguage,
      },
      onSuccess: (response) async {
        currentWeather = WeatherModel.fromJson(response.data);
        await getWeatherArroundTheWorld();
        apiCallStatus = ApiCallStatus.success;
        showNotification('Weather data fetched successfully!');
        update();
      },
      onError: (error) {
        BaseClient.handleApiError(error);
        apiCallStatus = ApiCallStatus.error;
        showNotification('Failed to fetch weather data!');
        update();
      },
    );
  }

  /// Get weather around the world
  getWeatherArroundTheWorld() async {
    weatherArroundTheWorld.clear();
    final cities = ['London', 'Cairo', 'Alaska'];
    await Future.forEach(cities, (city) {
      BaseClient.safeApiCall(
        Constants.currentWeatherApiUrl,
        RequestType.get,
        queryParameters: {
          Constants.key: Constants.mApiKey,
          Constants.q: city,
          Constants.lang: currentLanguage,
        },
        onSuccess: (response) {
          weatherArroundTheWorld.add(WeatherModel.fromJson(response.data));
          update();
        },
        onError: (error) => BaseClient.handleApiError(error),
      );
    });
  }

  /// Show notification with a custom message
  void showNotification(String message) {
    notificationMessage.value = message;
    // Optionally, hide the notification after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      notificationMessage.value = 'Attention! High temperatures will occur during the day, it is suggested you avoid sun during 12:00 - 16:00! Prepare the watering during early hours. '; // Clear the notification after 3 seconds
    });
  }

  /// When the user slides the weather card
  onCardSlided(index, reason) {
    activeIndex = index;
    update([dotIndicatorsId]);
  }

  /// When the user presses on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update([themeId]);
  }

  /// When the user presses on change language icon
  onChangeLanguagePressed() async {
    currentLanguage = currentLanguage == 'ar' ? 'en' : 'ar';
    await LocalizationService.updateLanguage(currentLanguage);
    apiCallStatus = ApiCallStatus.loading;
    update();
    await getUserLocation();
  }
}
