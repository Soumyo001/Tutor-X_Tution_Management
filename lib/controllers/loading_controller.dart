typedef UpdateLoadingScreen = bool Function(String);
typedef CloseLoadingScreen = bool Function();

class LoadingController {
  final UpdateLoadingScreen updateLoadingScreen;
  final CloseLoadingScreen closeLoadingScreen;
  const LoadingController({
    required this.updateLoadingScreen,
    required this.closeLoadingScreen,
  });
}
