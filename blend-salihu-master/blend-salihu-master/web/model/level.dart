import 'dart:html';
import '../view.dart';
import 'player.dart';

class Platform {
  num x, y, width, height;

  Platform(this.x, this.y, this.width, this.height);
}

class Frame {
  num x, y, width, height;
  bool hovering = false;

  Frame(this.x, this.y, this.width, this.height);

  void checkHover(MouseEvent event) {
    var target = event.target as Element?;
    if (target != null) {
      var rect = target.getBoundingClientRect();
      hovering = event.client.x >= rect.left &&
          event.client.x <= rect.right &&
          event.client.y >= rect.top &&
          event.client.y <= rect.bottom;
    }
  }
}

class Level {
  Player player;
  List<Platform> platforms = [];
  List<Frame> frames = [];
  bool frameActive = false;
  int currentLevel = 1;
  BridgeBuilderView view;

  Level(this.player, this.view) {
    for (var i = 0; i < 5; i++) {
      var platform = Platform(i * 150, 300, 100, 10);
      platforms.add(platform);

      var frame = Frame(platform.x + 20, platform.y - 40, 60, 40);
      frames.add(frame);
    }

    // Game loop
    window.onMouseMove.listen((event) {
      for (var frame in frames) {
        frame.checkHover(event);
        if (frame.hovering && !frameActive) {
          frameActive = true;
          player.buildBridge();
        }
      }
    });
  }

  void activate() {
    for (var frame in frames) {
      frame.hovering = false; 
      frameActive = false; 

      var frameElement = document.querySelector('.frame');
      if (frameElement != null) {
        frameElement.style.backgroundColor = 'yellow'; 
      }
    }
    print('Level activated');
  }

  void levelCompleted() {
    player.bridgeBuilt = false;
    player.onPlatform = false;
    player.currentPlatform = 0;
    frameActive = false;
    player.bridgeBuilt = false;
    player.onPlatform = false;

    if (currentLevel == 1) {
      // Assuming you have 3 levels
      querySelector('#level1')?.style.display = 'none';
      view.showAllLevelsCompletedMessage();
    } else {
      currentLevel++;
      querySelector('#level$currentLevel')?.style.display = 'block';
    }
}
}