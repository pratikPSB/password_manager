import 'package:get/get.dart';

String register = "register";
String login = "login";
String name = "name";
String name_empty_error = "name_empty_error";
String name_validation_error = "name_validation_error";
String email = "email";
String email_empty_error = "email_empty_error";
String email_validation_error = "email_validation_error";
String phone = "phone";
String phone_empty_error = "phone_empty_error";
String phone_validation_error = "phone_validation_error";
String password = "password";
String password_empty_error = "password_empty_error";
String password_validation_error = "password_validation_error";
String confirm_password = "confirm_password";
String confirm_password_validation_error = "confirm_password_validation_error";
String date_of_birth = "date_of_birth";
String dob_empty_error = "dob_empty_error";
String company = "company";
String company_selection_error = "company_selection_error";
String gender = "gender";
String male = "male";
String female = "female";
String others = "others";
String validate_success = "validate_success";
String validate = "validate";
String txt_account_already = "txt_account_already";
String registration_success = "registration_success";
String credentials_invalid = "credentials_invalid";
String home = "home";
String updates = "updates";
String settings = "settings";
String theme = "theme";
String language = "language";
String log_out = "log_out";
String log_out_message = "log_out_message";
String okay = "okay";
String cancel = "cancel";
String posts = "posts";
String txt_sign_in_google = "txt_sign_in_google";

class Strings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "register": "Register",
          "login": "Login",
          "name": "Name",
          "name_empty_error": "name must not be empty.",
          "name_validation_error": "please enter valid name of more then 5 characters.",
          "email": "E-mail",
          "email_empty_error": "e-mail must not be empty.",
          "email_validation_error": "please enter valid email address.",
          "phone": "Phone",
          "phone_empty_error": "phone must not be empty.",
          "phone_validation_error": "please enter valid phone number.",
          "password": "Password",
          "password_empty_error": "password must not be empty.",
          "password_validation_error":
              "password must have 8+ characters & a combo of A-z, a-z, 0-9, #?!@\u0024%^&*-",
          "confirm_password": "Confirm Password",
          "confirm_password_validation_error":
              "password must be exact same which you have entered above.",
          "date_of_birth": "Date of birth",
          "dob_empty_error": "DOB must not be empty.",
          "company": "Company",
          "company_selection_error": "please select company.",
          "gender": "Gender",
          "male": "Male",
          "female": "Female",
          "others": "Others",
          "validate_success": "Validation Successful.",
          "validate": "Validate",
          "txt_account_already": "Already have an account? Login here",
          "registration_success": "Registration success",
          "credentials_invalid": "email or password is invalid.",
          "home": "Home",
          "updates": "Updates",
          "settings": "Settings",
          "theme": "Theme",
          "language": "Language",
          "log_out": "Log out",
          "log_out_message": "Are you sure you want to Log out?",
          "okay": "Okay",
          "cancel": "Cancel",
          "posts": "Posts",
          "txt_sign_in_google": "Sign in with Google",
        },
        'hi_IN': {
          "register": "पंजीकरण करवाना",
          "login": "लॉग इन करें",
          "name": "नाम",
          "name_empty_error": "नाम खाली नहीं होना चाहिए।",
          "name_validation_error": "कृपया अधिक 5 वर्णों का वैध नाम दर्ज करें।",
          "email": "ईमेल",
          "email_empty_error": "ई-मेल खाली नहीं होना चाहिए।",
          "email_validation_error": "कृपया सही ईमेल पता दें।",
          "phone": "फ़ोन",
          "phone_empty_error": "फोन खाली नहीं होना चाहिए।",
          "phone_validation_error": "कृपया एक वैध नंबर डालें।",
          "password": "पासवर्ड",
          "password_empty_error": "पासवर्ड खाली नहीं होना चाहिए।",
          "password_validation_error":
              "पासवर्ड में 8+ वर्ण और A-z, a-z, 0-9, #?!@\u0024%^&*- का कॉम्बो होना चाहिए।",
          "confirm_password": "पासवर्ड की पुष्टि कीजिये",
          "confirm_password_validation_error":
              "पासवर्ड ठीक वैसा ही होना चाहिए जो आपने ऊपर दर्ज किया है।",
          "date_of_birth": "जन्म की तारीख",
          "dob_empty_error": "जन्म की तारीख खाली नहीं होना चाहिए।",
          "company": "कंपनी",
          "company_selection_error": "कृपया कंपनी का चयन करें।",
          "gender": "लिंग",
          "male": "पुरुष",
          "female": "महिला",
          "others": "अन्य",
          "validate_success": "सत्यापन सफल।",
          "validate": "मान्य",
          "txt_account_already": "क्या आपके पास पहले से एक खाता मौजूद है? यहां लॉगिन करें",
          "registration_success": "पंजीकरण सफलता",
          "credentials_invalid": "ईमेल या पासवर्ड अमान्य है।",
          "home": "घर",
          "updates": "अपडेट",
          "settings": "समायोजन",
          "theme": "विषय",
          "language": "भाषा",
          "log_out": "लॉग आउट",
          "log_out_message": "क्या आप लॉग आउट करना चाहते हैं?",
          "okay": "ठीक है",
          "cancel": "रद्द करना",
          "posts": "पोस्ट",
          "txt_sign_in_google": "Sign in with Google",
        }
      };
}
