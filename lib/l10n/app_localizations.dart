import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'StreetBite'**
  String get appName;

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Food and groceries delivered to you'**
  String get welcomeHeadline;

  /// No description provided for @welcomeSubtext.
  ///
  /// In en, this message translates to:
  /// **'Create an account or log in to get started'**
  String get welcomeSubtext;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @logInButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logInButton;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpTitle;

  /// No description provided for @logInTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get logInTitle;

  /// No description provided for @languageToggle.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageToggle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullNameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get fullNameRequired;

  /// No description provided for @fullNameCapital.
  ///
  /// In en, this message translates to:
  /// **'The name must start with a capital letter'**
  String get fullNameCapital;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @signUpSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Account created'**
  String get signUpSuccessTitle;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account was created successfully'**
  String get signUpSuccessMessage;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @profileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTooltip;

  /// No description provided for @biometricReason.
  ///
  /// In en, this message translates to:
  /// **'Verify your fingerprint to open your profile'**
  String get biometricReason;

  /// No description provided for @biometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Fingerprint not recognized. Please try again.'**
  String get biometricFailed;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'This device doesn\'t support fingerprint authentication.'**
  String get biometricNotAvailable;

  /// No description provided for @biometricNotEnrolled.
  ///
  /// In en, this message translates to:
  /// **'No fingerprint is set up on this device. Add one in your phone settings.'**
  String get biometricNotEnrolled;

  /// No description provided for @biometricLockedOut.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get biometricLockedOut;

  /// No description provided for @biometricError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong with fingerprint authentication. Please try again.'**
  String get biometricError;

  /// No description provided for @deviceInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get deviceInfoTitle;

  /// No description provided for @deviceModelLabel.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get deviceModelLabel;

  /// No description provided for @osVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'OS version'**
  String get osVersionLabel;

  /// No description provided for @profileLoadError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load your profile. Please try again.'**
  String get profileLoadError;

  /// No description provided for @deviceInfoError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read your device details.'**
  String get deviceInfoError;

  /// No description provided for @settingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsLabel;

  /// No description provided for @contactUsLabel.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUsLabel;

  /// No description provided for @helpCenterLabel.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get helpCenterLabel;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'This section is coming soon.'**
  String get comingSoonMessage;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @logOutLabel.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOutLabel;

  /// No description provided for @logOutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logOutConfirmMessage;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get navBrowse;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @changePhotoTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhotoTooltip;

  /// No description provided for @photoPickError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t open your gallery. Please try again.'**
  String get photoPickError;

  /// No description provided for @photoUpdateError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t update your photo. Please try again.'**
  String get photoUpdateError;

  /// No description provided for @favouritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favouritesTitle;

  /// No description provided for @orderHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get orderHistoryTitle;

  /// No description provided for @noFavourites.
  ///
  /// In en, this message translates to:
  /// **'You have no favourites yet.'**
  String get noFavourites;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'You have no orders yet.'**
  String get noOrders;

  /// No description provided for @sectionLoadError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this section. Please try again.'**
  String get sectionLoadError;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Total: {amount}'**
  String orderTotal(String amount);

  /// No description provided for @deliverTo.
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliverTo;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get currentLocation;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Food, groceries, etc.'**
  String get searchHint;

  /// No description provided for @popularTitle.
  ///
  /// In en, this message translates to:
  /// **'Popular Near You'**
  String get popularTitle;

  /// No description provided for @featuredTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Meals'**
  String get featuredTitle;

  /// No description provided for @hotOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Hot Offers'**
  String get hotOffersTitle;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added to cart'**
  String get addedToCart;

  /// No description provided for @cartSummary.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Cart is empty} =1{Cart: 1 item} other{Cart: {count} items}}'**
  String cartSummary(int count);

  /// No description provided for @loadingMeals.
  ///
  /// In en, this message translates to:
  /// **'Loading delicious meals...'**
  String get loadingMeals;

  /// No description provided for @loadMealsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load meals'**
  String get loadMealsError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noMeals.
  ///
  /// In en, this message translates to:
  /// **'No meals available right now'**
  String get noMeals;

  /// No description provided for @noSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No meals match your search'**
  String get noSearchResults;

  /// No description provided for @deliveryMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String deliveryMinutes(int minutes);

  /// No description provided for @nearbyVendors.
  ///
  /// In en, this message translates to:
  /// **'Nearby Vendors'**
  String get nearbyVendors;

  /// No description provided for @vendorRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get vendorRating;

  /// No description provided for @vendorCuisine.
  ///
  /// In en, this message translates to:
  /// **'Cuisine'**
  String get vendorCuisine;

  /// No description provided for @vendorCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get vendorCity;

  /// No description provided for @loadingVendors.
  ///
  /// In en, this message translates to:
  /// **'Loading vendors...'**
  String get loadingVendors;

  /// No description provided for @loadVendorsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load vendors'**
  String get loadVendorsError;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle theme'**
  String get toggleTheme;

  /// No description provided for @currencySymbol.
  ///
  /// In en, this message translates to:
  /// **'\$'**
  String get currencySymbol;

  /// No description provided for @mealAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'{mealName} added to cart!'**
  String mealAddedToCart(String mealName);

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get viewCart;

  /// No description provided for @preparationInstructions.
  ///
  /// In en, this message translates to:
  /// **'Preparation Instructions'**
  String get preparationInstructions;

  /// No description provided for @noInstructionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No detailed instructions available.'**
  String get noInstructionsAvailable;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @discountPercentOff.
  ///
  /// In en, this message translates to:
  /// **'{percent}% OFF'**
  String discountPercentOff(int percent);

  /// No description provided for @yourCart.
  ///
  /// In en, this message translates to:
  /// **'Your Cart'**
  String get yourCart;

  /// No description provided for @clearCart.
  ///
  /// In en, this message translates to:
  /// **'Clear Cart'**
  String get clearCart;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @payWhenFoodArrives.
  ///
  /// In en, this message translates to:
  /// **'Pay when your food arrives'**
  String get payWhenFoodArrives;

  /// No description provided for @creditDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Credit / Debit Card'**
  String get creditDebitCard;

  /// No description provided for @fastSecureOnlinePayment.
  ///
  /// In en, this message translates to:
  /// **'Fast & secure online payment'**
  String get fastSecureOnlinePayment;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @placeOrderWithTotal.
  ///
  /// In en, this message translates to:
  /// **'Place Order • {total}'**
  String placeOrderWithTotal(String total);

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// No description provided for @emptyCartMessage.
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added any street food to your cart yet.'**
  String get emptyCartMessage;

  /// No description provided for @exploreMenu.
  ///
  /// In en, this message translates to:
  /// **'Explore Menu'**
  String get exploreMenu;

  /// No description provided for @clearCartConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items from your cart?'**
  String get clearCartConfirmation;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully using {paymentMethod}!'**
  String orderPlacedSuccessfully(String paymentMethod);

  /// No description provided for @priceEach.
  ///
  /// In en, this message translates to:
  /// **'{price} each'**
  String priceEach(String price);

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet'**
  String get noOrdersYet;

  /// No description provided for @orderSaveError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t place your order. Please try again.'**
  String get orderSaveError;

  /// No description provided for @noOrdersMessage.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t placed any orders yet. Start exploring the menu!'**
  String get noOrdersMessage;

  /// No description provided for @startOrdering.
  ///
  /// In en, this message translates to:
  /// **'Start Ordering'**
  String get startOrdering;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String orderNumber(String id);

  /// No description provided for @itemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No items} =1{1 item} other{{count} items}}'**
  String itemsCount(int count);

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get statusPreparing;

  /// No description provided for @statusOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'On the way'**
  String get statusOnTheWay;

  /// No description provided for @statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get statusDelivered;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @cancelOrderConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get cancelOrderConfirmation;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @addedToFavourites.
  ///
  /// In en, this message translates to:
  /// **'Saved to favourites'**
  String get addedToFavourites;

  /// No description provided for @removedFromFavourites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favourites'**
  String get removedFromFavourites;

  /// No description provided for @favouriteError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update favourites. Please try again.'**
  String get favouriteError;

  /// No description provided for @itemQuantity.
  ///
  /// In en, this message translates to:
  /// **'×{count}'**
  String itemQuantity(int count);

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check it and try again.'**
  String get authNetworkError;

  /// No description provided for @authUnknownError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authUnknownError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
