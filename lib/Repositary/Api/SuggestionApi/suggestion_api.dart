import 'package:http/http.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestionApi {
  ApiClient apiClient = ApiClient();

  Future<String> getSuggestions({
    required String message,
  }) async {
    String? id;

    final preference = await SharedPreferences.getInstance();
    id = preference.getString('DoctorId').toString();
    String basePath = "addsuggestions";

    final body = {
      "message": message,
      "user_id": id,
      "type": "doctor",
    };

    Response response =
        await apiClient.invokeAPI(path: basePath, method: "POST", body: body);
    print(body);
    print("<<<<<<<<<<Book Appointment Details page response worked>>>>>>>>>>");
    return response.body;
  }
}
