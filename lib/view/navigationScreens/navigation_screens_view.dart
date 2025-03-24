import 'package:cabeleleila/app/theme.dart';
import 'package:cabeleleila/view/history/history_view.dart';
import 'package:cabeleleila/view/home/home_view.dart';
import 'package:cabeleleila/view/services/services_view.dart';
import 'package:flutter/material.dart';

class NavigationScreensView extends StatefulWidget {
  const NavigationScreensView({super.key});

  @override
  State<NavigationScreensView> createState() => _NavigationScreensViewState();
}

class _NavigationScreensViewState extends State<NavigationScreensView> {
  int initialPage = 1;
  late PageController pagecontroller;

  @override
  void initState() {
    super.initState();
    pagecontroller = PageController(initialPage: initialPage);
  }

  setActualPage(page) {
    setState(() {
      initialPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: pagecontroller,
        onPageChanged: setActualPage,
        children: [
          ServicesView(),
          HomeView(),
          HistoryView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: initialPage,
        backgroundColor: ColorSchemeManagerClass.colorPrimary,
        selectedItemColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: ColorSchemeManagerClass.colorSecondary,
        elevation: 0,
        useLegacyColorScheme: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service_rounded), label: 'Serviços'),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Histórico'),
        ],
        onTap: (page) {
          pagecontroller.animateToPage(
            page,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}