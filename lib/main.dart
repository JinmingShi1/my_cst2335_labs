import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // image component for meat
  Widget meatPic({
    required String backgroundImage,
    required String text,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 37,
          backgroundImage: AssetImage(backgroundImage),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // image component for course and dessert
  Widget dessertAndCoursePic({
    required String backgroundImage,
    required String text,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 37,
          backgroundImage: AssetImage(backgroundImage),
        ),
        Positioned(
          top: 80,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  static const TextStyle titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 60),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "BROWSE CATEGORIES",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    "Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.",
                    style: TextStyle(fontSize: 14, color: Colors.black87)
                )
              ),
              
              Text(
                "BY MEAT",
                style: titleStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  meatPic(backgroundImage: "images/Beef.jpg", text: "Beef"),
                  meatPic(backgroundImage: "images/Chicken.jpg", text: "Chicken"),
                  meatPic(backgroundImage: "images/Pork.jpg", text: "Pork"),
                  meatPic(backgroundImage: "images/Seafood.jpg", text: "Seafood"),
                ],
              ),
              Text(
                "BY COURSE",
                style: titleStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dessertAndCoursePic(backgroundImage: "images/MainDishes.jpg", text: "Main Dishes"),
                  dessertAndCoursePic(backgroundImage: "images/Salad.jpg", text: "Salad Recipes"),
                  dessertAndCoursePic(backgroundImage: "images/SideDishes.jpg", text: "Side Dishes"),
                  dessertAndCoursePic(backgroundImage: "images/Crockpot.jpg", text: "Crockpot"),
                ],
              ),
              Text(
                "BY DESSERT",
                style: titleStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dessertAndCoursePic(backgroundImage: "images/IceCream.jpg", text: "Ice Cream"),
                  dessertAndCoursePic(backgroundImage: "images/Brownies.jpg", text: "Brownies"),
                  dessertAndCoursePic(backgroundImage: "images/Pies.jpg", text: "Pies"),
                  dessertAndCoursePic(backgroundImage: "images/Cookies.jpg", text: "Cookies"),
                ],
              ),
            ],

          ),
        )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
