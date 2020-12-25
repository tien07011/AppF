import 'package:app_tv/app/home/customer/information/infor.view.dart';
import 'package:app_tv/app/home/customer/pass/pass.view.dart';
import 'package:app_tv/app/home/customer/pass/reset-info.view.dart';
import 'package:app_tv/app/home/home-page/post/post.cubit.dart';
import 'package:app_tv/app/home/home-page/comment/comment.view.dart';
import 'package:app_tv/app/home/home.view.dart';
import 'package:app_tv/app/home/library/member/member-info/member-info.view.dart';
import 'package:app_tv/app/home/library/member/member.cubit.dart';
import 'package:app_tv/app/home/library/member/member.view.dart';
import 'package:app_tv/app/home/library/member/new-member/new-member.view.dart';
import 'package:app_tv/app/home/library/nhap-lieu/input.view.dart';
import 'package:app_tv/app/home/library/nhap-lieu/sach/book-info/book-info.view.dart';
import 'package:app_tv/app/home/library/nhap-lieu/sach/list-book.cubit.dart';
import 'package:app_tv/app/home/library/nhap-lieu/sach/new-book/new-book.view.dart';
import 'package:app_tv/app/home/search/borrow-give/borrow-book.view.dart';
import 'package:app_tv/app/home/search/borrow-give/give-book.view.dart';
import 'package:app_tv/app/home/search/search.cubit.dart';
import 'package:app_tv/model/library/list_book.dart';
import 'package:app_tv/model/member/list_member.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home-page/post/post.view.dart';

class HomeModule extends ChildModule {
  static Inject get to => Inject<HomeModule>.of();
  static String inputView = "/input";
  static String inforView = "/infor";
  static String newBook = "/new-book";
  static String member = "/member";
  static String newMember = "/new-member";
  static String memberInfo = "/member-info";
  static String borrowBook = "/borrow";
  static String giveBook = "/give";
  static String search = "/search";
  static String bookInfo = "/book-info";
  static String postStatus = "/post-status";
  static String passView = "/pass";
  static String comment = "/comment/";
  static String resetInfo = "/reset-info";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => HomeWidget()),
        ModularRouter(inputView, child: (context, args) => InputView()),
        ModularRouter(newBook, child: (context, args) => NewBookView(cubit: args.data as ListBookCubit)),
        ModularRouter(inforView, child: (context, args) => InforView()),
        ModularRouter(member, child: (context, args) => MemberView()),
        ModularRouter(postStatus, child: (context, args) => PostView(cubit: args.data as PostCubit)),
        ModularRouter(newMember, child: (context, args) => NewMemberView(cubit: args.data as MemberCubit)),
        ModularRouter(memberInfo, child: (context, args) => MemberInfoView(member: args.data as Member)),
        ModularRouter(borrowBook, child: (context, args) => BorrowBookView(cubit: args.data as SearchCubit)),
        ModularRouter(giveBook, child: (context, args) => GiveBookView(cubit: args.data as SearchCubit)),
        ModularRouter(bookInfo, child: (context, args) => BookInfoView(book: args.data as Book)),
        ModularRouter(passView, child: (context, args) => PassView()),
        ModularRouter(resetInfo, child: (context, args) => ResetInfoView()),
        ModularRouter(comment, child: (context, args) => CommentView(idPost: args.data as int,)),
      ];
}
