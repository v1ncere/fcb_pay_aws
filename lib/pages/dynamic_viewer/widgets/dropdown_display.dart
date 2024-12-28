import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ModelProvider.dart';
import '../dynamic_viewer.dart';
import 'widgets.dart';

class DropdownDisplay extends StatelessWidget {
  const DropdownDisplay({super.key, required this.pageWidget, required this.focusNode});
  final DynamicWidget pageWidget;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    if(_isUserAccount(pageWidget)) {
      return SourceDropdown(focusNode: focusNode, widget: pageWidget);
    } else {
      _fetchDropdown(context, pageWidget);
      return Column(
        children: [
          DynamicDropdown(focusNode: focusNode, widget: pageWidget),
          if (pageWidget.hasExtra == true) const ExtraWidgets()
        ]
      );
    }
  }

  // utility methods
  // search for the node 
  bool _isUserAccount(DynamicWidget widget) => widget.node!.contains('user_account');
  
  void _fetchDropdown(BuildContext context, DynamicWidget widget) {
    final uid = context.select((WidgetsBloc bloc) => bloc.state.uid);
    // reference base on the 'dynamic_viewer_widget' child 'node'
    final reference = widget.node!.replaceAll('{id}', uid);
    context.read<DropdownBloc>().add(DropdownFetched(reference));
  }
}