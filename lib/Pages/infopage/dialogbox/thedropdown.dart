import 'package:flutter/material.dart';

DropdownButton theMenuItems(
    {required List<String> items,
    required Function theCallback,
    required dynamic valueChoose,
    required double width}) {
  return DropdownButton(
      iconEnabledColor: Colors.blue,
      itemHeight: 50.0,
      elevation: 12,
      borderRadius: BorderRadius.circular(10.0),
      dropdownColor: Colors.lightBlue.withOpacity(0.45),
      focusColor: Colors.blueGrey,
      iconDisabledColor: Colors.white,
      selectedItemBuilder: (context) {
        return items.map((item) {
          return Container(
            alignment: Alignment.center,
            child: Text(item,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                  overflow: TextOverflow.clip,
                )),
          );
        }).toList();
      },
      value: valueChoose,
      onChanged: (newValue) {
        theCallback(newValue);
      },
      items: items.map((item) {
        print(item);
        return dropDownMenuItem(width: width, theValue: item, enabled: true);
      }).toList());
}

DropdownMenuItem dropDownMenuItem(
    {required String theValue, required bool enabled, required double width}) {
  return DropdownMenuItem(
      value: theValue,
      enabled: enabled,
      child: SizedBox(
        width: width,
        child: Text(
          theValue,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ));
}
