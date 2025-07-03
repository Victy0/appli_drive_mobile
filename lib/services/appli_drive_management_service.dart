import 'package:appli_drive_mobile/enums/app_preferences_key.dart';
import 'package:appli_drive_mobile/models/appmon.dart';
import 'package:appli_drive_mobile/services/database_helper_service.dart';
import 'package:appli_drive_mobile/services/preferences_service.dart';

class AppliDriveManagementService {
  final DatabaseHelper databaseHelper;
  final PreferencesService preferencesService;

  AppliDriveManagementService({
    required this.databaseHelper,
    required this.preferencesService,
  });

  bool _isPossibleApplinkSameGrade(int appliDriveVersion, int grade) {
    if(appliDriveVersion == 2 && grade >= 2) {
      return false;
    }
    return true;
  }

  Future<Appmon?> apliariseOrApplinkByCode(
    String code,
    Appmon? currentAppmonAppliare,
    int appliDriveVersion,
  ) async {
    // APPLINK
    if (currentAppmonAppliare != null) {
      final fusion = currentAppmonAppliare.fusionInfo;
      final bool canApplinkSameGrade = _isPossibleApplinkSameGrade(appliDriveVersion, currentAppmonAppliare.grade.id);

      // Caso o código seja o mesmo do Appmon atual
      if (currentAppmonAppliare.code == code) {
        // Verificar se applink pode ser realizado entre mesmo nível
        if(!canApplinkSameGrade) {
          return null;
        }
        return currentAppmonAppliare..fusioned = null;
      }

      // Caso seja um código de fusão
      if (fusion != null && (fusion.appmonBase1 == code || fusion.appmonBase2 == code)) {
        final fusionAppmon = await databaseHelper.getAppmonByCode(fusion.id, ignoreRevealedField: true);
        if (fusionAppmon != null) {
          List<String> idsToSetRevealed = [fusionAppmon.id];
          if(appliDriveVersion == 1) {
            updateAppliDriveVersion(2);
            idsToSetRevealed = idsToSetRevealed + [
              "D7I3",
              "D9M6",
              "D1S2",
              "D4V4",
            ];
          }
          revealAppmons(idsToSetRevealed);
          fusionAppmon.fusioned = true;
          return fusionAppmon;
        }
      }

      final resultAppmon = await databaseHelper.getAppmonByCode(code);

      if(resultAppmon != null) {
        // Caso applink seja com appmon mais evoluido que atual
        if(currentAppmonAppliare.grade.id < resultAppmon.grade.id) {
          return null;
        }

        // Verificar se applink pode ser realizado entre mesmo nível
        if(currentAppmonAppliare.grade.id == resultAppmon.grade.id) {
          if(!canApplinkSameGrade){
            return null;
          }
        }
      }
    }

    // APPLIARISE
    return await databaseHelper.getAppmonByCode(code);
  }

  Map<String, String> getAppmonBuddyInformation(String appmon) {
    String name = "";
    String primaryColor = "";
    String secondaryColor = "";
    Map<String, String> info = {};
    List<String> appmonsToReveal = ["D8F3", "D5H7"];
    switch(appmon) {
      case "0.true":  // GATCHMON
        name = "gatchmon";
        info = {"id": "D1Y8", "code": "AAA"};
        primaryColor = "red";
        secondaryColor = "blue";
        appmonsToReveal = appmonsToReveal +[
          "D1Y8",
          "D3S9",
          "D5U5",
        ];
        break;
      case "0.false":  // KOSOMON
        name = "kosomon";
        info = {"id": "D8I0", "code": "ELA"};
        primaryColor = "blue";
        secondaryColor = "pink";
        appmonsToReveal = appmonsToReveal + [
          "D8I0",
          "D6T0",
          "D0A9",
        ];
        break;
      case "1.true":  // DOKAMON
        name = "dokamon";
        info = {"id": "D5S7", "code": "CKA"};
        primaryColor = "blue";
        secondaryColor = "grey";
        appmonsToReveal = appmonsToReveal + [
          "D5S7",
          "D3Y0",
          "D5P7",
        ];
        break;
      case "1.false":  // DRESSMON
        name = "dressmon";
        info = {"id": "D5V7", "code": "BHA"};
        primaryColor = "grey";
        secondaryColor = "pink";
        appmonsToReveal = appmonsToReveal + [
          "D5V7",
          "D1G7",
          "D8X4",
        ];
        break;
      case "2.true":  // MUSIMON
        name = "musimon";
        info = {"id": "D6R3", "code": "BEA"};
        primaryColor = "yellow";
        secondaryColor = "orange";
        appmonsToReveal = appmonsToReveal + [
          "D6R3",
          "D4E6",
          "D9M2",
        ];
        break;
      case "2.false":  // GENGOMON
        name = "gengomon";
        info = {"id": "D0Z8", "code": "AFA"};
        primaryColor = "purple";
        secondaryColor = "yellow";
        appmonsToReveal = appmonsToReveal + [
          "D0Z8",
          "D2C6",
          "D2U1",
        ];
        break;
      case "3.true":  // AIDMON
        name = "aidmon";
        info = {"id": "D8B1", "code": "BRA"};
        primaryColor = "white";
        secondaryColor = "pink";
        appmonsToReveal = appmonsToReveal + [
          "D8B1",
          "D8T4",
          "D7O3",
        ];
        break;
      case "3.false":  // HACKMON
        name = "hackmon";
        info = {"id": "D9B2", "code": "ATA"};
        primaryColor = "black";
        secondaryColor = "red";
        appmonsToReveal = appmonsToReveal + [
          "D9B2",
          "D0B0",
          "D3A7",
        ];
        break;
      case "4.true":  // ONMON
        name = "onmon";
        info = {"id": "D1V2", "code": "EQB"};
        primaryColor = "white";
        secondaryColor = "cyan";
        appmonsToReveal = appmonsToReveal + [
          "D1V2",
          "D7J5",
          "D4F1",
        ];
        break;
      case "4.false":  // OFFMON
        name = "offmon";
        info = {"id": "D2U8", "code": "ERA"};
        primaryColor = "grey";
        secondaryColor = "red";
        appmonsToReveal = appmonsToReveal + [
          "D2U8",
          "D6R9",
          "D7E8",
        ];
        break;
    }
    revealAppmons(appmonsToReveal);
    pairBuddyAppmon(
      name,
      info,
      primaryColor,
      secondaryColor,
      isFirstBuddy: true,
    );
    info.addAll({"name": name, "color": primaryColor});
    return info;
  }

  void pairBuddyAppmon(
    String name,
    Map<String, String> appmonEvolutionInfo,
    String primaryColor,
    String secondaryColor,
    {bool isFirstBuddy = false}
  ) {
    if(isFirstBuddy){
      updateAppliDriveVersion(1);
    }
    preferencesService.setString(AppPreferenceKey.appmonPairingName, name);
    preferencesService.setAppmonPairingEvolutionInfo(appmonEvolutionInfo);
    preferencesService.setString(AppPreferenceKey.primaryColor, primaryColor);
    preferencesService.setString(AppPreferenceKey.secondaryColor, secondaryColor);
  }

  void revealAppmons(List<String> appmonIds) {
    databaseHelper.setRevealedAppmonsForIds(appmonIds);
  }

  void setAppmonReveleadedId(String appmonId, bool tutorialFinished) {
    preferencesService.setStringInStringList(
      AppPreferenceKey.appmonRevealedIds,
      appmonId,
    );
    if(!tutorialFinished) {
      preferencesService.setBool(
        AppPreferenceKey.tutorialFinished,
        true
      );
      preferencesService.setHintInHintRevealedList("appmon", "1");
      preferencesService.setHintInHintRevealedList("appmon", "2");
      preferencesService.setHintInHintRevealedList("appliDrive", "1");
      preferencesService.setHintInHintRevealedList("7code");
    }
  }

  void updateAppliDriveVersion(int version) {
    preferencesService.setInt(AppPreferenceKey.appliDriveVersion, version);
  }
}
