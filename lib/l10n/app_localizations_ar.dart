// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'ستريت بايت';

  @override
  String get welcomeHeadline => 'الطعام والبقالة يصلك إلى بابك';

  @override
  String get welcomeSubtext => 'أنشئ حسابًا أو سجّل الدخول للبدء';

  @override
  String get signUpButton => 'إنشاء حساب';

  @override
  String get logInButton => 'تسجيل الدخول';

  @override
  String get signUpTitle => 'إنشاء حساب';

  @override
  String get logInTitle => 'مرحبًا بعودتك';

  @override
  String get languageToggle => 'English';

  @override
  String get fullNameLabel => 'الاسم الكامل';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get fullNameRequired => 'الرجاء إدخال الاسم الكامل';

  @override
  String get fullNameCapital => 'يجب أن يبدأ الاسم بحرف كبير';

  @override
  String get emailRequired => 'الرجاء إدخال البريد الإلكتروني';

  @override
  String get emailInvalid => 'الرجاء إدخال بريد إلكتروني صحيح';

  @override
  String get passwordRequired => 'الرجاء إدخال كلمة المرور';

  @override
  String get passwordTooShort => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get confirmPasswordRequired => 'الرجاء تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get signUpSuccessTitle => 'تم إنشاء الحساب';

  @override
  String get signUpSuccessMessage => 'تم إنشاء حسابك بنجاح';

  @override
  String get continueButton => 'متابعة';

  @override
  String get profileTooltip => 'الملف الشخصي';

  @override
  String get biometricReason => 'تحقق من بصمتك لفتح الملف الشخصي';

  @override
  String get biometricFailed => 'لم يتم التعرف على البصمة. حاول مرة أخرى.';

  @override
  String get biometricNotAvailable => 'هذا الجهاز لا يدعم المصادقة بالبصمة.';

  @override
  String get biometricNotEnrolled => 'لا توجد بصمة مسجلة على هذا الجهاز. أضف واحدة من إعدادات الهاتف.';

  @override
  String get biometricLockedOut => 'محاولات كثيرة جدًا. حاول لاحقًا.';

  @override
  String get biometricError => 'حدث خطأ في المصادقة بالبصمة. حاول مرة أخرى.';

  @override
  String get deviceInfoTitle => 'الجهاز';

  @override
  String get deviceModelLabel => 'الطراز';

  @override
  String get osVersionLabel => 'إصدار النظام';

  @override
  String get profileLoadError => 'تعذّر تحميل ملفك الشخصي. حاول مرة أخرى.';

  @override
  String get deviceInfoError => 'تعذّر قراءة معلومات الجهاز.';

  @override
  String get settingsLabel => 'الإعدادات';

  @override
  String get contactUsLabel => 'اتصل بنا';

  @override
  String get helpCenterLabel => 'مركز المساعدة';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get comingSoonMessage => 'هذا القسم سيتوفر قريبًا.';

  @override
  String get okButton => 'حسنًا';

  @override
  String get logOutLabel => 'تسجيل الخروج';

  @override
  String get logOutConfirmMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navBrowse => 'تصفح';

  @override
  String get navOrders => 'الطلبات';

  @override
  String get navProfile => 'حسابي';

  @override
  String get changePhotoTooltip => 'تغيير الصورة';

  @override
  String get photoPickError => 'تعذّر فتح المعرض. حاول مرة أخرى.';

  @override
  String get photoUpdateError => 'تعذّر تحديث صورتك. حاول مرة أخرى.';

  @override
  String get favouritesTitle => 'المفضلة';

  @override
  String get orderHistoryTitle => 'سجل الطلبات';

  @override
  String get noFavourites => 'لا توجد عناصر مفضلة بعد.';

  @override
  String get noOrders => 'لا توجد طلبات بعد.';

  @override
  String get sectionLoadError => 'تعذّر تحميل هذا القسم. حاول مرة أخرى.';

  @override
  String orderTotal(String amount) {
    return 'الإجمالي: $amount';
  }

  @override
  String get deliverTo => 'التوصيل إلى';

  @override
  String get currentLocation => 'الموقع الحالي';

  @override
  String get searchHint => 'طعام، بقالة، إلخ.';

  @override
  String get popularTitle => 'الأكثر شهرة قريبًا منك';

  @override
  String get featuredTitle => 'وجبات مميزة';

  @override
  String get hotOffersTitle => 'عروض ساخنة';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get addedToCart => 'تمت الإضافة إلى السلة';

  @override
  String cartSummary(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'السلة: $count عنصر',
      many: 'السلة: $count عنصرًا',
      few: 'السلة: $count عناصر',
      two: 'السلة: عنصران',
      one: 'السلة: عنصر واحد',
      zero: 'السلة فارغة',
    );
    return '$_temp0';
  }

  @override
  String get loadingMeals => 'جارٍ تحميل الوجبات اللذيذة...';

  @override
  String get loadMealsError => 'تعذر تحميل الوجبات';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noMeals => 'لا توجد وجبات متاحة حاليًا';

  @override
  String get noSearchResults => 'لا توجد وجبات مطابقة لبحثك';

  @override
  String deliveryMinutes(int minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get nearbyVendors => 'بائعون قريبون';

  @override
  String get vendorRating => 'التقييم';

  @override
  String get vendorCuisine => 'نوع المطبخ';

  @override
  String get vendorCity => 'المدينة';

  @override
  String get loadingVendors => 'جارٍ تحميل البائعين...';

  @override
  String get loadVendorsError => 'تعذر تحميل البائعين';

  @override
  String get toggleTheme => 'تبديل السمة';

  @override
  String get currencySymbol => '\$';

  @override
  String mealAddedToCart(String mealName) {
    return 'تمت إضافة $mealName إلى السلة!';
  }

  @override
  String get viewCart => 'عرض السلة';

  @override
  String get preparationInstructions => 'تعليمات التحضير';

  @override
  String get noInstructionsAvailable => 'لا توجد تعليمات مفصلة متاحة.';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String discountPercentOff(int percent) {
    return 'خصم $percent%';
  }

  @override
  String get yourCart => 'سلتك';

  @override
  String get clearCart => 'إفراغ السلة';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cashOnDelivery => 'الدفع عند الاستلام';

  @override
  String get payWhenFoodArrives => 'ادفع عند وصول طلبك';

  @override
  String get creditDebitCard => 'بطاقة ائتمان / خصم';

  @override
  String get fastSecureOnlinePayment => 'دفع سريع وآمن عبر الإنترنت';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get totalAmount => 'المبلغ الإجمالي';

  @override
  String placeOrderWithTotal(String total) {
    return 'تأكيد الطلب • $total';
  }

  @override
  String get yourCartIsEmpty => 'سلتك فارغة';

  @override
  String get emptyCartMessage => 'يبدو أنك لم تضف أي طعام شارع إلى سلتك بعد.';

  @override
  String get exploreMenu => 'استكشف القائمة';

  @override
  String get clearCartConfirmation => 'هل أنت متأكد من رغبتك في إزالة جميع العناصر من سلتك؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'إفراغ';

  @override
  String orderPlacedSuccessfully(String paymentMethod) {
    return 'تم تقديم الطلب بنجاح باستخدام $paymentMethod!';
  }

  @override
  String priceEach(String price) {
    return '$price للوجبة';
  }

  @override
  String get myOrders => 'طلباتي';

  @override
  String get noOrdersYet => 'لا توجد طلبات بعد';

  @override
  String get orderSaveError => 'تعذّر إتمام طلبك. حاول مرة أخرى.';

  @override
  String get noOrdersMessage => 'لم تقم بأي طلب بعد. ابدأ باستكشاف القائمة!';

  @override
  String get startOrdering => 'ابدأ الطلب';

  @override
  String orderNumber(String id) {
    return 'طلب رقم $id';
  }

  @override
  String itemsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عنصر',
      many: '$count عنصرًا',
      few: '$count عناصر',
      two: 'عنصران',
      one: 'عنصر واحد',
      zero: 'لا عناصر',
    );
    return '$_temp0';
  }

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusPreparing => 'قيد التحضير';

  @override
  String get statusOnTheWay => 'في الطريق';

  @override
  String get statusDelivered => 'تم التوصيل';

  @override
  String get statusCancelled => 'ملغي';

  @override
  String get cancelOrder => 'إلغاء الطلب';

  @override
  String get cancelOrderConfirmation => 'هل أنت متأكد من رغبتك في إلغاء هذا الطلب؟';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get addedToFavourites => 'تم الحفظ في المفضلة';

  @override
  String get removedFromFavourites => 'تمت الإزالة من المفضلة';

  @override
  String get favouriteError => 'تعذّر تحديث المفضلة. حاول مرة أخرى.';

  @override
  String itemQuantity(int count) {
    return '×$count';
  }

  @override
  String get authNetworkError => 'لا يوجد اتصال بالإنترنت. تحقق منه وحاول مرة أخرى.';

  @override
  String get authUnknownError => 'حدث خطأ ما. حاول مرة أخرى.';
}
