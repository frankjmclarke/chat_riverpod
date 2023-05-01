import 'dart:async';
import 'package:chat_riverpod/model/url_model.dart';
import 'package:chat_riverpod/model/file_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

final urlModelListViewModelProvider =
    StateNotifierProvider<UrlModelListViewModel, List<UrlModel>>(
  (ref) => UrlModelListViewModel([]),
);

class UrlModelListViewModel extends StateNotifier<List<UrlModel>> {
  UrlModelListViewModel(List<UrlModel> state) : super(state);

  void updateUrlModels(List<UrlModel> urlModels) {
    state = urlModels;
  }

  void updateUrl(UrlModel newUrlModel, int myIndex) {
    state.reversed.toList()[myIndex] = newUrlModel;
  }

  void addUrlModel(UrlModel newUrlModel) {
    state = [...state, newUrlModel];
  }

  ////////////////////////////////////
  static const String filename = "shared_url_list.txt";
  bool loaded = false;
  int id = 0;
  StreamSubscription<String>? textStreamSubscription;

  void initializeTextStreamSubscription() {
    //this gets called on sharing from Chrome
    if (!loaded) {
      print('initializeTextStreamSubscription');
      loadList('');
      textStreamSubscription =
          ReceiveSharingIntent.getTextStream().listen((String value) {
        print('Loaded one Url');
        loadList(value);
      });
    }
  }

  void loadList(String value) async {
    if (loaded) {
      add(value);
      save();
    } else {
      loaded = true;
      state = (await FileHelper.loadFromFile());
      print('Loaded Urls:');
      add(value);
      for (var url in state) {
        print('id=${url.id}, name=${url.name}');
      }
    }
  }

  bool checkIfTitleExists(List<UrlModel> urls, String title) {
    return urls.any((url) => url.name == title);
  }

  Future<void> add(String sharedText) async {
    if (sharedText.isNotEmpty && !checkIfTitleExists(state, sharedText)) {
      print("addTextToListIfUnique $sharedText");
      UrlModel newUrlModel = UrlModel(id++, sharedText);
      state.add(newUrlModel);
    }
  }

  Future<void> save() async {
    await FileHelper.saveToFile(state);
    print('Urls saved to file. Length: ${state.length}');
    state = (await FileHelper
        .loadFromFile()); //seems you need to replace state to get the UI to respond
  }
}

/*
urlModelListViewModelProvider: This is a StateNotifierProvider that defines the state for
a list of UrlModel objects. It takes an initial value of an empty list ([]) and
is managed by a UrlModelListNotifier instance.

UrlModelListViewModel: This is a StateNotifier subclass that extends
List<UrlModel>. It is responsible for managing the state of the list of UrlModel
objects. The updateUrlModels method can be used to update the state with a new
list of UrlModel objects.
 */
