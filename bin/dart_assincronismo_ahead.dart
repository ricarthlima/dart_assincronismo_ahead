import 'package:http/http.dart';

void main() {
  requestData();
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
    },
  );
}
