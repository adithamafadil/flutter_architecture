import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_architecture/state/lifecycle/lifecycle.dart';

class StateBuilder<T extends GetxController> extends GetBuilder<T> {
  StateBuilder({
    Key? key,
    required T init,
    required MyLifecycle container,
    required BuildContext context,
    required Widget Function(T) builder,
  }) : super(
          key: key,
          init: init,
          dispose: container.onDispose,
          initState: (controller) => WidgetsBinding.instance!.endOfFrame
              .then((_) => container.onReady(controller)),
          didChangeDependencies: container.onDidChangeDependencies,
          didUpdateWidget: container.onDidUpdateWidget,
          builder: builder,
        );
}
