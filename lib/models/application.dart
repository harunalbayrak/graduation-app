const String tableApplication = 'applications';

class ApplicationFields {
  static final List<String> values = [
    id,
    packageName,
    version,
    allowWifi,
    allowMobileNetwork,
    isInWhitelist,
    notificationMode,
    totalActivities_7days
  ];

  static const String id = '_id';
  static const String packageName = 'packageName';
  static const String version = 'version';
  static const String allowWifi = 'allowWifi';
  static const String allowMobileNetwork = 'allowMobileNetwork';
  static const String isInWhitelist = 'isInWhitelist';
  static const String notificationMode = 'notificationMode';
  static const String totalActivities_7days = 'totalActivities_7days';
}

class Application {
  final int? id;
  final String packageName;
  final String version;
  bool allowWifi;
  bool allowMobileNetwork;
  bool isInWhitelist;
  bool notificationMode;
  int totalActivities_7days;

  Application({
    this.id,
    required this.packageName,
    required this.version,
    required this.allowWifi,
    required this.allowMobileNetwork,
    required this.isInWhitelist,
    required this.notificationMode,
    required this.totalActivities_7days,
  });

  Map<String, Object?> toJson() => {
        ApplicationFields.id: id,
        ApplicationFields.packageName: packageName,
        ApplicationFields.version: version,
        ApplicationFields.allowWifi: allowWifi ? 1 : 0,
        ApplicationFields.allowMobileNetwork: allowMobileNetwork ? 1 : 0,
        ApplicationFields.isInWhitelist: isInWhitelist ? 1 : 0,
        ApplicationFields.notificationMode: notificationMode ? 1 : 0,
        ApplicationFields.totalActivities_7days: totalActivities_7days,
      };

  static Application fromJson(Map<String, Object?> json) => Application(
        id: json[ApplicationFields.id] as int?,
        packageName: json[ApplicationFields.packageName] as String,
        version: json[ApplicationFields.version] as String,
        allowWifi: json[ApplicationFields.allowWifi] == 1,
        allowMobileNetwork: json[ApplicationFields.allowMobileNetwork] == 1,
        isInWhitelist: json[ApplicationFields.isInWhitelist] == 1,
        notificationMode: json[ApplicationFields.notificationMode] == 1,
        totalActivities_7days:
            json[ApplicationFields.totalActivities_7days] as int,
      );

  Application copy({
    int? id,
    String? packageName,
    String? version,
    bool? allowWifi,
    bool? allowMobileNetwork,
    bool? isInWhitelist,
    bool? notificationMode,
    int? totalActivities_7days,
  }) =>
      Application(
        id: id ?? this.id,
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
