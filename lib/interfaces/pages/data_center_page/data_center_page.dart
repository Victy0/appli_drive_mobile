import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/interfaces/components/background_image.dart';
import 'package:appli_drive_mobile/interfaces/components/close_page_button.dart';
import 'package:appli_drive_mobile/interfaces/components/custom_app_bar.dart';
import 'package:appli_drive_mobile/interfaces/components/text_with_white_shadow.dart';
import 'package:appli_drive_mobile/interfaces/pages/data_center_page/components/grouped_list.dart';
import 'package:appli_drive_mobile/localizations/app_localization.dart';
import 'package:appli_drive_mobile/interfaces/pages/home_page/home_page.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';
import 'package:flutter/material.dart';

class DataCenterPage extends StatefulWidget {
  final Function(Locale) onLanguageChange;
  const DataCenterPage({super.key, required this.onLanguageChange});

  @override
  DataCenterPageState createState() => DataCenterPageState();
}

class DataCenterPageState extends State<DataCenterPage>{
  final PreferencesService _preferencesService = PreferencesService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _appmonReveleadedList = [];
  int _appmonInBdSize = 0;
  bool _seeAll = false;
  List<String> _appmonRevealedIdsUser = [];
  int _appmonReveleadedListSize = 0;
  bool _isLoading = true;
  
  _getAppmonRevealedList() async {
    List<String> appmonRevealedIdsUser = await _preferencesService.getStringList(
      AppPreferenceKey.appmonRevealedIds,
    );
    bool seeAllAppmon = await _preferencesService.getBool(
      AppPreferenceKey.seeAllAppmons,
    );
    
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
    _getAppmonRevealedList();
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
  
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: CustomAppBar(
        titleText: AppLocalization.of(context).translate("pages.dataCenterPage.dataCenter"),
        image: "assets/images/icons/book_box.png",
        backgroundColor: const [
          Color.fromARGB(255, 50, 172, 253),
          Color.fromARGB(255, 0, 38, 255),
        ],
        textBlack: false,
      ),
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
                  child: GroupedList(
                    databaseHelper: _databaseHelper,
                    appmonReveleadedList: _appmonReveleadedList,
                    appmonRevealedIdsUser: _appmonRevealedIdsUser,
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
}
