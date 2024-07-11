import 'dart:convert';

import 'package:dart_assincronismo_ahead/api_key.dart';
import 'package:http/http.dart';

void main() {
  //requestData();
  //requestDataAsync();
  sendDataAsync({
    "id": "IDNEW",
    "name": "Sebastian",
    "lastName": "Montanha",
    "accountType": "Prata",
    "balance": 333.0,
  });
}

requestData() {
  String url =
      "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";
  Future<Response> response = get(Uri.parse(url));
  print(response); // Não é o que queremos.
  response.then(
    (value) {
      print(value); // Não é o que queremos
      print(value.body); // É o que queremos

      List<dynamic> listUsers = json.decode(value.body);
      print(listUsers[0]);
    },
  );
  print("Deveria acontecer depois, mas acontece antes.");
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";

  Response response = await get(Uri.parse(url));
  print(json.decode(response.body)[0]);
  print("Deveria acontecer depois, e acontece!");

  return json.decode(response.body);
}

sendDataAsync(Map<String, dynamic> toSend) async {
  List<dynamic> listAccounts = await requestDataAsync();
  listAccounts.add(toSend);
  String content = json.encode(listAccounts);

  // Não funciona
  // String url =
  //     "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";

  // Response response = await post(Uri.parse(url), body: content);

  String url = "https://api.github.com/gists/413c0aefe6c6abc464581c29029c8ace";
  Response response = await post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $githubApiKey",
    },
    body: json.encode({
      "description": "accounts.json",
      "public": true,
      "files": {
        "accounts.json": {"content": content}
      }
    }),
  );

  print(response.statusCode);
}
