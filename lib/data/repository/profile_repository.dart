import 'package:localgovernment_project/data/services/profile_service.dart';

class ProfileRepository {
  static Future<dynamic> updateProfile(
          String name, String mobileNo, String email, String address) =>
      TenantProfileServices.updateProfile(name, mobileNo, email, address);
  static Future<dynamic> tenantProfile() => TenantProfileServices.getData();
}
