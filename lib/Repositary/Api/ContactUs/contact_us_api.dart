
import 'package:http/http.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUsApi {
  ApiClient apiClient = ApiClient();
  Future<String> addContactUs({
    required String email,
    required String description,
  }) async {
    String? doctorId;
    final preference = await SharedPreferences.getInstance();
    doctorId = preference.getString('DoctorId').toString();

    String basePath = "getContactUsDetails";

    final body = {
      "email": email,
      "description": description,
      "UserId": doctorId,
    };
    Response response =
    await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    return response.body;
  }
}
