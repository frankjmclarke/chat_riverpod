import 'package:flutter/material.dart';
import 'package:chat_riverpod/model/url_model.dart';
import 'package:chat_riverpod/model/list_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UrlModelEditScreen extends ConsumerWidget {
  final UrlModel urlItem;
  final int myIndex;

  const UrlModelEditScreen({Key? key, required this.urlItem, required this.myIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlModels = ref.watch(urlModelListViewModelProvider);
    final urlModelListNotifier = ref.read(urlModelListViewModelProvider.notifier);

    final formKey = GlobalKey<FormState>();
    late TextEditingController nameController;

    nameController = TextEditingController(text: urlItem.name);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter name',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newUrlModel = UrlModel(
                      urlItem.id,
                      nameController.text,
                    );
                   // urlModels.reversed.toList()[myIndex].updateName(newUrlModel.name);
                   // urlModelListNotifier.updateUrl(newUrlModel, myIndex);
                   // urlModelListNotifier.updateUrlModels(urlModels);
                    Navigator.of(context).pop(newUrlModel);
                    //Navigator.of(context).pop(newUrlModel); pops the current
                    // route off the navigator stack and returns newUrlModel
                    // as the result of the route.
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
