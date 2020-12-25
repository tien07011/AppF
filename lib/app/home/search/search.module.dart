import 'package:app_tv/app/home/search/borrow-give/borrow-book.view.dart';
import 'package:app_tv/app/home/search/borrow-give/give-book.view.dart';
import 'package:app_tv/app/home/search/search.view.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchModule extends ChildModule {
  static Inject get to => Inject<SearchModule>.of();
  static String borrowBook = "/borrow";
  static String giveBook = "/give";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => Search()),
        ModularRouter(borrowBook, child: (context, args) => BorrowBookView()),
        ModularRouter(giveBook, child: (context, args) => GiveBookView()),
      ];
}
