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
      ExpandableColumn<String>(columnTitle: "Url", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Address", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Price", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Age", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
    ];
    List<ExpandableRow> rows = urlModels.map<ExpandableRow>((e) {
      return ExpandableRow(cells: [
        ExpandableCell<int>(columnTitle: "ID", value: e.id),
        ExpandableCell<String>(columnTitle: "Url", value: e.name),
        ExpandableCell<String>(columnTitle: "Address", value: e.name),
        ExpandableCell<String>(columnTitle: "Price", value: e.name),
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
          return SizedBox(
            height: 444,
            width: 433,
            child: ExpandableTheme(
              data: ExpandableThemeData(
                context,
                contentPadding: const EdgeInsets.all(20),
                expandedBorderColor: Colors.transparent,
                paginationSize: 20,
                headerHeight: 56,
                headerColor: Colors.amber[400],
                headerBorder: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                evenRowColor: const Color(0xFFFFFFFF),
                oddRowColor: Colors.amber[200],
                rowBorder: const BorderSide(
                  color: Colors.black,
                  width: 0.3,
                ),
                rowColor: Colors.green,
                headerTextMaxLines: 4,
                headerSortIconColor: const Color(0xFF6c59cf),
                paginationSelectedFillColor: const Color(0xFF6c59cf),
                paginationSelectedTextColor: Colors.white,
              ),

              child: ExpandableDataTable(
                rows: rows,
                headers: headers,
                visibleColumnCount: 5,
                multipleExpansion: false,
                isEditable: true,
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
