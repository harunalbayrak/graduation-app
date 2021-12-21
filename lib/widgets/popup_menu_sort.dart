import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:graduation_app/utils/enums.dart';
import 'package:easy_localization/easy_localization.dart';

Widget popupMenuSort(BuildContext context, Sort? _sort) {
  return PopupMenuButton<String>(
    color: Colors.black87,
    icon: const Icon(appBarIconSort),
    onSelected: (String result) {
      switch (result) {
        case 'mm_dropdown_1':
          _sort = Sort.name;
          break;
        case 'mm_dropdown_2':
          _sort = Sort.other;
          break;
        default:
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem(
        value: 'mm_dropdown_1',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<Sort>(
              value: Sort.name,
              activeColor: appBarDropdownActiveColor,
              groupValue: _sort,
              onChanged: (Sort? value) {
                _sort = value;
              },
            ),
            Text('sort_dropdown_1'.tr(), style: textStyle2(15)),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'mm_dropdown_2',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio<Sort>(
              value: Sort.other,
              activeColor: appBarDropdownActiveColor,
              groupValue: _sort,
              onChanged: (Sort? value) {
                _sort = value;
              },
            ),
            Text('sort_dropdown_2'.tr(), style: textStyle2(15)),
          ],
        ),
      ),
    ],
  );
}
