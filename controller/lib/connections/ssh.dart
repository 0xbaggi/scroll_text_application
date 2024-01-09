import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'dart:convert';

class SSH {
  late String ip;
  late int port;
  late String username;
  late String password;
  bool connected = false;
  late SSHClient client;

  Future<bool> connect({required String ip, required int port, required String username,required String password}) async {
    try {
      SSHSocket socket = await SSHSocket.connect(ip, port);
      this.password = password;
      this.username = username;
      this.ip = ip;
      this.port = port;

      client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () {
          return password;
        },
      );

      connected = true;
    } catch (e) {
      connected = false;
    }

    return connected;
  }

  Future<String> execute(String command) async {
    var result = await client.execute(command);

    var responseBytes = await result.stdout.fold<Uint8List>(
      Uint8List(0),
          (Uint8List previous, Uint8List element) => Uint8List.fromList([...previous, ...element]),
    );

    var responseString = utf8.decode(responseBytes);

    return responseString;
  }

  disconnect() {
    if(connected) {
      connected = false;
      client.close();
    }
  }

  bool isConnected() {
    return connected;
  }

  shutDownLG() async {
    try {
      await execute('bash scroll_text_application/poweroff.sh $password');
      disconnect();
    } catch (e) {
      print(e);
    }
  }

}