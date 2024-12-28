import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/utils.dart';
import '../notifications.dart';
import 'widgets.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ShimmerListTile(),
          );
        }
        if (state.status.isSuccess) {
          final notifications = state.notifications;
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemCount: notifications.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final isRead = notification.isRead;
                
                return Container(
                  color: isRead! ? const Color.fromARGB(15, 0, 0, 0) : null,
                  child: ListTile(
                    key: ValueKey(notification),
                    leading: isRead
                    ? const Icon(FontAwesomeIcons.solidEnvelope, color: Color.fromARGB(193, 76, 175, 79))
                    : const Badge(
                      largeSize: 8,
                      smallSize: 8,
                      child: Icon(FontAwesomeIcons.solidEnvelope),
                    ),
                    title: Text(
                      notification.sender!,
                      style: TextStyle(
                        color: isRead ? Colors.black54 : Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    subtitle: Text(
                      notification.content!,
                      style: TextStyle(
                        color: isRead ? Colors.black54 : Colors.black87,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12
                      )
                    ),
                    trailing: Text(
                      getDynamicDateString(notification.createdAt!.getDateTimeInUtc()),
                      style: TextStyle(
                        color: isRead ? Colors.black54 : Colors.black87,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12
                      )
                    ),
                    horizontalTitleGap: 5,
                    selected: true,
                    selectedColor: Colors.green,
                    onTap: () {
                      context.read<NotificationsBloc>().add(NotificationsUpdateIsRead(notification));
                      context.pushNamed(RouteName.notificationViewer, pathParameters: {'id' : notification.id});
                    }
                  )
                );
              }
            )
          );
        }
        if (state.status.isFailure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w700
                )
              )
            ),
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}