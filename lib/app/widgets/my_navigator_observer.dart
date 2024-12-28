import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('push route: $route from: $previousRoute');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint('pop route: $route from: $previousRoute');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint('remove route: $route from: $previousRoute');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint('replace route: $newRoute from: $oldRoute');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}