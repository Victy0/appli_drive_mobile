import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/components/dialogs/dialog_info_appmon.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCenterPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const DataCenterPage({super.key, required this.onLanguageChange});

  @override
  DataCenterPageState createState() => DataCenterPageState();
}

class DataCenterPageState extends State<DataCenterPage>{
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _appmonReveleadedList = [];
  int _appmonInBdSize = 0;
  bool _seeAll = false;
  List<String> _appmonRevealedIdsUser = [];
  int _appmonReveleadedListSize = 0;
  bool _isLoading = true;
  
  _getAppmonReveleadedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> appmonRevealedIdsUser = prefs.getStringList('appmon_reveled_ids') ?? [];
    bool seeAllAppmon = prefs.getBool('see_all_appmon') ?? false;
    
    List<Map<String, dynamic>> result = [];
    if(appmonRevealedIdsUser.isNotEmpty) {
      result = await _databaseHelper.getAppmonCodeListToDataCenter(ids: appmonRevealedIdsUser, filterByIds: !seeAllAppmon);
    } 
    setState(() {
      _seeAll = seeAllAppmon;
      _appmonReveleadedList = result;
      _appmonInBdSize = result.length;
      _appmonRevealedIdsUser = appmonRevealedIdsUser;
      _appmonReveleadedListSize = appmonRevealedIdsUser.length;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getAppmonReveleadedList();
  }
  
  void _returnToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
          HomePage(onLanguageChange: widget.onLanguageChange, initSound: false),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  List<Widget> _buildGroupedList(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};

    for (var item in _appmonReveleadedList) {
      String gradeName = item['gradeName'];
      if (!groupedItems.containsKey(gradeName)) {
        groupedItems[gradeName] = [];
      }
      groupedItems[gradeName]!.add(item);
    }

    List<Widget> codeWidgets = [];
    groupedItems.forEach((gradeName, items) {
      codeWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TextWithWhiteShadow(
            text: AppLocalization.of(context).translate("appmons.grades.$gradeName"),
            fontSize: 22,
          ),
        ),
      );

      for (var item in items) {
        final isDisabled = !_appmonRevealedIdsUser.contains(item['id']);
        codeWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Opacity(
              opacity: isDisabled ? 0.3 : 1.0,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  leading: Image.asset(
                    "assets/images/apps/${item['id']}.png",
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    item['name'].toString().toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                  onTap: isDisabled ? null : () => _openAppmonDialog(item['code']),
                ),
              ),
            ),
          ),
        );
      }
    });
    return codeWidgets;
  }

  void _openAppmonDialog(String code) async {
    final result = await _databaseHelper.getAppmonByCode(code);
    if (!mounted) return;

    if (result != null) {
      showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (_) => DialogInfoAppmon(appmon: result, interface: "dataCenter"),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: appBarComponent(context),
      body: Stack(
        children: [
          const BackgroundImage(color: "blue"),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextWithWhiteShadow(
                      text: "$_appmonReveleadedListSize / ${_seeAll ? _appmonInBdSize : '?'}",
                      fontSize: 25,
                      align: "right",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildGroupedList(context),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          ClosePageButton(onLanguageChange: widget.onLanguageChange, onTap: _returnToHomePage),
        ],
      ),
    );
  }

  AppBar appBarComponent(context){
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 50, 172, 253),
              Color.fromARGB(255, 0, 38, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        AppLocalization.of(context).translate("pages.dataCenterPage.dataCenter"),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => (),
          icon: Image.asset(
            'assets/images/icons/book_box.png',
            height: 50,
            color: Colors.white,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          color: Colors.white,
          height: 2.0,
        ),
      ),
    );
  }
}
