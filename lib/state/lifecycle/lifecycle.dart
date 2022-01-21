import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

abstract class MyLifecycle<T extends GetxController> extends StatelessWidget {
  final List<Worker> disposableWorkers = [];

  MyLifecycle({Key? key}) : super(key: key);

  void onReady(GetBuilderState<T> controller) {}

  void onDispose(GetBuilderState<T> controller) {
    for (Worker element in disposableWorkers) {
      element.dispose();
    }
  }

  void onDidChangeDependencies(GetBuilderState<T> controller) {}

  void onDidUpdateWidget(
    GetBuilder<GetxController> builder,
    GetBuilderState<T> controller,
  ) {}
}

extension WorkerExtension on Worker {
  void addTo(List<Worker> disposableWorkers) {
    disposableWorkers.add(this);
  }
}
