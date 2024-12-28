import 'package:fcb_pay_aws/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_repository/hive_repository.dart';

import '../../../app/app.dart';
import '../../home/home.dart';
import '../dynamic_viewer.dart';

class DynamicViewerPage extends StatelessWidget {
  const DynamicViewerPage({super.key, required this.button});
  static final _hiveRepository = HiveRepository();
  final Button button;
  
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _hiveRepository,
      child: MultiBlocProvider(
        providers: [
          // inactivity cubit with event [resume timer] invoked
          BlocProvider(create: (context) => InactivityCubit()..resumeTimer()),
          // dropdown bloc 
          BlocProvider(create: (context) => DropdownBloc()),
          // accounts home bloc with event [accounts home load] invoked
          BlocProvider(create: (context) => AccountsHomeBloc(hiveRepository: _hiveRepository)
          ..add(AccountsHomeLoaded())),
          // widgets bloc with event [widgets load] invoked
          BlocProvider(create: (context) => WidgetsBloc(hiveRepository: _hiveRepository)
          ..add(WidgetsFetched(button.id))
          ..add(UserIdFetched()))
        ],
        child: DynamicViewerView(button: button)
      )
    );
  }
}