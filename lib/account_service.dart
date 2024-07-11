import 'dart:async';
import 'dart:convert';
import 'package:dart_assincronismo_ahead/account_model.dart';
import 'package:dart_assincronismo_ahead/api_key.dart';
import 'package:http/http.dart';

class AccountService {
  StreamController<String> streamController = StreamController<String>();
  Stream<String> get streamInfos => streamController.stream;

  Future<List<dynamic>> getAll() async {
    String url =
        "https://gist.githubusercontent.com/ricarthlima/413c0aefe6c6abc464581c29029c8ace/raw/d6c2f9da4bf96ac36f4fa83fb001156f8ace265d/accounts.json";

    Response response = await get(Uri.parse(url));
    streamController.add("${DateTime.now()} | Requisição Assíncrona");

    return json.decode(response.body);
  }

  add(AccountModel account) async {
    List<dynamic> listAccounts = await getAll();
    listAccounts.add(account.toMap());
    String content = json.encode(listAccounts);

    String url =
        "https://api.github.com/gists/413c0aefe6c6abc464581c29029c8ace";

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

    if (response.statusCode == 200) {
      streamController.add("${DateTime.now()} | Adicionado ${account.name}.");
    } else {
      streamController
          .add("${DateTime.now()} | Falha ao adicionar ${account.name}.");
    }
  }
}
