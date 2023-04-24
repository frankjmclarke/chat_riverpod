import 'package:chat_riverpod/model/url_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/list_model.dart';

class UrlModelListScreen extends ConsumerWidget {
  const UrlModelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlModels = ref.watch(urlModelListViewModelProvider);
    final urlModelListNotifier = ref.read(urlModelListViewModelProvider.notifier);
    urlModelListNotifier.initializeTextStreamSubscription();
    String newUrlModelName = 'Name'; // Track the new URL model name

    void onAddButtonPressed() {
      final newUrlModel = UrlModel(urlModels.length + 1, newUrlModelName);
      urlModelListNotifier.addUrlModel(newUrlModel);
      // Reset the new URL model name after adding to the list
      newUrlModelName = '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('UrlModel List')),
      body: ListView.builder(
        itemCount: urlModels.length,
        itemBuilder: (context, index) {
          final urlModel = urlModels[index];
          return ListTile(
            title: Text(urlModel.name),
            subtitle: Text('ID: ${urlModel.id}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddButtonPressed,
        tooltip: 'Add UrlModel',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/*
UrlModelListScreen: This is a ConsumerWidget that displays the list of UrlModel
objects. It uses ref.watch(urlModelListProvider) to obtain the current state of
the list from the urlModelListProvider. It then uses this state to build a
ListView.builder widget that displays each UrlModel object as a ListTile in a
ListView. The _id property of each UrlModel object is displayed as a subtitle in
the ListTile.
 */
