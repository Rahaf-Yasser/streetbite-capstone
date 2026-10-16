// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'StreetBite';

  @override
  String get welcomeHeadline => 'Food and groceries delivered to you';

  @override
  String get welcomeSubtext => 'Create an account or log in to get started';

  @override
  String get signUpButton => 'Sign Up';

  @override
  String get logInButton => 'Log In';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get logInTitle => 'Welcome back';

  @override
  String get languageToggle => 'العربية';

  @override
  String get fullNameLabel => 'Full name';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get fullNameRequired => 'Please enter your full name';

  @override
  String get fullNameCapital => 'The name must start with a capital letter';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordRequired => 'Please enter a password';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get signUpSuccessTitle => 'Account created';

  @override
  String get signUpSuccessMessage => 'Your account was created successfully';

  @override
  String get continueButton => 'Continue';

  @override
  String get profileTooltip => 'Profile';

  @override
  String get biometricReason => 'Verify your fingerprint to open your profile';

  @override
  String get biometricFailed => 'Fingerprint not recognized. Please try again.';

  @override
  String get biometricNotAvailable => 'This device doesn\'t support fingerprint authentication.';

  @override
  String get biometricNotEnrolled => 'No fingerprint is set up on this device. Add one in your phone settings.';

  @override
  String get biometricLockedOut => 'Too many attempts. Please try again later.';

  @override
  String get biometricError => 'Something went wrong with fingerprint authentication. Please try again.';

  @override
  String get deviceInfoTitle => 'Device';

  @override
  String get deviceModelLabel => 'Model';

  @override
  String get osVersionLabel => 'OS version';

  @override
  String get profileLoadError => 'We couldn\'t load your profile. Please try again.';

  @override
  String get deviceInfoError => 'We couldn\'t read your device details.';

  @override
  String get settingsLabel => 'Settings';

  @override
  String get contactUsLabel => 'Contact us';

  @override
  String get helpCenterLabel => 'Help center';

  @override
  String get languageLabel => 'Language';

  @override
  String get comingSoonMessage => 'This section is coming soon.';

  @override
  String get okButton => 'OK';

  @override
  String get logOutLabel => 'Log out';

  @override
  String get logOutConfirmMessage => 'Are you sure you want to log out?';

  @override
  String get navHome => 'Home';

  @override
  String get navBrowse => 'Browse';

  @override
  String get navOrders => 'Orders';

  @override
  String get navProfile => 'Profile';

  @override
  String get changePhotoTooltip => 'Change photo';

  @override
  String get photoPickError => 'We couldn\'t open your gallery. Please try again.';

  @override
  String get photoUpdateError => 'We couldn\'t update your photo. Please try again.';

  @override
  String get favouritesTitle => 'Favourites';

  @override
  String get orderHistoryTitle => 'Order history';

  @override
  String get noFavourites => 'You have no favourites yet.';

  @override
  String get noOrders => 'You have no orders yet.';

  @override
  String get sectionLoadError => 'We couldn\'t load this section. Please try again.';

  @override
  String orderTotal(String amount) {
    return 'Total: $amount';
  }

  @override
  String get deliverTo => 'Deliver to';

  @override
  String get currentLocation => 'Current Location';

  @override
  String get searchHint => 'Food, groceries, etc.';

  @override
  String get popularTitle => 'Popular Near You';

  @override
  String get featuredTitle => 'Featured Meals';

  @override
  String get hotOffersTitle => 'Hot Offers';

  @override
  String get viewAll => 'View all';

  @override
  String get addedToCart => 'Added to cart';

  @override
  String cartSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Cart: $count items',
      one: 'Cart: 1 item',
      zero: 'Cart is empty',
    );
    return '$_temp0';
  }

  @override
  String get loadingMeals => 'Loading delicious meals...';

  @override
  String get loadMealsError => 'Failed to load meals';

  @override
  String get retry => 'Retry';

  @override
  String get noMeals => 'No meals available right now';

  @override
  String get noSearchResults => 'No meals match your search';

  @override
  String deliveryMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get nearbyVendors => 'Nearby Vendors';

  @override
  String get vendorRating => 'Rating';

  @override
  String get vendorCuisine => 'Cuisine';

  @override
  String get vendorCity => 'City';

  @override
  String get loadingVendors => 'Loading vendors...';

  @override
  String get loadVendorsError => 'Failed to load vendors';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get currencySymbol => '\$';

  @override
  String mealAddedToCart(String mealName) {
    return '$mealName added to cart!';
  }

  @override
  String get viewCart => 'View cart';

  @override
  String get preparationInstructions => 'Preparation Instructions';

  @override
  String get noInstructionsAvailable => 'No detailed instructions available.';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String discountPercentOff(int percent) {
    return '$percent% OFF';
  }

  @override
  String get yourCart => 'Your Cart';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get cashOnDelivery => 'Cash on Delivery';

  @override
  String get payWhenFoodArrives => 'Pay when your food arrives';

  @override
  String get creditDebitCard => 'Credit / Debit Card';

  @override
  String get fastSecureOnlinePayment => 'Fast & secure online payment';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String placeOrderWithTotal(String total) {
    return 'Place Order • $total';
  }

  @override
  String get yourCartIsEmpty => 'Your cart is empty';

  @override
  String get emptyCartMessage => 'Looks like you haven\'t added any street food to your cart yet.';

  @override
  String get exploreMenu => 'Explore Menu';

  @override
  String get clearCartConfirmation => 'Are you sure you want to remove all items from your cart?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String orderPlacedSuccessfully(String paymentMethod) {
    return 'Order placed successfully using $paymentMethod!';
  }

  @override
  String priceEach(String price) {
    return '$price each';
  }

  @override
  String get myOrders => 'My Orders';

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get orderSaveError => 'We couldn\'t place your order. Please try again.';

  @override
  String get noOrdersMessage => 'You haven\'t placed any orders yet. Start exploring the menu!';

  @override
  String get startOrdering => 'Start Ordering';

  @override
  String orderNumber(String id) {
    return 'Order #$id';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'No items',
    );
    return '$_temp0';
  }

  @override
  String get statusPending => 'Pending';

  @override
  String get statusPreparing => 'Preparing';

  @override
  String get statusOnTheWay => 'On the way';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get cancelOrder => 'Cancel Order';

  @override
  String get cancelOrderConfirmation => 'Are you sure you want to cancel this order?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get addedToFavourites => 'Saved to favourites';

  @override
  String get removedFromFavourites => 'Removed from favourites';

  @override
  String get favouriteError => 'Couldn\'t update favourites. Please try again.';

  @override
  String itemQuantity(int count) {
    return '×$count';
  }

  @override
  String get authNetworkError => 'No internet connection. Please check it and try again.';

  @override
  String get authUnknownError => 'Something went wrong. Please try again.';
}
