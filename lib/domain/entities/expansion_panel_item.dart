class ExpansionPanelItem {
  final String headerText;
  final String expandedText;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });
}
