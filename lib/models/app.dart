const String tableApp = 'Apps';

class AppFields {
  static final List<String> values = [
    id,
    appName,
    packageName,
    version,
    allowWifi,
    allowMobileNetwork,
    isInWhitelist,
    notificationMode,
    totalActivities_7days
  ];

  static const String id = '_id';
  static const String appName = 'appName';
  static const String packageName = 'packageName';
  static const String version = 'version';
  static const String allowWifi = 'allowWifi';
  static const String allowMobileNetwork = 'allowMobileNetwork';
  static const String isInWhitelist = 'isInWhitelist';
  static const String notificationMode = 'notificationMode';
  static const String totalActivities_7days = 'totalActivities_7days';
}

class App {
  final int? id;
  final String appName;
  final String packageName;
  final String version;
  bool allowWifi;
  bool allowMobileNetwork;
  bool isInWhitelist;
  bool notificationMode;
  int totalActivities_7days;

  App({
    this.id,
    required this.appName,
    required this.packageName,
    required this.version,
    required this.allowWifi,
    required this.allowMobileNetwork,
    required this.isInWhitelist,
    required this.notificationMode,
    required this.totalActivities_7days,
  });

  Map<String, Object?> toJson() => {
        AppFields.id: id,
        AppFields.appName: appName,
        AppFields.packageName: packageName,
        AppFields.version: version,
        AppFields.allowWifi: allowWifi ? 1 : 0,
        AppFields.allowMobileNetwork: allowMobileNetwork ? 1 : 0,
        AppFields.isInWhitelist: isInWhitelist ? 1 : 0,
        AppFields.notificationMode: notificationMode ? 1 : 0,
        AppFields.totalActivities_7days: totalActivities_7days,
      };

  static App fromJson(Map<String, Object?> json) => App(
        id: json[AppFields.id] as int?,
        appName: json[AppFields.appName] as String,
        packageName: json[AppFields.packageName] as String,
        version: json[AppFields.version] as String,
        allowWifi: json[AppFields.allowWifi] == 1,
        allowMobileNetwork: json[AppFields.allowMobileNetwork] == 1,
        isInWhitelist: json[AppFields.isInWhitelist] == 1,
        notificationMode: json[AppFields.notificationMode] == 1,
        totalActivities_7days: json[AppFields.totalActivities_7days] as int,
      );

  App copy({
    int? id,
    String? appName,
    String? packageName,
    String? version,
    bool? allowWifi,
    bool? allowMobileNetwork,
    bool? isInWhitelist,
    bool? notificationMode,
    int? totalActivities_7days,
  }) =>
      App(
        id: id ?? this.id,
        appName: appName ?? this.appName,
        packageName: packageName ?? this.packageName,
        version: version ?? this.version,
        allowWifi: allowWifi ?? this.allowWifi,
        allowMobileNetwork: allowMobileNetwork ?? this.allowMobileNetwork,
        isInWhitelist: isInWhitelist ?? this.isInWhitelist,
        notificationMode: notificationMode ?? this.notificationMode,
        totalActivities_7days:
            totalActivities_7days ?? this.totalActivities_7days,
      );
}
