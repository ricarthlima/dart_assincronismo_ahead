import 'dart:async';
import 'dart:convert';

import 'package:dart_assincronismo_ahead/api_key.dart';
import 'package:http/http.dart';

StreamController<String> streamController = StreamController<String>();

void main() {
  StreamSubscription subscription = streamController.stream.listen(
    (event) {
      print(event);
    },
  );

  requestData();
  requestDataAsync();
  sendDataAsync({
    "id": "IDNEW",
    "name": "Sebastian",
    "lastName": "Montanha",
    "accountType": "Prata",
    "balance": 333.0,
  });

  subscription.cancel();
}

requestData() {
  String url =
      "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";
  Future<Response> response = get(Uri.parse(url));
  response.then(
    (value) {
      streamController.add("${DateTime.now()} | Requisição com Future");
      List<dynamic> listUsers = json.decode(value.body);
    },
  );
}

Future<List<dynamic>> requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";

  Response response = await get(Uri.parse(url));
  streamController.add("${DateTime.now()} | Requisição Assíncrona");

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

  streamController.add("${DateTime.now()} | Adicionado ${toSend["name"]}");
}
