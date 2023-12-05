import 'package:flutter/material.dart';
import 'package:getclocked/main.dart';
import 'package:provider/provider.dart';

class AnnotatePage extends StatelessWidget {
  const AnnotatePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var colorScheme = Theme.of(context).colorScheme;

    final myController = TextEditingController();

    int overtimeHours = 0;
    int overtimeMinutes = 0;
    int currentValueM = 0;
    int currentValueH = 0;

    @override
    void dispose() {
      myController.dispose();
    }

    return Container(
      decoration: BoxDecoration(color: colorScheme.primary),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.only(
                    top: 800 * 0.5 * 0.2, bottom: 14, left: 14, right: 14)),
            SizedBox(
              child: Text(
                "Welcome!",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSecondary,
                    fontSize: 24),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 480 * 0.5 * 0.4)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 480 * 0.5 * 0.55,
                  height: 800 * 0.5 * 0.25,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 10),
                      shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () {
                      final dt = appState.getTime();
                      if (!appState.onlyIn &&
                          ((appState.checkIns.isNotEmpty &&
                                  appState.compareToLastCheckIn(dt)) ||
                              (appState.checkIns.isEmpty))) {
                        appState.annotateIn(dt);
                        var snackBar =
                            appState.createSnackBar('You have checked in!');
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        var snackBar = appState.createSnackBar(
                            'You have already checked in today!');
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: Icon(
                      Icons.add_alarm_outlined,
                      color: colorScheme.onSecondary,
                    ),
                    label: Text(
                      'Check in',
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 480 * 0.5 * 0.2)),
                SizedBox(
                  width: 480 * 0.5 * 0.55,
                  height: 800 * 0.5 * 0.25,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 10),
                      shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                    ),
                    onPressed: () {
                      if (appState.onlyIn) {
                        final dt = appState.getTime();
                        appState.annotateOut(dt);
                        var snackBar =
                            appState.createSnackBar('You have checked out!');
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    icon: Icon(Icons.assignment_turned_in_outlined,
                        color: colorScheme.onSecondary),
                    label: Text(
                      'Check out',
                      style: TextStyle(
                          fontSize: 11, color: colorScheme.onSecondary),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(30)),
            ElevatedButton(
                child: Text(
                  'Pause clock',
                  style: TextStyle(color: colorScheme.onSecondary),
                ),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                            backgroundColor: colorScheme.secondary,
                            title: const Text('Pause clock'),
                            content: const Text(
                                'Do you really wish to pause the clock?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: Text('Cancel', style: TextStyle(color: colorScheme.onPrimary),),
                              ),
                              TextButton(
                                onPressed: () => {
                                  // TODO: implement the 'stop clock' functionality
                                  Navigator.pop(context, 'Yes!')
                                },
                                child: Text('Yes!',style: TextStyle(color: colorScheme.onPrimary)),
                              ),
                            ]))), 
            const Expanded(
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}