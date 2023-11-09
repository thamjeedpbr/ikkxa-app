import 'package:flutter/material.dart';

class Config {
  // copy your server url from admin panel
  static String apiServerUrl = "https://ikkxa.com/api";
  // copy your api key from admin panel
  static String apiKey = "IKXXAKSAADAMINNOVATION";

  //enter onesignal app id below
  static String oneSignalAppId = "";
  // find your ios APP id from app store
  static const String iosAppId = "6469448329";
  static const bool enableGoogleLogin = true;
  static const bool enableFacebookLogin = false;
  // if "groceryCartMode = true" then product will be added to cart directly
  static const bool groceryCartMode = true;

  static var supportedLanguageList = [
    const Locale("en", "US"),
    const Locale("ar", "SA"),
  ];
  static const String initialCountrySelection = "US";
}
