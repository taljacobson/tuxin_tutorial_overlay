import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tuxin_tutorial_overlay/TutorialOverlayUtil.dart';
import 'package:tuxin_tutorial_overlay/WidgetData.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tux-In Tutorial Overlay Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tutorial Overlay Example Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey buttonKey = GlobalKey();
  final GlobalKey counterKey = GlobalKey();
  final GlobalKey decKey = GlobalKey();
  double _leftPosition = 0;
  @override
  void initState() {
    setTutorialShowOverlayHook((String tagName) => print('SHOWING $tagName'));
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);

    super.initState();
  }

  void postFrameCallback(Duration duration) {
    createTutorialOverlay(
      context: context,
      tagName: 'example',
      bgColor: Colors.green.withValues(
          alpha: 0.4), // Optional. uses black color with 0.4 opacity by default
      onTap: () => {
        hideOverlayEntryIfExists(),
        showOverlayEntry(tagName: 'decreament'),
      },
      widgetsData: <WidgetData>[
        WidgetData(key: buttonKey, isEnabled: true, padding: 4),
        WidgetData(
          key: counterKey,
          isEnabled: false,
          shape: WidgetShape.Rect,
        )
      ],
      description: Text(
        'hello',
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.none,
        ),
      ),
    );

    createTutorialOverlay(
      context: context,
      tagName: 'decreament',
      onTap: () => hideOverlayEntryIfExists(),
      widgetsData: <WidgetData>[
        WidgetData(key: decKey, isEnabled: true, padding: 4),
        WidgetData(
          key: counterKey,
          isEnabled: false,
          shape: WidgetShape.Rect,
        )
      ],
      description: Text(
        'decreament',
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.none,
        ),
      ),
    );

    showOverlayEntry(tagName: 'example');
  }

  void _incrementCounter() {
    setState(() {
      _leftPosition += 10;
      _counter++;
    });

    if (_leftPosition > 50) {
      hideOverlayEntryIfExists(toRunHook: false);
      showOverlayEntry(tagName: 'decreament');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            key: decKey,
            onPressed: () {
              setState(() {
                _leftPosition = 0;
                _counter = 0;
              });
              hideOverlayEntryIfExists();
              showOverlayEntry(tagName: 'example');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(_leftPosition, 0, 0, 0),
              child: Text(
                '$_counter',
                key: counterKey,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        key: buttonKey,
        child: Icon(Icons.add),
      ),
    );
  }
}
