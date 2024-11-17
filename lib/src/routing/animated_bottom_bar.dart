import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reset_life/src/constants/app_sizes.dart';
import 'package:reset_life/src/l10n/l10n.dart';
import 'package:reset_life/src/themes/extensions.dart';
import 'package:rive/rive.dart';

class AnimatedBottomAppBar extends StatefulWidget {
  const AnimatedBottomAppBar({
    super.key,
    required this.currentActiveIndex,
    required this.onTabSelected,
  });

  final int currentActiveIndex;
  final ValueChanged<int> onTabSelected;

  @override
  State<AnimatedBottomAppBar> createState() => _AnimatedBottomAppBarState();
}

class _AnimatedBottomAppBarState extends State<AnimatedBottomAppBar> {
  final Map<String, ArtboardData> _artboards = {};

  @override
  void initState() {
    super.initState();
    final artboardFiles = {
      "fire": "assets/rives/fire.riv",
      "land": "assets/rives/land.riv",
      "mediation": "assets/rives/mediation.riv",
      "profile": "assets/rives/profile.riv",
    };

    artboardFiles.forEach((key, path) {
      loadArtboard(path, (artboard, controller) {
        _artboards[key] = ArtboardData(artboard: artboard, input: controller?.findInput("status"));
        if (key == "profile") {
          setState(() {});
        }
      });
    });
  }

  void loadArtboard(
    String path,
    void Function(Artboard artboard, StateMachineController? controller) onLoaded,
  ) {
    rootBundle.load(path).then((data) {
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller = StateMachineController.fromArtboard(artboard, "State Machine 1");
      if (controller != null) {
        artboard.addController(controller);
        controller.findInput("status")?.value = false;
      }
      onLoaded(artboard, controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    final tabs = [
      BottomAppBarTab(
        key: "fire",
        text: localizations.home,
        tabIndex: 0,
      ),
      BottomAppBarTab(
        key: "land",
        text: localizations.statistics,
        tabIndex: 1,
      ),
      BottomAppBarTab(
        key: "mediation",
        text: localizations.activity,
        tabIndex: 2,
      ),
      BottomAppBarTab(
        key: "profile",
        text: localizations.profile,
        tabIndex: 3,
      ),
    ];

    return BottomAppBar(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tabs.map((tab) {
            final data = _artboards[tab.key];
            if (data?.input != null) {
              data!.input!.value = widget.currentActiveIndex == tab.tabIndex;
            }
            return BottomAppBarItem(
              artboard: data?.artboard,
              currentIndex: widget.currentActiveIndex,
              tabIndex: tab.tabIndex,
              input: data?.input,
              text: tab.text,
              cb: () => widget.onTabSelected(tab.tabIndex),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.artboard,
    required this.cb,
    required this.currentIndex,
    required this.tabIndex,
    required this.text,
    required this.input,
  });

  final Artboard? artboard;
  final VoidCallback cb;
  final int currentIndex;
  final int tabIndex;
  final String text;
  final SMIInput<bool>? input;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onTap: cb,
              child: SizedBox(
                child: artboard == null ? const SizedBox() : Rive(artboard: artboard!),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: currentIndex == tabIndex ? FontWeight.w900 : FontWeight.w700,
                color: currentIndex == tabIndex ? context.colors.background : context.colors.hint,
                fontSize: Sizes.p16,
              ),
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class BottomAppBarTab {
  final String key;
  final String text;
  final int tabIndex;

  BottomAppBarTab({
    required this.key,
    required this.text,
    required this.tabIndex,
  });
}

class ArtboardData {
  final Artboard artboard;
  final SMIInput<bool>? input;

  ArtboardData({required this.artboard, this.input});
}
