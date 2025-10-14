// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get name => 'الاسم';

  @override
  String get pleaseEnterYourName => 'من فضلك أدخل اسمك';

  @override
  String get nameMustBeAtLeast3Characters =>
      'يجب أن يكون الاسم على الأقل 3 أحرف';

  @override
  String get nameCanOnlyContainLetters =>
      'الاسم يمكن أن يحتوي فقط على أحرف ومسافات';

  @override
  String get pleaseEnterYourEmail => 'من فضلك أدخل بريدك الإلكتروني';

  @override
  String get enterValidEmail => 'أدخل بريد إلكتروني صحيح';

  @override
  String get pleaseEnterYourPassword => 'من فضلك أدخل كلمة المرور';

  @override
  String get passwordMustBe8Characters =>
      'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل';

  @override
  String get passwordMustContainUppercase =>
      'يجب أن تحتوي كلمة المرور\nعلى حرف كبير واحد ورقم واحد على الأقل';

  @override
  String get pleaseConfirmYourPassword => 'من فضلك أكد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get pleaseEnterPhoneNumber => 'من فضلك أدخل رقم الهاتف';

  @override
  String get enterValidPhoneNumber => 'أدخل رقم هاتف صحيح';

  @override
  String get pleaseEnterAddress => 'من فضلك أدخل العنوان';

  @override
  String get addressMustBe5Characters => 'يجب أن يكون العنوان 5 أحرف على الأقل';

  @override
  String get addressContainsInvalidCharacters =>
      'العنوان يحتوي على رموز غير صالحة';

  @override
  String get addClientLocation => 'إضافة موقع العميل';

  @override
  String get customers => 'العملاء';

  @override
  String get english => 'الإنجليزية';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get chooseYourLanguage => 'اختر لغتك';

  @override
  String get arabic => 'العربية';

  @override
  String get noUserSignedIn => 'لا يوجد مستخدم مسجل دخول';

  @override
  String get passwordChangedSuccessfully => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get errorChangingPassword => 'حدث خطأ أثناء تغيير كلمة المرور';

  @override
  String get oldPasswordIncorrect => 'كلمة المرور القديمة غير صحيحة';

  @override
  String get newPasswordTooWeak => 'كلمة المرور الجديدة ضعيفة جدًا';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get oldPassword => 'كلمة المرور القديمة';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get clientNotFound => 'العميل غير موجود';

  @override
  String get errorLoadingClient => 'حدث خطأ أثناء تحميل بيانات العميل';

  @override
  String get locationServicesDisabled => 'خدمات الموقع معطلة';

  @override
  String get locationPermissionDenied => 'تم رفض إذن الموقع';

  @override
  String get locationPermissionPermanentlyDenied => 'تم رفض إذن الموقع نهائيًا';

  @override
  String get noLocationAvailable => 'لا يوجد موقع متاح';

  @override
  String get couldNotOpenGoogleMaps => 'تعذر فتح خرائط جوجل';

  @override
  String get clientDetails => 'تفاصيل العميل';

  @override
  String get updateLocation => 'تحديث الموقع';

  @override
  String get save => 'حفظ';

  @override
  String get password => 'كلمة المرور';

  @override
  String get viewOnlyAdmins =>
      'وضع العرض فقط: يمكن للمسؤولين فقط تعديل تفاصيل العميل.';

  @override
  String get viewOnlyAdminsOr12Hours =>
      'وضع العرض فقط: يمكن للمسؤولين فقط أو خلال 12 ساعة من الإنشاء التعديل.';

  @override
  String get userNotFound => 'المستخدم غير موجود';

  @override
  String get errorLoadingUserData => 'حدث خطأ أثناء تحميل بيانات المستخدم';

  @override
  String get profileUpdatedSuccessfully => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get errorUpdatingProfile => 'حدث خطأ أثناء تحديث الملف الشخصي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get welcome => 'مرحبًا';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get forgetYourPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get send => 'إرسال';

  @override
  String get passwordResetEmailSent => 'تم إرسال بريد إعادة تعيين كلمة المرور.';

  @override
  String get noUserFoundForThatEmail =>
      'لم يتم العثور على مستخدم لهذا البريد الإلكتروني.';

  @override
  String get home => 'الصفحة الرئيسية';

  @override
  String get settings => 'الإعدادات';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get createAccount => 'إنشاء حساب جديد';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get areYouSureLogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get yes => 'نعم';

  @override
  String get getCurrentLocation => 'الحصول على الموقع الحالي';

  @override
  String get clientAddedSuccessfully => 'تمت إضافة العميل بنجاح';

  @override
  String get errorOccured => 'حدث خطأ ما';

  @override
  String get searchAgents => 'ابحث عن المناديب بالاسم أو الهاتف...';

  @override
  String get searchClients => 'ابحث عن العملاء بالاسم أو الهاتف...';

  @override
  String get noClientsYet => 'لا يوجد عملاء بعد';

  @override
  String get loginSuccessful => 'تم تسجيل الدخول بنجاح';

  @override
  String get wrongPassword => 'كلمة المرور غير صحيحة';

  @override
  String get invalidEmailFormat => 'صيغة البريد الإلكتروني غير صحيحة';

  @override
  String get userDisabled => 'تم تعطيل هذا الحساب';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع';

  @override
  String get signUpSuccessful => 'تم إنشاء الحساب بنجاح';

  @override
  String get weakPassword => 'كلمة المرور ضعيفة جدًا';

  @override
  String get emailAlreadyInUse => 'يوجد حساب مسجل بهذا البريد الإلكتروني';

  @override
  String get enterYourName => 'أدخل اسمك';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterPhoneNumber => 'أدخل رقم الهاتف';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get forgetPassword => 'نسيت كلمة المرور؟';

  @override
  String get anErrorOccurred => 'حدث خطأ';

  @override
  String get invalidCredential => 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';

  @override
  String get unknownError => 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.';

  @override
  String get clientDeletedSuccessfully => 'تم حذف العميل بنجاح';

  @override
  String get undo => 'تراجع';

  @override
  String get clientRestored => 'تم استعادة العميل';

  @override
  String get errorRestoringClient => 'حدث خطأ أثناء استعادة العميل';

  @override
  String get errorDeletingClient => 'حدث خطأ أثناء حذف العميل';

  @override
  String get clientUpdatedSuccessfully => 'تم تحديث بيانات العميل بنجاح';

  @override
  String get pleaseGetCurrentLocationFirst =>
      'يرجى الحصول على الموقع الحالي أولاً';

  @override
  String get clientName => 'اسم العميل';

  @override
  String get clientPhone => 'رقم العميل';

  @override
  String get clientAddress => 'عنوان العميل';

  @override
  String get address => 'العنوان';

  @override
  String get addClient => 'إضافة عميل';

  @override
  String get noPermissionToEdit => 'ليس لديك صلاحية للتعديل';
}
