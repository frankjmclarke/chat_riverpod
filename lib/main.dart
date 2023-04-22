import 'package:chat_riverpod/view/list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(
      child: MaterialApp(
        title: 'UrlModel List Example',
        home: UrlModelListScreen(),
      ),
    );
  }
}
/*
MyApp: This is the main entry point of the Flutter app. It sets up the
ProviderScope to provide the necessary dependencies for the app and defines the
UrlModelListScreen as the home screen.

Note: The usage of _id in the ListTile directly as urlModel._id may not be
recommended, as _id is a private field within the UrlModel class. It's
better to use a getter to access the _id value, as shown in a previous example.
 */