import 'package:flame_test/flame_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_endless_runner/app_lifecycle/app_lifecycle.dart';
import 'package:flutter_endless_runner/audio/audio_controller.dart';
import 'package:flutter_endless_runner/audio/sounds.dart';
import 'package:flutter_endless_runner/flame_game/endless_runner.dart';
import 'package:flutter_endless_runner/flame_game/game_screen.dart';
import 'package:flutter_endless_runner/main.dart';
import 'package:flutter_endless_runner/player_progress/persistence/memory_player_progress_persistence.dart';
import 'package:flutter_endless_runner/player_progress/player_progress.dart';
import 'package:flutter_endless_runner/settings/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test menus', (tester) async {
    // Build our game and trigger a frame.
    await tester.pumpWidget(const MyGame());

    // Verify that the '开始游戏' button is shown.
    expect(find.text('开始游戏'), findsOneWidget);

    // Verify that the '设置' button is shown.
    expect(find.text('设置'), findsOneWidget);

    // Go to '设置'.
    await tester.tap(find.text('设置').first);
    await tester.pumpAndSettle();
    expect(find.text('音乐'), findsOneWidget);

    // Go back to main menu.
    await tester.tap(find.text('返回'));
    await tester.pumpAndSettle();

    // Tap '开始游戏'.
    await tester.tap(find.text('开始游戏'));
    await tester.pumpAndSettle();
    expect(find.text('选择关卡'), findsOneWidget);

    // Tap level 1.
    await tester.tap(find.text('第 1 关'));
    await tester.pump();
  });

  testWithGame(
    'smoke test flame game',
    () {
      return EndlessRunner(
        level: (number: 1, winScore: 3, canSpawnTall: false),
        playerProgress: PlayerProgress(
          store: MemoryOnlyPlayerProgressPersistence(),
        ),
        audioController: _MockAudioController(),
      );
    },
    (game) async {
      game.overlays.addEntry(
        GameScreen.backButtonKey,
        (context, game) => Container(),
      );
      game.overlays.addEntry(
        GameScreen.winDialogKey,
        (context, game) => Container(),
      );
      await game.onLoad();
      game.update(0);
      expect(game.children.length, 3);
      expect(game.world.children.length, 2);
      expect(game.camera.viewport.children.length, 2);
      expect(game.world.player.isLoading, isTrue);
    },
  );
}

class _MockAudioController implements AudioController {
  @override
  void attachDependencies(
    AppLifecycleStateNotifier lifecycleNotifier,
    SettingsController settingsController,
  ) {}

  @override
  void dispose() {}

  @override
  void playSfx(SfxType type) {}
}
