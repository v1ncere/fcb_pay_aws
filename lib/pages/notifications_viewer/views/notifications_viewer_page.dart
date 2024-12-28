import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notifications_viewer.dart';

class NotificationsViewerPage extends StatelessWidget {
  const NotificationsViewerPage({super.key, required this.id});
  final String? id;
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotificationsViewerBloc()
        ..add(NotificationViewerLoaded(id ?? ''))),
      ],
      child: NotificationsViewerView(args: id ?? ''),
    );
  }
}