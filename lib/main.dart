import 'package:flutter/material.dart';
import 'package:sudoku_crypto/src/resources/engine.dart';

AppEngine appEngine = AppEngine();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          ElevatedButton(
              onPressed: (){},
              child: Text("Home")
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text("App")
          ),
          ElevatedButton(
              onPressed: (){},
              child: Text("Database")
          ),
          SizedBox(width: 50)
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              height: 450,
              width: 450,
              child: Table(
                border: TableBorder.all(),
                children: [
                  TableRow(children: [
                    Box(
                        numbers:[1,2,3,4,5,6,7,8,9],
                        editable:[false,false,true,false,false,false,false,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    ),
                    Box(
                        numbers:[4,5,6,1,2,3,7,8,9],
                        editable:[false,false,false,false,false,true,false,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    ),
                    Box(
                        numbers:[1,2,3,7,8,9,4,5,6],
                        editable:[false,false,false,false,true,false,false,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    )
                  ]),
                  TableRow(children: [
                    Box(
                        numbers:[0,2,3,4,5,6,7,8,9],
                        editable:[true,false,false,false,false,false,false,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    ),
                    Box(
                        numbers:[4,5,6,1,2,3,7,8,9],
                        editable:[false,false,false,false,true,false,false,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    ),
                    Box(
                        numbers:[1,2,3,7,8,9,4,5,6],
                        editable:[false,false,true,false,false,false,false,false,true],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    )
                  ]),
                  TableRow(children: [
                    Box(
                        numbers:[1,2,3,4,5,6,7,8,9],
                        editable:[false,false,false,false,false,false,true,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    ),
                    Box(
                        numbers:[4,5,6,1,2,3,7,8,9],
                        editable:[false,false,false,true,false,false,false,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    ),
                    Box(
                        numbers:[1,2,3,7,8,9,4,5,6],
                        editable:[false,true,false,false,false,false,true,false,false],
                        highlight:[false,false,false,false,false,false,false,false,false]
                    )
                  ]),
                ]
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class Number extends StatelessWidget {
  const Number({Key? key, required this.number, required this.highlight, required this.editable}) : super(key: key);

  final int number;
  final bool highlight;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      color: (highlight)?
        Colors.lightBlueAccent:
        Colors.transparent,
      child: (editable)?
          ElevatedButton(
              onPressed: (){},
              child: (number == 0)?
                Container()
                  :
                Center(child: Text(number.toString()))
          )
          :
          Center(child: Text(number.toString()))
    );
  }
}

class Box extends StatelessWidget {
  const Box({Key? key, required this.numbers, required this.highlight, required this.editable}) : super(key: key);

  final List<int> numbers;
  final List<bool> highlight;
  final List<bool> editable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(children:[
            Number(number: numbers[0], editable: editable[0], highlight: highlight[0]),
            Number(number: numbers[1], editable: editable[1], highlight: highlight[1]),
            Number(number: numbers[2], editable: editable[2], highlight: highlight[2]),
          ]),
          TableRow(children:[
            Number(number: numbers[3], editable: editable[3], highlight: highlight[3]),
            Number(number: numbers[4], editable: editable[4], highlight: highlight[4]),
            Number(number: numbers[5], editable: editable[5], highlight: highlight[5]),
          ]),
          TableRow(children:[
            Number(number: numbers[6], editable: editable[6], highlight: highlight[6]),
            Number(number: numbers[7], editable: editable[7], highlight: highlight[7]),
            Number(number: numbers[8], editable: editable[8], highlight: highlight[8]),
          ]),
        ]
      )
    );
  }
}

