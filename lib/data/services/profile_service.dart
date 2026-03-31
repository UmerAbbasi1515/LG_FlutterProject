import 'package:http/http.dart' as http;
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/models/profile_model.dart';
import 'package:localgovernment_project/utils/constants/app_config.dart';

class TenantProfileServices {
  static Future<dynamic> getData() async {
    var url = AppConfig().getUserProfile;

    var response = await BaseClientClass.post(url ?? "", {});

    if (response is http.Response) {
      TenantProfileModel data = tenantProfileModelFromJson(response.body);
      return data;
    }
    return response;
  }

  static Future<dynamic> updateProfile(
      String name, String mobileNo, String email, String address) async {
    var url = AppConfig().getUserProfile;

    var data = {
      "caseNo": 0.toString(),
      "description": null,
      "personName": name,
      "personMobile": mobileNo,
      "personEmail": email,
      "address": address
    };

    var resp = await BaseClientClass.post(url ?? "", data);
    if (resp is http.Response) {
      return tenantUpdateProfileModelFromJson(resp.body);
    }
    return resp;
  }
}
