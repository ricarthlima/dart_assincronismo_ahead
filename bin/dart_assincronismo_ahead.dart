import 'dart:convert';

import 'package:http/http.dart';

void main() {
  //requestData();
  requestDataAsync();
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

requestDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";

  Response response = await get(Uri.parse(url));
  print(json.decode(response.body)[0]);
  print("Deveria acontecer depois, e acontece!");
}
