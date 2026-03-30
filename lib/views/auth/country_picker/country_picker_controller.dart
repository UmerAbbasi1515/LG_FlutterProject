import 'package:get/get.dart';
import 'package:localgovernment_project/data/helpers/base_client.dart';
import 'package:localgovernment_project/data/helpers/session_controller.dart';
import 'package:localgovernment_project/data/models/auth_models/country_model.dart';
import 'package:localgovernment_project/data/models/common_response_model.dart';
import 'package:localgovernment_project/data/repository/auth_repository.dart';
import 'package:localgovernment_project/views/common/no_internet_screen.dart';

class CountryPickerController extends GetxController {
 Rx<ApiResponse<List<Country>>> countryPicker = ApiResponse<List<Country>>(data: []).obs;
 
  var loadingData = false.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  RxInt selectedIndex = (-1).obs;
  RxString selectedDialingCode = '+971'.obs;

  @override
  void onInit() {
    if (countryPicker.value.data == null ||
        countryPicker.value.data!.isEmpty) {
      getData();
    }
    super.onInit();
  }


  Future<void> getData() async {
    bool isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!isInternetConnected) {
      await Get.to(() => const NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      var result = await CommonRepository.countryPicker();
      
      loadingData.value = false;
      if (result is ApiResponse<List<Country>>) {
        countryPicker.value = result;
        
        length = countryPicker.value.data!.length;
       
        Country selectedCountry  =
                    countryPicker.value.data!.firstWhere((country) {
                  return country.dialingCode == selectedDialingCode.value;
                });


        selectedIndex.value =
            countryPicker.value.data!.indexOf(selectedCountry);
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      // getData();
    }
  }

  void selectCountry(int index) {
    selectedIndex.value = index;
    selectedDialingCode.value =
        countryPicker.value.data![index].dialingCode!;
    SessionController().setDialingCode(
      countryPicker.value.data![index].dialingCode.toString(),
    );
    SessionController().setSelectedFlag(
      countryPicker.value.data![index].flag.toString(),
    );
    selectedIndex.value = index;
  }
}
