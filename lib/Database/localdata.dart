import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalData {
  final storage = new FlutterSecureStorage();
  writetoken(String accesstoken, String refreshtoken) async {
    await storage.write(key: 'Accesstoken', value: accesstoken);
    await storage.write(key: 'Refreshtoken', value: refreshtoken);
    print(await storage.read(key: 'Refreshtoken'));
  }

  writeAccesstoken(String accesstoken) async {
    print("I am here at write access token");
    await storage.write(key: 'Accesstoken', value: accesstoken);
    //print(await storage.read(key: 'Accesstoken'));
  }

  deleteAlltoken() async {
    await storage.deleteAll();
  }

  deleteAccesstoken() async {
    await storage.delete(key: 'Accesstoken');
  }

  readtoken() async {
    String? accesstoken = await storage.read(key: 'Accesstoken');
    String? refreshtoken = await storage.read(key: 'Refreshtoken');
    return {'RefreshToken': refreshtoken, 'AccessToken': accesstoken};
  }
}
