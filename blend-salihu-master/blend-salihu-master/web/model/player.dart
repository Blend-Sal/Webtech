import 'dart:html';

class Player {

  bool bridgeBuilt = false;
  bool onPlatform = false;
  int currentPlatform = 0;

  void buildBridge() async {
    await Future.delayed(Duration(seconds: 2));

    var frame = document.querySelector('.frame.hover');
    if (frame != null) {
      frame.style.backgroundColor = 'gray'; 
    }

    var bridge = DivElement()..className = 'bridge';
    document.body!.append(bridge);
  }

  void destroyBridge() {
    final bridge = document.querySelector('.bridge');
    bridge?.remove();
  }
}
