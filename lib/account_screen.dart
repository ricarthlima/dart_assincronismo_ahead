import 'dart:async';
import 'dart:io';

import 'package:dart_assincronismo_ahead/account_model.dart';
import 'package:dart_assincronismo_ahead/account_service.dart';
import 'package:uuid/uuid.dart';

class AccountScreen {
  AccountService accountService = AccountService();

  late StreamSubscription subscription;

  runChatBot() async {
    subscription = accountService.streamInfos.listen(
      (event) {
        print(event);
      },
    );

    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - 👀 Ver todas sua contas.");
      print("2 - ➕ Adicionar nova conta.");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            {
              List<dynamic> listResult = await accountService.getAll();
              print(listResult);
              break;
            }
          case "2":
            {
              AccountModel newAccount = AccountModel(
                id: Uuid().v1(),
                name: "Haley",
                lastName: "Dourada",
                accountType: "Ouro",
                balance: 8001,
              );
              await accountService.add(newAccount);
              break;
            }
          case "3":
            {
              print("Te vejo na próxima! 👋");
              isRunning = false;
              subscription.cancel();
              break;
            }
          default:
            {
              print("Não entendi, tente novamente.");
            }
        }
      }
      print("\n");
    }
  }
}
