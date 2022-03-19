class AppSettings {
  AppSettings(this.isDeleteConfirm);
  AppSettings.init() {
    isDeleteConfirm = false;
  }

  late bool isDeleteConfirm;

  AppSettings copyWith({
    bool? isDeleteConfirm,
  }) {
    return AppSettings(
      isDeleteConfirm ?? this.isDeleteConfirm,
    );
  }
}
