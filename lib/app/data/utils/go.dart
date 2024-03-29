import 'package:get/get.dart';

class Go {
  // Similar to **Navigation.push()**
  static Future<T?> to<T>(dynamic page,
      {dynamic arguments, Transition? transition, bool? opaque}) async {
    return await Get.to<T>(page,
        arguments: arguments,
        transition: transition ?? Transition.rightToLeft,
        duration: const Duration(milliseconds: 300),
        opaque: opaque);
  }

  // Similar to **Navigation.push()**
  static Future<T?> toNamed<T>(dynamic page,
      {dynamic arguments, Transition? transition, bool? opaque}) async {
    return await Get.toNamed<T>(
      page,
      arguments: arguments,
    );
  }

  // Similar to **Navigation.pushReplacement**
  static Future<dynamic> off(dynamic page, {dynamic arguments, Transition? transition}) async {
    Get.off(
      page,
      arguments: arguments,
      transition: transition ?? Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Similar to **Navigator.pushReplacementNamed**
  static Future<dynamic> offNamed(String? page, {dynamic arguments}) async {
    Get.offNamed(
      page!,
      arguments: arguments,
      preventDuplicates: true,
    );
  }

  // Similar to **Navigator.pushReplacementNamed**
  static Future<dynamic> offAllNamed(String? page, {dynamic arguments}) async {
    Get.offAllNamed(
      page!,
      arguments: arguments,
    );
  }

  // Similar to **Navigation.pushAndRemoveUntil()**
  static Future<dynamic> offUntil(dynamic page, {Transition? transition}) async {
    Get.offUntil(
        GetPageRoute(
          page: page,
          transition: transition ?? Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        (route) => false);
  }
}
