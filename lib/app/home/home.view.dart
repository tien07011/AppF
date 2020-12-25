import 'package:app_tv/app/home/customer/customer.view.dart';
import 'package:app_tv/app/home/home-page/home-page.view.dart';
import 'package:app_tv/app/home/library/library.view.dart';
import 'package:app_tv/app/home/notification/notification.cubit.dart';
import 'package:app_tv/app/home/notification/notification.view.dart';
import 'package:app_tv/app/home/search/search.view.dart';
import 'package:app_tv/repositories/notification/notification.repositories.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  NotificationCubit cubit = NotificationCubit(NotificationRepositories());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    cubit.createSocketConnection();
//    cubit.setUpSocket();
//    IO.Socket socket = IO.io(
//        API.baseUrl,
//        IO.OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
//            .build());
//    socket.on('connect', (_) {
//      print(socket.connected);
//      print('connect');
//    });
//    socket.on('disconnect', (_) => print('disconnected + ${socket.disconnected}'));
    cubit.newNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: SizeConfig.blockSizeVertical * 8,
            backgroundColor: Colors.teal,
            bottom: TabBar(
              labelPadding: EdgeInsets.zero,
              isScrollable: true,
              indicatorWeight: 3.0,
              unselectedLabelColor: Color(0xFFF1F1F1),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeVertical * 7,
                  child: Icon(
                    Icons.house,
                    size: 30,
                  ),
                )),
                Tab(
                    icon: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeVertical * 7,
                  child: Icon(
                    Icons.library_books,
                    size: 30,
                  ),
                )),
                Tab(
                    icon: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeVertical * 7,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.notifications_none_outlined, size: 30),
                      // Todo: Implement notification
                      BlocBuilder<NotificationCubit, NotificationState>(
                        cubit: cubit,
                        buildWhen: (previous, now) => now is CountLoaded,
                        builder: (context, state) {
                          if (state is CountLoaded) {
                            return cubit.count > 0
                                ? Positioned(
                                    right: SizeConfig.safeBlockHorizontal * 6,
                                    top: SizeConfig.safeBlockVertical * 1.5,
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                                      constraints: BoxConstraints(maxWidth: 14, maxHeight: 14),
                                      child: Center(
                                        child:
                                            Text("${cubit.count}", style: TextStyle(color: Colors.white, fontSize: 11)),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          } else if (state is NotificationError) {
                            return SizedBox();
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                )),
                Tab(
                    icon: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeVertical * 7,
                  child: Icon(
                    Icons.search,
                    size: 30,
                  ),
                )),
                Tab(
                    icon: SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 20,
                  height: SizeConfig.blockSizeVertical * 7,
                  child: Icon(
                    Icons.list,
                    size: 30,
                  ),
                )),
              ],
            ),
            bottomOpacity: 1,
          ),
          body: TabBarView(
            children: [
              HomePage(),
              Library(),
              NotificationApp(cubit: cubit,),
              Search(),
              Customer(),
            ],
          ),
        ),
      ),
    );
  }
}
