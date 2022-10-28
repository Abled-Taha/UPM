import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage extends StatelessWidget {
  const FileStorage({Key? key}) : super(key: key);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFileConfig async {
    final path = await _localPath;
    File file = File("$path/config.ini");
    return file;
  }

  checkConfig() async {
    File file = await _localFileConfig;
    if (await file.exists() == false) {
      Map<String, dynamic> config = {
        "serverIP": "localhost",
        "port": "5000",
        "passwordMain": "1.complexPassword.1",
        "passwordEncryptionKey": "1.complexPasswordEncryptionKey.1"
      };
      await writeConfig(config);
    }
  }

  Future<Map<String, dynamic>> readConfig() async {
    await checkConfig();
    try {
      final file = await _localFileConfig;
      String temp = await file.readAsString();
      Map<String, dynamic> contents = await jsonDecode(temp);

      return contents;
    } catch (e) {
      return <String, dynamic>{};
    }
  }

  Future<File> writeConfig(Map<String, dynamic> config) async {
    final file = await _localFileConfig;

    return file.writeAsString(mode: FileMode.writeOnly, json.encode(config));
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
