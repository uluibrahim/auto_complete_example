import 'package:flutter/material.dart';

import 'model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Autocomplete<SerachModel>(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<SerachModel>.empty();
                }
                Iterable<SerachModel> iterable = searchList.where(
                  (element) => element.title!.contains(textEditingValue.text),
                );

                return iterable.isNotEmpty ? iterable : [SerachModel()];
              },
              onSelected: (value) {},
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<SerachModel> onSelected,
                  Iterable<SerachModel> options) {
                final list = options.toList();
                String firsType = list.first.type ?? '';

                for (var i = 1; i < list.length; i++) {
                  !firsType.contains(list[i].type!)
                      ? firsType = '$firsType + ${list[i].type!}'
                      : '';
                }
                return Scaffold(
                  body: options.first.title == null
                      ? const Center(child: Text('Aranan İsimde Ürün Bulunamadı'))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              firsType,
                              textAlign: TextAlign.right,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(list[index].image!),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(list[index].title ?? ''),
                                      const SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                );
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                );
              },
            ),
            ...List.generate(
              5,
              (index) => Text(index.toString()),
            ),
          ],
        ),
      ),
    );
  }

  final List<SerachModel> searchList = [
    SerachModel(
      title: 'egg',
      image: 'https://picsum.photos/200/300',
      type: 'Essentials',
    ),
    SerachModel(
        title: 'banana', image: 'https://picsum.photos/200/300', type: 'vega'),
    SerachModel(
        title: 'apple', image: 'https://picsum.photos/200/300', type: 'vega'),
    SerachModel(
        title: 'bread', image: 'https://picsum.photos/200/300', type: 'vega'),
    SerachModel(
        title: 'water', image: 'https://picsum.photos/200/300', type: 'vega'),
  ];
}
