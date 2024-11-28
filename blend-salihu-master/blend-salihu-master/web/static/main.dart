import 'dart:async';
import '../controller.dart';
import '../model/level.dart';
import '../model/player.dart';
import '../view.dart';

void main() {
  Player player = Player();
  BridgeBuilderView view = BridgeBuilderView();
  Level level = Level(player, view); 
  Controller controller = Controller(view, level, player);
  controller.start();

  Timer.periodic(Duration(milliseconds: 30), (timer) {
    view.update();
  });
}

