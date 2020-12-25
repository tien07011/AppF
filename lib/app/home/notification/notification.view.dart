import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/app/home/notification/notification.cubit.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationApp extends StatefulWidget {
  final NotificationCubit cubit;

  const NotificationApp({this.cubit}) : super();

  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // ignore: avoid_void_async
  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  // ignore: avoid_void_async
  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    widget.cubit.pull();
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.cubit.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   height: SizeConfig.blockSizeVertical * 100,
        //   child: Image.asset(
        //     'assets/login.jpg',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        BlocBuilder<NotificationCubit, NotificationState>(
          cubit: widget.cubit,
          buildWhen: (previous, now) => now is ItemsNotificationLoaded,
          builder: (context, state) {
            if (state is ItemsNotificationLoaded) {
              return _getBody();
            } else if (state is NotificationError) {
              return Center(child: Text(state.message));
            } else {
              return Container(
                  height: SizeConfig.blockSizeVertical * 50,
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(radius: 20));
            }
          },
        ),
      ],
    );
  }

  Widget _getBody() {
    return Scrollbar(
      child: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropMaterialHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus status) {
            Widget body;
            if (status == LoadStatus.idle) {
              body = SizedBox();
            } else if (status == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (status == LoadStatus.failed) {
              body = Text("");
            } else if (status == LoadStatus.canLoading) {
              body = Text("");
            } else {
              body = Text("");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        onRefresh: onRefresh,
        onLoading: onLoading,
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(widget.cubit.notifications.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    color: (widget.cubit.notifications.elementAt(index).isSeen == 1) ? Colors.white : Color(0xFFF1F1F1),
                    onPressed: () {
                      widget.cubit.seenNotification(widget.cubit.notifications.elementAt(index).notification_id);

                      Modular.link
                          .pushNamed(HomeModule.comment,
                              arguments: widget.cubit.notifications.elementAt(index).notification_posterId)
                          .then((value) => widget.cubit.loadData());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: SizeConfig.blockSizeVertical * 100,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 10),
                                child: CircleAvatar(
                                  radius: SizeConfig.blockSizeHorizontal * 6,
                                  backgroundImage:
                                      NetworkImage('${widget.cubit.notifications.elementAt(index).userCreate_avatar}'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal * 80,
                                      child: Row(
                                        children: [
                                          Text(
                                            "${widget.cubit.notifications.elementAt(index).userCreate_name}  ",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                          Expanded(
                                              child: Text(
                                                  "${widget.cubit.notifications.elementAt(index).notification_context}"))
                                        ],
                                      ),
                                    ),
                                    Text((widget.cubit.notifications
                                                .elementAt(index)
                                                .notification_creat_at
                                                .difference(DateTime.now())
                                                .inDays !=
                                            0)
                                        ? "${widget.cubit.notifications.elementAt(index).notification_creat_at.difference(DateTime.now()).inDays * -1} ngày trước"
                                        : (widget.cubit.notifications
                                                    .elementAt(index)
                                                    .notification_creat_at
                                                    .difference(DateTime.now())
                                                    .inHours !=
                                                0)
                                            ? "${widget.cubit.notifications.elementAt(index).notification_creat_at.difference(DateTime.now()).inHours * -1} giờ trước"
                                            : "${widget.cubit.notifications.elementAt(index).notification_creat_at.difference(DateTime.now()).inMinutes * -1} phút trước"),
                                    // Text("${cubit.notifications.elementAt(index).notification_creat_at}")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
