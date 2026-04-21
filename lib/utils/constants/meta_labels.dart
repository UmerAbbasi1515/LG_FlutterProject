import '../../data/helpers/session_controller.dart';

class AppMetaLabels {
  ///////////////////////////////
  /// Get Otp Screen Labels Testing
  ///////////////////////////////
  ///
  ///

  String choose =
      SessionController().getLanguage() == 1 ? "CHOOSE" : "نتخب کریں";
  String language =
      SessionController().getLanguage() == 1 ? "Language" : "زبان";
  String login = SessionController().getLanguage() == 1 ? "Login" : 'لاگ ان';
  String oneTimePassword = SessionController().getLanguage() == 1
      ? "An OTP will be sent to your registered mobile number"
      : "آپ کے رجسٹرڈ موبائل نمبر پر ایک OTP بھیجا جائے گا۔";
  String mobileNumber =
      SessionController().getLanguage() == 1 ? "Mobile Number" : "موبائل نمبر";
  String validatingUser = SessionController().getLanguage() == 1
      ? 'Validating User'
      : "صارف کی توثیق کر رہا ہے۔";
  String getOTP =
      SessionController().getLanguage() == 1 ? "Generate OTP" : "OTP بنائیں";
  String cancel =
      SessionController().getLanguage() == 1 ? "Cancel" : "منسوخ کریں۔";
  String sureToExit = SessionController().getLanguage() == 1
      ? "Are you sure you want to exit the app?"
      : "کیا آپ واقعی ایپ سے باہر نکلنا چاہتے ہیں؟";
  String yes = SessionController().getLanguage() == 1 ? 'Yes' : 'جی ہاں';
  String no = SessionController().getLanguage() == 1 ? 'No' : 'نہیں';
  String error = SessionController().getLanguage() == 1 ? 'Error' : 'خرابی';
  String invalidPhoneNumber = SessionController().getLanguage() == 1
      ? 'Invalid Mobile Number'
      : 'غلط موبائل نمبر';
  String pleaseEnterMobileNo = SessionController().getLanguage() == 1
      ? 'Please enter your phone number'
      : 'براہ کرم اپنا فون نمبر درج کریں۔';
  String password =
      SessionController().getLanguage() == 1 ? 'Password' : 'پاس ورڈ';
  String passwordDoNotMatch = SessionController().getLanguage() == 1
      ? 'Passwords do not match'
      : 'پاس ورڈز مماثل نہیں ہیں۔';
  String confirmPasswordRequired = SessionController().getLanguage() == 1
      ? '"Confirm password required"'
      : "پاس ورڈ کی ضرورت کی تصدیق کریں";
  String invalidResponse =
      SessionController().getLanguage() == 1 ? 'Invalid Response' : 'غلط جواب';
  String appName = SessionController().getLanguage() == 1
      ? 'Local Governmnet Project'
      : 'لوکل گورنمنٹ پروجیکٹ';
  String totalProjects =
      SessionController().getLanguage() == 1 ? 'Total Projects' : 'کل منصوبے';
  String projects =
      SessionController().getLanguage() == 1 ? 'Projects' : 'منصوبے';
  String selectyear =
      SessionController().getLanguage() == 1 ? 'Select Year' : 'سال منتخب کریں';
  String confirmPassword = SessionController().getLanguage() == 1
      ? 'Confirm Password'
      : 'پاس ورڈ کی تصدیق کریں';
  String pleaseenterPassword = SessionController().getLanguage() == 1
      ? "Please enter Password"
      : "براہ کرم پاس ورڈ درج کریں";
  String pleaseenterPasswordwithMobile = SessionController().getLanguage() == 1
      ? "Please enter your password for this phone number "
      : "براہ کرم اس فون نمبر کے لیے اپنا پاس ورڈ درج کریں";
  String passwordMustbe8Char = SessionController().getLanguage() == 1
      ? "Password must be at least 8 characters."
      : "پاس ورڈ کم از کم 8 حروف پر مشتمل ہونا چاہیے";
  String passwordMContainOneNumericVal = SessionController().getLanguage() == 1
      ? "Password must contain at least one numeric value."
      : "پاس ورڈ میں کم از کم ایک عددی قدر ہونی چاہیے";
  String passwordMContainOneAlphaNumericVal =
      SessionController().getLanguage() == 1
          ? "Password must contain at least one non-alphanumeric character."
          : "پاس ورڈ میں کم از کم ایک غیر حرفی عددی حرف ہونا چاہیے";
  String passwordMContainOneCapSmaAlpha = SessionController().getLanguage() == 1
      ? "Password must contain at least one small & one capital character"
      : "پاس ورڈ میں کم از کم ایک چھوٹا اور ایک بڑا حرف ہونا چاہیے";
  String savePassword = SessionController().getLanguage() == 1
      ? "Save Password"
      : "پاس ورڈ محفوظ کریں";
  String set = SessionController().getLanguage() == 1 ? ' Set' : 'سیٹ کریں';
  String reset =
      SessionController().getLanguage() == 1 ? "Reset " : 'ری سیٹ کریں';
  String someThingWentWrong = SessionController().getLanguage() == 1
      ? "Something went wrong"
      : 'کچھ غلط ہو گیا';
  String tokenGenerationFailedN = SessionController().getLanguage() == 1
      ? "Token generation failed,Please try again later / contact with support team"
      : 'ٹوکن بنانے میں ناکامی ہوئی، براہ کرم بعد میں دوبارہ کوشش کریں یا سپورٹ ٹیم سے رابطہ کریں';
  String loading = SessionController().getLanguage() == 1
      ? 'Loading...'
      : 'لوڈ ہو رہا ہے...';
  String userDataNotFound = SessionController().getLanguage() == 1
      ? 'User data not found'
      : 'صارف کا ڈیٹا نہیں ملا';
  String otpVerification = SessionController().getLanguage() == 1
      ? "OTP Verification"
      : 'او ٹی پی تصدیق';

  String verificationComplete = SessionController().getLanguage() == 1
      ? "Verification Complete"
      : 'تصدیق مکمل ہو گئی';

  String verifyingOtp = SessionController().getLanguage() == 1
      ? "Verifying OTP"
      : 'او ٹی پی کی تصدیق ہو رہی ہے';

  String processingError = SessionController().getLanguage() == 1
      ? 'Processing Error'
      : 'پروسیسنگ میں خرابی';
  String enterTheCode = SessionController().getLanguage() == 1
      ? "Enter the code that was sent to"
      : "وہ کوڈ درج کریں جو بھیجا گیا تھا";

  String didnotrecieve = SessionController().getLanguage() == 1
      ? "Didn't receive the OTP code?"
      : "او ٹی پی کوڈ موصول نہیں ہوا؟";

  String resentOtp = SessionController().getLanguage() == 1
      ? "Resend OTP"
      : "او ٹی پی دوبارہ بھیجیں";

  String otpExpired = SessionController().getLanguage() == 1
      ? "OTP has expired"
      : "او ٹی پی کی میعاد ختم ہو گئی";

  String invalidOTP =
      SessionController().getLanguage() == 1 ? "Invalid OTP" : "غلط او ٹی پی";

  String verify = SessionController().getLanguage() == 1
      ? "Verify and Proceed"
      : "تصدیق کریں اور آگے بڑھیں";

  ///////8888888
  ///
  ///
  String alert = SessionController().getLanguage() == 1 ? 'Alert' : 'الرٹ';
  String codeSent = SessionController().getLanguage() == 1
      ? 'Code Sent Successfully'
      : 'کوڈ کامیابی سے بھیج دیا گیا';
  String more = SessionController().getLanguage() == 1 ? 'More' : 'مزید';
  String markAsRead = SessionController().getLanguage() == 1
      ? 'Mark as Read'
      : 'پڑھا ہوا نشان کریں';
  String archive =
      SessionController().getLanguage() == 1 ? 'Archive' : 'آرکائیو';
  String all = SessionController().getLanguage() == 1 ? 'All' : 'سب';
  String unread =
      SessionController().getLanguage() == 1 ? 'Unread' : 'غیر پڑھا ہوا';
  String notifications =
      SessionController().getLanguage() == 1 ? 'Notifications' : 'اطلاعات';
  String settings =
      SessionController().getLanguage() == 1 ? 'Settings' : 'ترتیبات';
  String logout =
      SessionController().getLanguage() == 1 ? 'Log out' : 'لاگ آؤٹ';
  String about =
      SessionController().getLanguage() == 1 ? 'About' : 'کے بارے میں';
  String update = SessionController().getLanguage() == 1 ? 'Update' : 'اپ ڈیٹ';
  String googlePlay =
      SessionController().getLanguage() == 1 ? 'Google Play' : 'گوگل پلے';
  String appStore =
      SessionController().getLanguage() == 1 ? 'App Store' : 'ایپ اسٹور';
  String updateApp =
      SessionController().getLanguage() == 1 ? 'Update App' : 'ایپ اپ ڈیٹ کریں';
  String aNewVersion = SessionController().getLanguage() == 1
      ? 'A new version of the app'
      : 'ایپ کا نیا ورژن';
  String isAvailableAndFeatures = SessionController().getLanguage() == 1
      ? 'is available.\n'
      : 'دستیاب ہے۔\n';
  String updateThelatestVersion = SessionController().getLanguage() == 1
      ? ' highly recommends that you update the app to the latest version, in order to take advantage of any security patches and performance enhancements that have been implemented.'
      : 'ہم آپ کو مشورہ دیتے ہیں کہ ایپ کو تازہ ترین ورژن پر اپ ڈیٹ کریں تاکہ سیکیورٹی پیچ اور کارکردگی بہتری سے فائدہ اٹھا سکیں۔';
  String needHelp =
      SessionController().getLanguage() == 1 ? "Need Help?" : "مدد چاہیے؟";
  String help = SessionController().getLanguage() == 1 ? "Help" : "مدد";
  String callUs =
      SessionController().getLanguage() == 1 ? "Call Us" : "ہمیں کال کریں";
  String emailUs =
      SessionController().getLanguage() == 1 ? "Email Us" : "ہمیں ای میل کریں";
  String contactCenter =
      SessionController().getLanguage() == 1 ? "Contact Centre" : "رابطہ مرکز";
  String color = SessionController().getLanguage() == 1 ? "Colour" : 'رنگ';
  String biometric =
      SessionController().getLanguage() == 1 ? 'Biometric' : "بایومیٹرک";
  String cont =
      SessionController().getLanguage() == 1 ? 'Continue' : 'جاری رکھیں';
  String change =
      SessionController().getLanguage() == 1 ? "CHANGE" : "تبدیل کریں";
  String countryCode =
      SessionController().getLanguage() == 1 ? "Country Code" : "ملک کا کوڈ";
  String name = SessionController().getLanguage() == 1 ? "Name" : "نام";
  String save = SessionController().getLanguage() == 1 ? "Save" : "محفوظ کریں";
  String search =
      SessionController().getLanguage() == 1 ? "Search" : "تلاش کریں";
  String personalInfo =
      SessionController().getLanguage() == 1 ? 'Personal Info' : 'ذاتی معلومات';
  String myProfile =
      SessionController().getLanguage() == 1 ? 'My Profile' : 'میری پروفائل';
  String email = SessionController().getLanguage() == 1 ? 'Email' : 'ای میل';
  String address = SessionController().getLanguage() == 1 ? 'Address' : 'پتہ';
  String confirm =
      SessionController().getLanguage() == 1 ? 'Confirm' : 'تصدیق کریں';
  String incorrectCode = SessionController().getLanguage() == 1
      ? 'You\'ve entered an incorrect code.'
      : 'آپ نے غلط کوڈ درج کیا ہے۔';
  String retry =
      SessionController().getLanguage() == 1 ? 'Retry' : 'دوبارہ کوشش کریں';
  String validPhoneNo = SessionController().getLanguage() == 1
      ? 'Please Enter a Valid Mobile Number'
      : 'براہ کرم ایک درست موبائل نمبر درج کریں';
  String tooManyReqtryLater = SessionController().getLanguage() == 1
      ? "Too Many Requests, Please Try Again Later"
      : 'بہت زیادہ درخواستیں، براہ کرم بعد میں دوبارہ کوشش کریں';
  String on = SessionController().getLanguage() == 1 ? 'ON' : 'آن';
  String off = SessionController().getLanguage() == 1 ? 'OFF' : 'آف';
  String description =
      SessionController().getLanguage() == 1 ? 'Description' : 'تفصیل';
  String noFileReceived = SessionController().getLanguage() == 1
      ? "No file received"
      : "کوئی فائل موصول نہیں ہوئی";
  String files = SessionController().getLanguage() == 1 ? "Files" : "فائلیں";
  String photoLibrary = SessionController().getLanguage() == 1
      ? 'Photo Library'
      : "فوٹو لائبریری";
  String storage =
      SessionController().getLanguage() == 1 ? 'Storage' : "اسٹوریج";
  String camera1 = SessionController().getLanguage() == 1 ? 'Camera' : "کیمرہ";
  String updateProfile = SessionController().getLanguage() == 1
      ? 'Update Profile'
      : 'پروفائل اپ ڈیٹ کریں';
  String seconds = SessionController().getLanguage() == 1 ? 'Seconds' : 'سیکنڈ';
  String noMoreData = SessionController().getLanguage() == 1
      ? 'No More Data'
      : "مزید ڈیٹا نہیں ہے";
  String noInternetConnection = SessionController().getLanguage() == 1
      ? 'No internet Connection'
      : 'انٹرنیٹ کنکشن نہیں ہے';
  String connectionTimedOut = SessionController().getLanguage() == 1
      ? 'Connection timed out'
      : 'کنکشن کا وقت ختم ہو گیا';
  String couldNotConnectToServer = SessionController().getLanguage() == 1
      ? 'Could not connect to server'
      : 'سرور سے کنکشن نہیں ہو سکا';
  String unauthorized =
      SessionController().getLanguage() == 1 ? 'Unauthorised' : 'غیر مجاز';
  String noDatafound = SessionController().getLanguage() == 1
      ? 'No data found'
      : 'کوئی ڈیٹا نہیں ملا';
  String pleaseEnterMobileNoWithoutZero = SessionController().getLanguage() == 1
      ? 'Please do not start your phone number with zero'
      : 'براہ کرم اپنا فون نمبر صفر سے شروع نہ کریں';
  String badRequest = SessionController().getLanguage() == 1
      ? 'Request Error'
      : 'درخواست میں خرابی';
  String notFound =
      SessionController().getLanguage() == 1 ? 'NotFound' : 'نہیں ملا';
  String anyError = SessionController().getLanguage() == 1
      ? 'Something went wrong'
      : 'کچھ غلط ہو گیا';
  String success =
      SessionController().getLanguage() == 1 ? 'Success' : 'کامیابی';
  String loadMoreData =
      SessionController().getLanguage() == 1 ? 'Load More' : "مزید لوڈ کریں";
  String deviceBlocked = SessionController().getLanguage() == 1
      ? 'Device is blocked please wait'
      : "ڈیوائس بلاک ہے براہ کرم انتظار کریں";
  String noService =
      SessionController().getLanguage() == 1 ? 'No Service' : "کوئی سروس نہیں";
  String halka = SessionController().getLanguage() == 1 ? 'Halka' : 'حلقہ';
  String uc = SessionController().getLanguage() == 1 ? 'UC' : 'یوسی';
  String ward = SessionController().getLanguage() == 1 ? 'Ward' : 'وارڈ';
  String pmo = SessionController().getLanguage() == 1 ? 'PMO' : 'پی ایم او';
  String projectLeader = SessionController().getLanguage() == 1
      ? 'Project Leader'
      : 'پروجیکٹ لیڈر';
  String projectName = SessionController().getLanguage() == 1
      ? 'Project Name'
      : 'پروجیکٹ کا نام';
  String adpyear =
      SessionController().getLanguage() == 1 ? 'ADP Year' : 'اے ڈی پی سال';
  String searchProjectWith = SessionController().getLanguage() == 1
      ? 'Search project with'
      : 'پروجیکٹ تلاش کریں';
  String projectDetail = SessionController().getLanguage() == 1
      ? 'Project Detail'
      : 'پروجیکٹ کی تفصیل';
  String location =
      SessionController().getLanguage() == 1 ? 'Location' : 'مقام';

  String adpFinancialYear = SessionController().getLanguage() == 1
      ? 'ADP Financial Year'
      : 'اے ڈی پی مالی سال';
  String committeeMember = SessionController().getLanguage() == 1
      ? 'Committee Member'
      : 'کمیٹی ممبر';
  String viewFeedbackComplaint = SessionController().getLanguage() == 1
      ? 'View Feedback/Complaint'
      : 'فیڈبیک / شکایت دیکھیں';
  String feedbackComplaint = SessionController().getLanguage() == 1
      ? 'Feedback / Complaint'
      : 'فیڈبیک / شکایت';
  String unionCouncil =
      SessionController().getLanguage() == 1 ? 'Union Council' : 'یونین کونسل';
  String image = SessionController().getLanguage() == 1 ? 'Image' : 'تصویر';

  String video = SessionController().getLanguage() == 1 ? 'Video' : 'ویڈیو';

  String audio = SessionController().getLanguage() == 1 ? 'Audio' : 'آڈیو';
  String playing =
      SessionController().getLanguage() == 1 ? 'Playing...' : 'چل رہا ہے...';
  String addMoreFeedbackComplaint = SessionController().getLanguage() == 1
      ? 'Add More Feedback/Complaint'
      : 'مزید فیڈبیک / شکایت شامل کریں';
  String writeComplaint = SessionController().getLanguage() == 1
      ? 'Write complaint...'
      : 'شکایت لکھیں...';

  String whatsappPhone = SessionController().getLanguage() == 1
      ? 'WhatsApp / Phone'
      : 'واٹس ایپ / فون';
  String playAudio =
      SessionController().getLanguage() == 1 ? 'Play Audio' : 'آڈیو چلائیں';
  String uploadImage = SessionController().getLanguage() == 1
      ? 'Upload Image'
      : 'تصویر اپ لوڈ کریں';

  String uploadVideo = SessionController().getLanguage() == 1
      ? 'Upload Video'
      : 'ویڈیو اپ لوڈ کریں';

  String uploadAudio = SessionController().getLanguage() == 1
      ? 'Upload Audio'
      : 'آڈیو اپ لوڈ کریں';
  String submit =
      SessionController().getLanguage() == 1 ? 'Submit' : 'جمع کریں';
  String startRecording = SessionController().getLanguage() == 1
      ? 'Start recording'
      : 'ریکارڈ شروع کریں';

  String stopRecording = SessionController().getLanguage() == 1
      ? 'Stop recording'
      : 'ریکارڈنگ بند کریں';

  String recordAgain = SessionController().getLanguage() == 1
      ? 'Record again'
      : 'دوبارہ ریکارڈ کریں';
  String mediaRequiredMessage = SessionController().getLanguage() == 1
      ? 'Please provide at least one of: text, image, video, or audio'
      : 'براہ کرم کم از کم ایک چیز فراہم کریں: متن، تصویر، ویڈیو یا آڈیو';
  String nameRequired = SessionController().getLanguage() == 1
      ? 'Name is required'
      : 'نام ضروری ہے';

  String emailRequired = SessionController().getLanguage() == 1
      ? 'Email is required'
      : 'ای میل ضروری ہے';

  String phoneRequired = SessionController().getLanguage() == 1
      ? 'Phone is required'
      : 'فون ضروری ہے';
}
