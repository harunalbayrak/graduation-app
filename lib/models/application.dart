const String tableApplication = 'applications';

class ApplicationFields {
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
}
