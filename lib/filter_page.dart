import 'package:flutter/material.dart';
import 'package:filter_list/filter_list.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({Key key, this.allTextList}) : super(key: key);
  final List<String> allTextList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter list Page"),
      ),
      body: SafeArea(
        child: FilterListWidget(
          allTextList: allTextList,
          height: MediaQuery.of(context).size.height,
          hideheaderText: true,
          onApplyButtonClick: (list) {
            if(list != null){
              print("selected list length: ${list.length}");
            }
          },
        ),
      ),
    );
  }
}