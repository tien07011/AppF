import 'package:app_tv/model/notification/notification.dart';
import 'package:app_tv/repositories/notification/notification.repositories.dart';
import 'package:app_tv/utils/api.dart';
import 'package:app_tv/utils/exception.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'notification.state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepositories _notificationRepositories;

  NotificationCubit(this._notificationRepositories) : super(NotificationInitial()) {
//    loadData();
  }

  IO.Socket socket;
  List<Notifications> notifications;
  int count;
  int tak = 10;

  void pull() {
    tak += 10;
    loadData(take: tak);
  }

  void reset() {
    tak = 10;
  }

  Future<void> loadData({int take = 10}) async {
    Map<String, dynamic> params = {"skip": 0, "take": take};
    try {
      emit(NotificationLoading());
      ListNotification _list = await _notificationRepositories.fetchListMember(params);
      notifications = _list.notifications;
      newNotificationCount();
      emit(ItemsNotificationLoaded(notifications));
    } on NetworkException {
      emit(NotificationError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> seenNotification(int _idNoti) async {
    Map<String, dynamic> params = {"id": _idNoti};
    try {
      await _notificationRepositories.seenNotification(params);
    } on NetworkException {
      emit(NotificationError("Couldn't fetch data. Is the device online?"));
    }
  }

  Future<void> newNotificationCount() async {
    try {
      emit(CountLoading());
      var _count = await _notificationRepositories.newNotificationCount();
      count = _count;
      emit(CountLoaded(_count));
    } on NetworkException {
      emit(NotificationError("Couldn't fetch data. Is the device online?"));
    }
  }

  IO.Socket createSocketConnection() {
    socket = IO.io(
        API.baseUrl,
        IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    print(socket.connected);
    print(socket.disconnected);
  }

  // Set Up Socket

  void setUpSocket() {
    print('setup');

    socket.on("connection", (e) {
      print('connected');
    });
    socket.on("NEW_ORDER", (e) {
      print('connected');
    });

//    socket.onconnect();
    socket.on('disconnect', (e) {
      print('disconnect');
    });
  }
}
