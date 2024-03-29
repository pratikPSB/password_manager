import 'package:get/get.dart';
import 'package:password_manager/app/data/utils/extensions.dart';
import 'package:password_manager/app/data/utils/go.dart';
import 'package:password_manager/app/routes/app_pages.dart';

class LoginOrRegisterController extends GetxController {
  openLogin() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 1000), () => 42);
    return () {
      Go.toNamed(Routes.LOGIN);
      // Fluttertoast.showToast(msg: "clicked", toastLength: Toast.LENGTH_SHORT);
    };
  }

  openRegister() async {
    performHapticFeedback();
    await Future.delayed(const Duration(milliseconds: 1000), () => 42);
    return () {
      Go.toNamed(Routes.REGISTER);
      // Fluttertoast.showToast(msg: "clicked", toastLength: Toast.LENGTH_SHORT);
    };
  }
}
