import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'swipe_gesture_recognizer.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0000;
  AudioCache _player = AudioCache();



  void _incrementCounter() async {

    setState(() {
      final player = AudioCache();
      player.play("2.mp3");
      _counter++;
      _setPrefItems();  // Shared Preferenceに値を保存する。
    });
  }

  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  // Shared Preferenceにデータを書き込む
  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    prefs.setInt('counter', _counter);
  }

  // Shared Preferenceのデータを削除する
  _removePrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _counter = 0;
      // 以下の「counter」がキー名。
      prefs.remove('counter');
    });
  }

  void playSound() {
    final player = AudioCache();
    player.play("2.mp3");
  }

  @override
  void initState() {
    super.initState();
    // 初期化時にShared Preferencesに保存している値を読み込む
    _getPrefItems();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.6,
                  color: Color(0xFFBDBDBD),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        onPressed: () {
                          _incrementCounter();
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 180,
                        height: 70,
                        child: Center(
                          child: Text(
                            //'$_counter',
                            _counter.toString().padLeft(4,"0"),
                            style: TextStyle(color: Colors.white,fontSize: 60),
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                      ),
                    ],
                  ),
                ),
                SwipeGestureRecognizer(
                  child: Container(height: 50, width: 50, color: Colors.black,
                    child: Icon(Icons.menu,color: Colors.white,size: 40,),
                  ),
                  onSwipeUp: () {
                    print('数を下げるよ');
                    downCount();
                  },
                  onSwipeDown: () {
                    print('数をあげるよ');
                    upCount();
                  },
                  onSwipeLeft: () {

                  },
                  onSwipeRight: () {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void upCount() {
    setState(() {
      if(_counter >= 9000) {
        _counter = 0000;
      }else{
        _counter += 1000;
      }
      _setPrefItems();  // Shared Preferenceに値を保存する。
    });
  }
  void downCount() {
    setState(() {
      if(_counter <= 1000) {
        _counter = 0000;
      }else{
        _counter -= 1000;
      }
      _setPrefItems();  // Shared Preferenceに値を保存する。
    });
  }
}
