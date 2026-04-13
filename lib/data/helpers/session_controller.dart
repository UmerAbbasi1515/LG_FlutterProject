import 'package:localgovernment_project/data/models/auth_models/validate_user_model.dart';
import 'package:localgovernment_project/views/widgets/New/phone_no_field.dart';

class SessionController {
  static final SessionController _instance = SessionController._internel();

  //  _selectedLang = 1 : English
  //  _selectedLang = 2 : Urdu

  late UserModel _user;
  String? _loginToken = "";
  String? _token = "";
  String? nameEn = "";
  String? nameUr = "";
  String? _deviceToken = "";
  String? _phone = "";
  String? _dialingCode = "+92";
  String? _selectedFlag;
  int? _selectedLang = 1;
  int? userID;
  String? _otpCode;
  String? _goToDashboard;
  String? _notificationId;
  String? _url = "";
  String isPasswordSet = "0";
  String? otpCodeFrombackend = "";
  bool fingerprint = false;
  String? storeAppVerison;

  factory SessionController() {
    return _instance;
  }

  SessionController._internel() {
    _user = UserModel();
  }
  void setLanguage(int? id) {
    _selectedLang = id;
  }

  int? getLanguage() {
    return _selectedLang;
  }

  void setUser(UserModel? user) {
    _user = user!;
  }

  void setUserID(String? id) {
    userID = int.parse(id!);
    _user.id = int.parse(id);
  }

  int? getUserID() {
    return userID;
  }

  void setToken(String? token) {
    _token = token;
  }

  String? getToken() {
    return _token;
  }

  void setLoginToken(String? token) {
    _loginToken = token;
  }

  String? getLoginToken() {
    return _loginToken;
  }

  void setfingerprint(bool fp) {
    fingerprint = fp;
  }

  bool getfingerprint() {
    return fingerprint;
  }

  void setDeviceTokken(String? deviceToken) {
    _deviceToken = deviceToken;
  }

  String? getDeviceTokken() {
    return _deviceToken;
  }

  UserModel getUser() {
    return _user;
  }

  int? getUserId() {
    return _user.id;
  }

  String? getUserName() {
    if (_selectedLang == 1) {
      return _user.nameEn;
    } else {
      return _user.nameUr;
    }
  }

  String? getUserMobile() {
    return _user.phone;
  }

  String? getUserEmail() {
    return _user.email;
  }

  void setOtpCode(String? otpCode) {
    _otpCode = otpCode;
  }

  String? getOtpCode() {
    return _otpCode;
  }

  void setGoToDashboard(String? goToDashboard) {
    _goToDashboard = goToDashboard;
  }

  String? getGoToDashboard() {
    return _goToDashboard;
  }

  void setUserName(String? name) {
    nameEn = name;
  }

  void setPhone(String? phone) {
    _phone = phone;
  }

  String? getPhone() {
    return _phone;
  }

  void setDialingCode(String? dialingCode) {
    _dialingCode = dialingCode;
  }

  String? getDialingCode() {
    return _dialingCode;
  }

  void setSelectedFlag(String? selectedFlag) {
    _selectedFlag = selectedFlag;
  }

  String? getSelectedFlag() {
    return _selectedFlag;
  }

  void setNotificationId(String? notificationId) {
    _notificationId = notificationId;
  }

  String? getNotificationId() {
    return _notificationId;
  }

  void setUrl(String? url) {
    _url = url;
  }

  String? getUrl() {
    return _url;
  }

  void resetSession() {
    _token = '';
    SessionController().setLoginToken("");
    PhoneNoFieldWidget.phoneController.clear();
  }
  
}
