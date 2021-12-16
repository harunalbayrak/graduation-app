import 'package:flutter/material.dart';
import 'package:graduation_app/constants/text_styles.dart';
import 'package:graduation_app/constants/env.dart';
import 'package:easy_localization/easy_localization.dart';

Widget popupMenuDots(BuildContext context) {
  return PopupMenuButton<String>(
    color: Colors.black87,
    icon: const Icon(appBarIconDots),
    onSelected: (String result) {
      switch (result) {
        case 'mm_dropdown_1':
          print('mm_dropdown_1');
          break;
        case 'mm_dropdown_2':
          print('mm_dropdown_2');
          break;
        case 'mm_dropdown_3':
          print('mm_dropdown_3');
          break;
        case 'mm_dropdown_4':
          print('mm_dropdown_4');
          break;
        case 'mm_dropdown_5':
          print('mm_dropdown_5');
          break;
        default:
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: 'mm_dropdown_1',
        child: Text('mm_dropdown_1'.tr(), style: textStyle2(15)),
      ),
      PopupMenuItem<String>(
        value: 'mm_dropdown_2',
        child: Text('mm_dropdown_2'.tr(), style: textStyle2(15)),
      ),
      PopupMenuItem<String>(
        value: 'mm_dropdown_3',
        child: Text('mm_dropdown_3'.tr(), style: textStyle2(15)),
      ),
      PopupMenuItem<String>(
        value: 'mm_dropdown_4',
        child: Text('mm_dropdown_4'.tr(), style: textStyle2(15)),
      ),
      PopupMenuItem<String>(
        value: 'mm_dropdown_5',
        child: Text('mm_dropdown_5'.tr(), style: textStyle2(15)),
      ),
    ],
  );
}
