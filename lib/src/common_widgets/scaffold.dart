import 'package:flutter/material.dart';
import 'package:my_app/src/common_widgets/app_bar.dart';

class AppScaffold extends Scaffold {
  AppScaffold({
    super.key,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary,
    super.drawerDragStartBehavior,
    super.extendBody,
    super.extendBodyBehindAppBar,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture,
    super.endDrawerEnableOpenDragGesture,
    super.restorationId,
    super.persistentFooterAlignment,
    Widget? body,
  }) : super(
          appBar: AppAppBar(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              if (body != null) body,
            ],
          ),
        );
}
