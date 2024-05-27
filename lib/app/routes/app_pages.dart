import 'package:get/get.dart';

import '../modules/home/create_vault/create_vault_binding.dart';
import '../modules/home/create_vault/create_vault_view.dart';
import '../modules/home/generate_card_credentials/generate_card_credentials_binding.dart';
import '../modules/home/generate_card_credentials/generate_card_credentials_view.dart';
import '../modules/home/generate_credentials/generate_credentials_binding.dart';
import '../modules/home/generate_credentials/generate_credentials_view.dart';
import '../modules/home/generate_note/generate_note_binding.dart';
import '../modules/home/generate_note/generate_note_view.dart';
import '../modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_binding.dart';
import '../modules/home/generate_password_bottom_sheet/generate_password_bottom_sheet_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/home/select_vault_bottom_sheet/select_vault_bottom_sheet_binding.dart';
import '../modules/home/select_vault_bottom_sheet/select_vault_bottom_sheet_view.dart';
import '../modules/loginModule/login/login_binding.dart';
import '../modules/loginModule/login/login_view.dart';
import '../modules/loginModule/login_or_register/login_or_register_binding.dart';
import '../modules/loginModule/login_or_register/login_or_register_view.dart';
import '../modules/loginModule/register/register_binding.dart';
import '../modules/loginModule/register/register_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      bindings: [
        HomeBinding(),
        SelectVaultBottomSheetBinding(),
        GeneratePasswordBottomSheetBinding(),
      ],
      transition: Transition.rightToLeft,
      children: [
        GetPage(
          name: _Paths.GENERATE_PASSWORD_BOTTOM_SHEET,
          page: () => const GeneratePasswordBottomSheetView(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: _Paths.SELECT_VAULT_BOTTOM_SHEET,
          page: () => const SelectVaultBottomSheetView(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: _Paths.GENERATE_CREDENTIALS,
          page: () => const GenerateCredentialsView(),
          binding: GenerateCredentialsBinding(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: _Paths.GENERATE_CARD_CREDENTIALS,
          page: () => const GenerateCardCredentialsView(),
          binding: GenerateCardCredentialsBinding(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: _Paths.GENERATE_NOTE,
          page: () => const GenerateNoteView(),
          binding: GenerateNoteBinding(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: _Paths.CREATE_VAULT,
          page: () => const CreateVaultView(),
          binding: CreateVaultBinding(),
          transition: Transition.downToUp,
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.LOGIN_OR_REGISTER,
      page: () => const LoginOrRegisterView(),
      binding: LoginOrRegisterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
