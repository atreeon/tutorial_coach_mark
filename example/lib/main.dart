// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:tutorial_coach_mark_demo/createTargets.dart';

import 'counter_cubit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TutorialCoachMark Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late TutorialCoachMark tutorialCoachMark;
  final TextEditingController _textController = TextEditingController();

  var keyButton = GlobalKey();
  var keyButton1 = GlobalKey();
  var keyIncrementButton = GlobalKey();
  var keyBottomNavigation1 = GlobalKey();
  var keyToggleTextFieldButton = GlobalKey();
  var keyTextField = GlobalKey();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    createTutorial();
    Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            // key: keyButton1,
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          PopupMenuButton(
            key: keyButton1,
            icon: const Icon(Icons.view_list, color: Colors.black),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("Is this"),
              ),
              const PopupMenuItem(
                child: Text("What"),
              ),
              const PopupMenuItem(
                child: Text("You Want?"),
              ),
            ],
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  key: keyButton,
                  color: Colors.blue,
                  height: 100,
                  width: MediaQuery.of(context).size.width - 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        showTutorial();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 220.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<CounterCubit, CounterState>(
                      builder: (context, state) {
                        return Text(
                          'Count: ${state.count}',
                          style: const TextStyle(fontSize: 18),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      key: keyIncrementButton,
                      onPressed: () {
                        context.read<CounterCubit>().increment();
                      },
                      child: const Text('Increment'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      key: keyToggleTextFieldButton,
                      onPressed: () {
                        context.read<CounterCubit>().toggleTextFieldVisibility();
                      },
                      child: const Text('Toggle Text Field'),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<CounterCubit, CounterState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Value: ${state.textValue}'),
                            if (!state.isTextFieldHidden) ...[
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 220,
                                child: TextField(
                                  key: keyTextField,
                                  controller: _textController,
                                  onChanged: (value) {
                                    context.read<CounterCubit>().updateText(value);
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Enter text',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child: SizedBox(
                    key: keyBottomNavigation1,
                    height: 40,
                    width: 40,
                  ),
                )),
              ],
            ),
          ),
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            // currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {},
          ),
        ],
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: createTargets(
        keyToggleTextFieldButton: keyToggleTextFieldButton,
        keyTextField: keyTextField,
        keyIncrementButton: keyIncrementButton,
        keyBottomNavigation1: keyBottomNavigation1,
        keyButton1: keyButton1,
        keyButton: keyButton,
      ),
      colorShadow: Colors.red,
      focusAnimationDuration: Duration.zero,
      unFocusAnimationDuration: Duration.zero,
      beforeFocus: (target) async {
        await Future.delayed(const Duration(milliseconds: 10));
      },
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) async {
        print('onClickTarget: $target');
        if (target.identify == "incrementButton") {
          context.read<CounterCubit>().increment();
        }
        if (target.identify == "toggleTextFieldButton") {
          await Future.delayed(const Duration(milliseconds: 1), () {
            context.read<CounterCubit>().setTextFieldHidden(false);
          });
        }
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
        return true;
      },
    );
  }

// List<TargetFocus> _createTargets() {
//   List<TargetFocus> targets = [];
//   targets.add(
//     TargetFocus(
//       identify: "toggleTextFieldButton",
//       keyTarget: keyToggleTextFieldButton,
//       alignSkip: Alignment.topRight,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Toggle Text Field",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 20.0,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.0),
//                 child: Text(
//                   "Tap to show or hide the text field.",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
//   targets.add(
//     TargetFocus(
//       identify: "textField",
//       keyTarget: keyTextField,
//       alignSkip: Alignment.topRight,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Text Field",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 20.0,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.0),
//                 child: Text(
//                   "Enter text here to update the label.",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
//   targets.add(
//     TargetFocus(
//       identify: "incrementButton",
//       keyTarget: keyIncrementButton,
//       alignSkip: Alignment.topRight,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           child: const Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "Increment",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 20.0,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(top: 10.0),
//                 child: Text(
//                   "This button increases the counter by 1.",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
//   targets.add(
//     TargetFocus(
//       identify: "keyBottomNavigation1",
//       keyTarget: keyBottomNavigation1,
//       alignSkip: Alignment.topRight,
//       enableOverlayTab: true,
//       contents: [
//         TargetContent(
//           align: ContentAlign.top,
//           builder: (context, controller) {
//             return const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Titulo lorem ipsum",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     ),
//   );
//
//   targets.add(
//     TargetFocus(
//       identify: "Target 0",
//       keyTarget: keyButton1,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           builder: (context, controller) {
//             return const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Titulo lorem ipsum",
//                   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Text(
//                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     ),
//   );
//   targets.add(
//     TargetFocus(
//       identify: "Target 1",
//       keyTarget: keyButton,
//       color: Colors.purple,
//       contents: [
//         TargetContent(
//           align: ContentAlign.bottom,
//           builder: (context, controller) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 const Text(
//                   "Titulo lorem ipsum",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 20.0,
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Text(
//                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     controller.previous();
//                   },
//                   child: const Icon(Icons.chevron_left),
//                 ),
//               ],
//             );
//           },
//         )
//       ],
//       shape: ShapeLightFocus.RRect,
//       radius: 5,
//     ),
//   );
//
//   return targets;
// }
}
