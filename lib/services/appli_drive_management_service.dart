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
        if(!canApplinkSameGrade){
          return null;
        }
        return currentAppmonAppliare..fusioned = null;
      }

      // Caso seja um código de fusão
      if (fusion != null && (fusion.appmonBase1 == code || fusion.appmonBase2 == code)) {
        final fusionAppmon = await databaseHelper.getAppmonByCode(fusion.id, ignoreRevealedField: true);
        if (fusionAppmon != null) {
          if(appliDriveVersion == 1) {
            updateAppliDriveVersion(2);
          }
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

  void updateAppliDriveVersion(int version) {
    preferencesService.setInt(AppPreferenceKey.appliDriveVersion, version);
  }
}
