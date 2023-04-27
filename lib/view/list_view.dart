import 'package:chat_riverpod/model/url_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/list_model.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

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
    List<ExpandableColumn<dynamic>> headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "First name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Last name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Maiden name", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Age", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
    ];
    List<ExpandableRow> rows = urlModels.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<int>(columnTitle: "ID", value: e.id),
        ExpandableCell<String>(columnTitle: "First name", value: e.name),
        ExpandableCell<String>(columnTitle: "Last name", value: e.name),
        ExpandableCell<String>(columnTitle: "Maiden name", value: e.name),
        ExpandableCell<int>(columnTitle: "Age", value: e.id),
        ExpandableCell<String>(columnTitle: "Gender", value: e.name),
        ExpandableCell<String>(columnTitle: "Email", value: e.name),
      ]);
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('UrlModel List')),
      body: ListView.builder(
        itemCount: urlModels.length,
        itemBuilder: (context, index) {
          final urlModel = urlModels[index];
          return SizedBox(
            height: 500,
            width: 500,
            child: ExpandableTheme(
              data: ExpandableThemeData(
                context,
                rowBorder: const BorderSide(color: Colors.amber),
                expandedBorderColor: Colors.transparent,
                paginationSize: 48,
              ),

              child: ExpandableDataTable(
                rows: rows,
                headers: headers,
                visibleColumnCount: 4,
              ),
            ),
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
