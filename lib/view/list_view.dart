import 'package:chat_riverpod/model/url_model.dart';
import 'package:chat_riverpod/view/url_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_riverpod/model/list_model.dart';
import 'package:chat_riverpod/util/my_string.dart';



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
    void onTileTapped(int index) async {
      final urlItem = urlModels.reversed.toList()[index];
      final newUrlModel = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UrlModelEditScreen(urlItem: urlItem, myIndex: index)),
      );
//wait for the UrlModelEditScreen to return a result.
      if (newUrlModel != null) {
        urlModels.reversed.toList()[index].updateName(newUrlModel.name);
        urlModelListNotifier.updateUrl(newUrlModel, index);
        urlModelListNotifier.updateUrlModels(urlModels);
        urlModelListNotifier.save();
      }
    }

    return WillPopScope(
      onWillPop: () async {
        // Handle the pop event here
        return true; // Return true to allow the pop event
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('UrlModel List')),

        body: ListView.builder(
          itemCount: urlModels.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(MyString.limitString(urlModels.reversed.toList()[index].name, 35)),
              subtitle: Text('ID: ${urlModels.reversed.toList()[index].id}'),
              onTap: () => onTileTapped(index),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onAddButtonPressed,
          tooltip: 'Add UrlModel',
          child: const Icon(Icons.add),
        ),
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