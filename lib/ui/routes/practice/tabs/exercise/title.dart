import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:musicavis/ui/routes/practice/tabs/index.dart';
import 'package:musicavis/utils/themes.dart';

StatelessWidget makeTitle(int index, String title, bool isEnabled) =>
    isEnabled ? TitleEnabled(index, title) : TitleDisabled(title);

class TitleEnabled extends HookWidget {
  final int index;
  final String title;
  final Function updateItem;
  final Function addItem;

  TitleEnabled(this.index, this.title, {this.updateItem, this.addItem});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: title),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: defaultFontSize),
      onChanged: (value) => updateItem(TabType.exercise, index, value),
      onEditingComplete: () => addItem(TabType.exercise),
      decoration: InputDecoration(
        hintText: captionTabType(TabType.exercise),
      ),
    );
  }
}

class TitleDisabled extends StatelessWidget {
  final String title;

  TitleDisabled(this.title);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      style: greyTextStyle(16),
      controller: TextEditingController(text: title),
      decoration: InputDecoration(
        hintText: captionTabType(TabType.exercise),
      ),
    );
  }
}
