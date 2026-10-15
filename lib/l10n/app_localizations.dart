import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  String get appName;

  String get welcomeHeadline;

  String get welcomeSubtext;

  String get signUpButton;

  String get logInButton;

  String get signUpTitle;

  String get logInTitle;

  String get languageToggle;

  String get fullNameLabel;

  String get emailLabel;

  String get passwordLabel;

  String get confirmPasswordLabel;

  String get fullNameRequired;

  String get fullNameCapital;

  String get emailRequired;

  String get emailInvalid;

  String get passwordRequired;

  String get passwordTooShort;

  String get confirmPasswordRequired;

  String get passwordsDoNotMatch;

  String get signUpSuccessTitle;

  String get signUpSuccessMessage;

  String get continueButton;

  String homeWelcome(String name);

  String get profileTooltip;

  String get biometricReason;

  String get biometricFailed;

  String get biometricNotAvailable;

  String get biometricNotEnrolled;

  String get biometricLockedOut;

  String get biometricError;

  String get deviceInfoTitle;

  String get deviceModelLabel;

  String get osVersionLabel;

  String get profileLoadError;

  String get deviceInfoError;

  String get retryButton;

  String get settingsLabel;

  String get contactUsLabel;

  String get helpCenterLabel;

  String get languageLabel;

  String get comingSoonMessage;

  String get okButton;

  String get logOutLabel;

  String get logOutConfirmMessage;

  String get cancelButton;

  String get navHome;

  String get navBrowse;

  String get navOrders;

  String get navProfile;

  String get changePhotoTooltip;

  String get photoPickError;

  String get photoUpdateError;

  String get favouritesTitle;

  String get orderHistoryTitle;

  String get noFavourites;

  String get noOrders;

  String get sectionLoadError;

  String orderTotal(String amount);

  String get orderStatusPending;

  String get orderStatusDelivered;

  String get orderStatusCancelled;

  String get deliverTo;

  String get currentLocation;

  String get searchHint;

  String get categoriesTitle;

  String get popularTitle;

  String get featuredTitle;

  String get hotOffersTitle;

  String get viewAll;

  String cartSummary(int count);

  String get loadingMeals;

  String get loadMealsError;

  String get retry;

  String get noMeals;

  String get noSearchResults;

  String discountOff(int percent);

  String deliveryMinutes(int minutes);

  String get nearbyVendors;

  String get vendorRating;

  String get vendorCuisine;

  String get vendorCity;

  String get loadingVendors;

  String get loadVendorsError;

  String get mealDetails;

  String get categoryLabel;

  String get areaLabel;

  String get instructionsLabel;

  String get comingSoonFullDetails;

  String get toggleTheme;

  String get currencySymbol;

  String get selectLanguage;

  String get english;

  String get arabic;

  String addedToCart(String mealName);

  String get viewCart;

  String get preparationInstructions;

  String get noInstructionsAvailable;

  String get addToCart;

  String discountPercentOff(int percent);

  String get yourCart;

  String get clearCart;

  String get paymentMethod;

  String get cashOnDelivery;

  String get payWhenFoodArrives;

  String get creditDebitCard;

  String get fastSecureOnlinePayment;

  String get orderSummary;

  String get subtotal;

  String get deliveryFee;

  String get totalAmount;

  String placeOrderWithTotal(String total);

  String get yourCartIsEmpty;

  String get emptyCartMessage;

  String get exploreMenu;

  String get clearCartConfirmation;

  String get cancel;

  String get clear;

  String orderPlacedSuccessfully(String paymentMethod);

  String priceEach(String price);

  String get myOrders;

  String get noOrdersYet;

  String get noOrdersMessage;

  String get startOrdering;

  String orderNumber(String id);

  String itemsCount(int count);

  String get statusPending;

  String get statusPreparing;

  String get statusOnTheWay;

  String get statusDelivered;

  String get statusCancelled;

  String get cancelOrder;

  String get cancelOrderConfirmation;

  String get yes;

  String get no;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
