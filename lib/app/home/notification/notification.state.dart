part of "notification.cubit.dart";


@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();

  @override
  List<Object> get props => [];
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();

  @override
  List<Object> get props => [];
}

class NotificationUploading extends NotificationState {
  const NotificationUploading();

  @override
  List<Object> get props => [];
}

class ItemsNotificationLoaded extends NotificationState {
  final List<Notifications> notification;

  ItemsNotificationLoaded(this.notification);

  @override
  List<Object> get props => [notification];
}

class ItemsNotificationUploading extends NotificationState {
  const ItemsNotificationUploading();

  @override
  List<Object> get props => [];
}

class ItemsNotificationUploaded extends NotificationState {
  const ItemsNotificationUploaded();

  @override
  List<Object> get props => [];
}

class CountLoading extends NotificationState {
  const CountLoading();

  @override
  List<Object> get props => [];
}

class CountLoaded extends NotificationState {
  final int countNotification;

  CountLoaded(this.countNotification);

  @override
  List<Object> get props => [countNotification];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object> get props => [message];
}
