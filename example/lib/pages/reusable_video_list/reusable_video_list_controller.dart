import 'package:better_player_plus/better_player_plus.dart';
import 'package:collection/collection.dart' show IterableExtension;

class ReusableVideoListController {
  final List<BetterPlayerController> _betterPlayerControllerRegistry = [];
  final List<BetterPlayerController> _usedBetterPlayerControllerRegistry = [];

  ReusableVideoListController();

  void register(int total) {
    for (int index = 0; index < total; index++) {
      final controller = BetterPlayerController(
        BetterPlayerConfiguration(handleLifecycle: false, autoDispose: false),
      );
      _betterPlayerControllerRegistry.add(controller);
    }
  }

  BetterPlayerController? getBetterPlayerController() {
    final freeController = _betterPlayerControllerRegistry.firstWhereOrNull((controller) {
      return !_usedBetterPlayerControllerRegistry.contains(controller);
    });

    if (freeController != null) {
      _usedBetterPlayerControllerRegistry.add(freeController);
    }

    return freeController;
  }

  void freeBetterPlayerController(BetterPlayerController? betterPlayerController) {
    _usedBetterPlayerControllerRegistry.remove(betterPlayerController);
  }

  void dispose() {
    for (var controller in _betterPlayerControllerRegistry) {
      controller.dispose();
    }
  }
}
