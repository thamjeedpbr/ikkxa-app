import 'package:flutter/material.dart';

class Config {
  // copy your server url from admin panel
  static String apiServerUrl = "https://new.ikkxa.com/api";
  // copy your api key from admin panel
  static String apiKey = "IKXXAKSAADAMINNOVATION";

  //enter onesignal app id below
  static String oneSignalAppId = "f32f698a-8c87-4e5c-8ecf-c37d33fa1c32";
  // find your ios APP id from app store
  static const String iosAppId = "";
  static const bool enableGoogleLogin = true;
  static const bool enableFacebookLogin = true;
  // if "groceryCartMode = true" then product will be added to cart directly
  static const bool groceryCartMode = true;

  static var supportedLanguageList = [
    const Locale("en", "US"),
    const Locale("bn", "BD"),
    const Locale("ar", "SA"),
  ];
  static const String initialCountrySelection = "US";
}
