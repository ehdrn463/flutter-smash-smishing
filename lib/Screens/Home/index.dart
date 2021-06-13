import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../Components/ListViewContainer.dart';
import '../../Components/AddButton.dart';
import '../../Components/HomeTopView.dart';
import '../../Components/FadeContainer.dart';
import 'homeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


class MyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final String _url = "http://49.50.160.52:3000/predict";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('스미싱 문자 감지기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () async {
          var data = {
            "message": myController.text
          };
          // print(data['message']);
          // print((data['message']).runtimeType);
          var body = json.encode(data);
          print(body);

          // final http.Response _res = await http.post(Uri.parse("$_url/"), headers: {"Content-Type": "application/json", "Access-Control_Allow_Origin": "*"}, body:body);
          final http.Response _res = await http.post(Uri.parse("$_url"), headers: <String, String>{"Content-Type": "application/json; charset=UTF-8"}, body:body);
          String result; 
          if (json.decode(_res.body)['prediction'] == 0){
            result = "[안심] 정상 프로모션입니다.";
          }
          else {
            result = "[주의] 스미싱 문자입니다!";
          }
          print(json.decode(_res.body)['prediction']);
          print(result);

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                // content: Text(_res.body),
                content: Text(result),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}



// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key key}) : super(key: key);

//   @override
//   HomeScreenState createState() => new HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   Animation<double> containerGrowAnimation;
//   AnimationController _screenController;
//   AnimationController _buttonController;
//   Animation<double> buttonGrowAnimation;
//   Animation<double> listTileWidth;
//   Animation<Alignment> listSlideAnimation;
//   Animation<Alignment> buttonSwingAnimation;
//   Animation<EdgeInsets> listSlidePosition;
//   Animation<Color> fadeScreenAnimation;
//   var animateStatus = 0;
//   List<String> months = [
//     "January",
//     "February",
//     "March",
//     "April",
//     "May",
//     "June",
//     "July",
//     "August",
//     "September",
//     "October",
//     "November",
//     "December"
//   ];
//   String month = new DateFormat.MMMM().format(
//     new DateTime.now(),
//   );
//   int index = new DateTime.now().month;
//   void _selectforward() {
//     if (index < 12)
//       setState(() {
//         ++index;
//         month = months[index - 1];
//       });
//   }

//   void _selectbackward() {
//     if (index > 1)
//       setState(() {
//         --index;
//         month = months[index - 1];
//       });
//   }

//   @override
//   void initState() {
//     super.initState();

//     _screenController = new AnimationController(
//         duration: new Duration(milliseconds: 2000), vsync: this);
//     _buttonController = new AnimationController(
//         duration: new Duration(milliseconds: 1500), vsync: this);

//     fadeScreenAnimation = new ColorTween(
//       begin: const Color.fromRGBO(247, 64, 106, 1.0),
//       end: const Color.fromRGBO(247, 64, 106, 0.0),
//     )
//         .animate(
//       new CurvedAnimation(
//         parent: _screenController,
//         curve: Curves.ease,
//       ),
//     );
//     containerGrowAnimation = new CurvedAnimation(
//       parent: _screenController,
//       curve: Curves.easeIn,
//     );

//     buttonGrowAnimation = new CurvedAnimation(
//       parent: _screenController,
//       curve: Curves.easeOut,
//     );
//     containerGrowAnimation.addListener(() {
//       this.setState(() {});
//     });
//     containerGrowAnimation.addStatusListener((AnimationStatus status) {});

//     listTileWidth = new Tween<double>(
//       begin: 1000.0,
//       end: 600.0,
//     )
//         .animate(
//       new CurvedAnimation(
//         parent: _screenController,
//         curve: new Interval(
//           0.225,
//           0.600,
//           curve: Curves.bounceIn,
//         ),
//       ),
//     );

//     listSlideAnimation = new AlignmentTween(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     )
//         .animate(
//       new CurvedAnimation(
//         parent: _screenController,
//         curve: new Interval(
//           0.325,
//           0.700,
//           curve: Curves.ease,
//         ),
//       ),
//     );
//     buttonSwingAnimation = new AlignmentTween(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomRight,
//     )
//         .animate(
//       new CurvedAnimation(
//         parent: _screenController,
//         curve: new Interval(
//           0.225,
//           0.600,
//           curve: Curves.ease,
//         ),
//       ),
//     );
//     listSlidePosition = new EdgeInsetsTween(
//       begin: const EdgeInsets.only(bottom: 16.0),
//       end: const EdgeInsets.only(bottom: 80.0),
//     )
//         .animate(
//       new CurvedAnimation(
//         parent: _screenController,
//         curve: new Interval(
//           0.325,
//           0.800,
//           curve: Curves.ease,
//         ),
//       ),
//     );
//     _screenController.forward();
//   }

//   @override
//   void dispose() {
//     _screenController.dispose();
//     _buttonController.dispose();
//     super.dispose();
//   }

//   Future<Null> _playAnimation() async {
//     try {
//       await _buttonController.forward();
//     } on TickerCanceled {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     timeDilation = 0.3;
//     Size screenSize = MediaQuery.of(context).size;

//     return (new WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: new Scaffold(
//         body: new Container(
//           width: screenSize.width,
//           height: screenSize.height,
//           child: new Stack(
//             //alignment: buttonSwingAnimation.value,
//             alignment: Alignment.bottomRight,
//             children: <Widget>[
//               new ListView(
//                 shrinkWrap: _screenController.value < 1 ? false : true,
//                 padding: const EdgeInsets.all(0.0),
//                 children: <Widget>[
//                   new ImageBackground(
//                     backgroundImage: backgroundImage,
//                     containerGrowAnimation: containerGrowAnimation,
//                     profileImage: profileImage,
//                     month: month,
//                     selectbackward: _selectbackward,
//                     selectforward: _selectforward,
//                   ),
//                   //new Calender(),
//                   new ListViewContent(
//                     listSlideAnimation: listSlideAnimation,
//                     listSlidePosition: listSlidePosition,
//                     listTileWidth: listTileWidth,
//                   )
//                 ],
//               ),
//               new FadeBox(
//                 fadeScreenAnimation: fadeScreenAnimation,
//                 containerGrowAnimation: containerGrowAnimation,
//               ),
//               animateStatus == 0
//                   ? new Padding(
//                       padding: new EdgeInsets.all(20.0),
//                       child: new InkWell(
//                           splashColor: Colors.white,
//                           highlightColor: Colors.white,
//                           onTap: () {
//                             setState(() {
//                               animateStatus = 1;
//                             });
//                             _playAnimation();
//                           },
//                           child: new AddButton(
//                             buttonGrowAnimation: buttonGrowAnimation,
//                           )))
//                   : new StaggerAnimation(
//                       buttonController: _buttonController.view),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
