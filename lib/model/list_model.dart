import 'package:chat_riverpod/model/url_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final urlModelListViewModelProvider = StateNotifierProvider<UrlModelListViewModel, List<UrlModel>>(
      (ref) => UrlModelListViewModel([]),
);

class UrlModelListViewModel extends StateNotifier<List<UrlModel>> {
  UrlModelListViewModel(List<UrlModel> state) : super(state);

  void updateUrlModels(List<UrlModel> urlModels) {
    state = urlModels;
  }
  void addUrlModel(UrlModel newUrlModel) {
    state = [...state, newUrlModel];
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