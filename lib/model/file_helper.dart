import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_riverpod/model/url_model.dart';
import 'package:path_provider/path_provider.dart';

class FileHelper {
  // Method to get the file path for saving the text file
  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path + '/data.txt'; // You can set any file name here
  }

  // Method to save list of UrlModel objects to a text file
  static Future<void> saveToFile(List<UrlModel> urls) async {
    final file = File(await getFilePath());
    final List<Map<String, dynamic>> urlsList =
    urls.map((url) => url.toMap()).toList();
    final jsonData = json.encode(urlsList);
    await file.writeAsString(jsonData);
  }

  // Method to load list of UrlModel objects from a text file
  static Future<List<UrlModel>> loadFromFile() async {
    final file = File(await getFilePath());
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final List<Map<String, dynamic>> urlsList =
      List<Map<String, dynamic>>.from(json.decode(jsonData));
      return urlsList.map((urlMap) => UrlModel.fromMap(urlMap)).toList();
    } else {
      return []; // Return empty list if file doesn't exist
    }
  }
}