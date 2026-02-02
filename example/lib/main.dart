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

  Future<void> _waitForKey(
    GlobalKey key, {
    Duration timeout = const Duration(seconds: 2),
  }) async {
    final endTime = DateTime.now().add(timeout);
    while (mounted && DateTime.now().isBefore(endTime)) {
      final context = key.currentContext;
      final renderObject = context?.findRenderObject();
      if (renderObject is RenderBox && renderObject.attached && renderObject.hasSize) {
        return;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
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
      contentAnimationDuration: Duration.zero,
      beforeFocus: (target) async {
        await Future.delayed(const Duration(milliseconds: 300));
        if (target.identify == "textField") {
          await _waitForKey(keyTextField);
        }
      },
      onClickTarget: (target) async {
        print('onClickTarget: $target');
        if (target.identify == "incrementButton") {
          context.read<CounterCubit>().increment();
        }
        if (target.identify == "toggleTextFieldButton") {
          context.read<CounterCubit>().setTextFieldHidden(false);
        }
      },
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
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

}
