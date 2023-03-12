import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icare_mobile/application/core/colors.dart';
import 'package:icare_mobile/application/core/spaces.dart';
import 'package:icare_mobile/application/core/text_styles.dart';
import 'package:icare_mobile/domain/entities/expansion_panel_item.dart';
import 'package:icare_mobile/domain/value_objects/app_strings.dart';
import 'package:icare_mobile/domain/value_objects/svg_asset_strings.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<ExpansionPanelItem> _helpItems = [
    ExpansionPanelItem(
      headerText: 'Book  new Appointment',
      expandedText:
          'Book a new appointment involves a few easy steps, find a doctor you like and tap on the book button',
    ),
    ExpansionPanelItem(
      headerText: 'Book  new Appointment',
      expandedText:
          'Book a new appointment involves a few easy steps, find a doctor you like and tap on the book button',
    ),
    ExpansionPanelItem(
      headerText: 'Book  new Appointment',
      expandedText:
          'Book a new appointment involves a few easy steps, find a doctor you like and tap on the book button',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          helpString,
          style: boldSize16Text(AppColors.blackColor),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
        shadowColor: AppColors.primaryColor.withOpacity(0.25),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 270,
                    height: 170,
                    child: FittedBox(
                      child: SvgPicture.asset(donutLoveSvg),
                    ),
                  ),
                ),
                mediumVerticalSizedBox,
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _helpItems[index].isExpanded = !isExpanded;
                    });
                  },
                  children: _helpItems.map<ExpansionPanel>((helpItem) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(helpItem.headerText),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(helpItem.expandedText),
                      ),
                    
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
