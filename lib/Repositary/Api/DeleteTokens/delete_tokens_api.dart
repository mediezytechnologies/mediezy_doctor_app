
import 'package:http/http.dart';
import 'package:mediezy_doctor/Repositary/Api/ApiClient.dart';

class DeleteTokensApi {
  ApiClient apiClient = ApiClient();
  Future<String> getDeleteToken({
    required String tokenId,
  }) async {
    String basePath = "docter/delete_tokens";

    final body = {
      "token_id": tokenId
    };
    Response response =
    await apiClient.invokeAPI(path: basePath, method: "POST", body: body);

    print("<<<<<<<<<<Leave Schedule response worked>>>>>>>>>>");
    return response.body;
  }
}
