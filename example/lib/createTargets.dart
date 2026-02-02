import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> createTargets({
  required GlobalKey keyToggleTextFieldButton,
  required GlobalKey keyTextField,
  required GlobalKey keyIncrementButton,
  required GlobalKey keyBottomNavigation1,
  required GlobalKey keyButton1,
  required GlobalKey keyButton,
}) {
  List<TargetFocus> targets = [];
  targets.add(
    TargetFocus(
      identify: "toggleTextFieldButton",
      keyTarget: keyToggleTextFieldButton,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Toggle Text Field",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Tap to show or hide the text field.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "textField",
      keyTarget: keyTextField,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Text Field",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Enter text here to update the label.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "incrementButton",
      keyTarget: keyIncrementButton,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Increment",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "This button increases the counter by 1.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "keyBottomNavigation1",
      keyTarget: keyBottomNavigation1,
      alignSkip: Alignment.topRight,
      enableOverlayTab: true,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Titulo lorem ipsum",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );

  targets.add(
    TargetFocus(
      identify: "Target 0",
      keyTarget: keyButton1,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Titulo lorem ipsum",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
  targets.add(
    TargetFocus(
      identify: "Target 1",
      keyTarget: keyButton,
      color: Colors.purple,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Titulo lorem ipsum",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.previous();
                  },
                  child: const Icon(Icons.chevron_left),
                ),
              ],
            );
          },
        )
      ],
      shape: ShapeLightFocus.RRect,
      radius: 5,
    ),
  );

  return targets;
}
