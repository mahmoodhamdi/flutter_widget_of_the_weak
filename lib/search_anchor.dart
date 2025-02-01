import 'package:flutter/material.dart';

class MySearchAnchor extends StatefulWidget {
  const MySearchAnchor({super.key});

  @override
  State<MySearchAnchor> createState() => _MySearchAnchorState();
}

class _MySearchAnchorState extends State<MySearchAnchor> {
  final List<String> _suggestions = <String>[
    'apple',
    'banana',
    'cherry',
    'date',
    'elderberry',
    'fig',
    'grape',
    'honeydew',
    'kiwi',
    'lemon',
    'mango',
    'nectarine',
    'orange',
    'pear',
    'quince',
    'raspberry',
    'strawberry',
    'tangerine',
    'ugli fruit',
    'vanilla bean',
    'watermelon',
    'ximenia caffra',
    'yellowfin tuna',
    'zucchini',
  ];
  late final SearchController searchController;
  @override
  void initState() {
    super.initState();
    searchController = SearchController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
        barBackgroundColor: WidgetStateProperty.all(Colors.blue),
        barElevation: WidgetStateProperty.all(4),
        barPadding: WidgetStateProperty.all(EdgeInsets.all(8)),
        barHintStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
        barHintText: "Search",
        barTextStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
        barLeading: Icon(Icons.search, color: Colors.white),
        barShape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )),
        barSide:
            WidgetStateProperty.all(BorderSide(color: Colors.white, width: 2)),
        dividerColor: Colors.white,
        isFullScreen: false,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          print(value);
        },
        onSubmitted: (value) {
          searchController.clear();
        },
        scrollPadding: EdgeInsets.all(16),
        viewBackgroundColor: Colors.white,
        viewElevation: 4,
        viewShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        viewHeaderHintStyle: TextStyle(color: Colors.black),
        viewHeaderTextStyle: TextStyle(color: Colors.black),
        viewHintText: "Search",
        viewSide: BorderSide(color: Colors.black, width: 2),
        searchController: searchController,
        suggestionsBuilder: (context, controller) {
          return _suggestions
              .where((word) => word.startsWith(controller.text))
              .map<ListTile>((word) => ListTile(
                    title: Text(word),
                    onTap: () {
                      controller.text = word;
                    },
                  ))
              .toList();
        });
  }
}
