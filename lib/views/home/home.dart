import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minigram/services/auth.dart';
import 'package:minigram/views/Athentecation/loginPage.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin {
  authclass _auth = authclass();
  AnimationController _controller;
  Animation _animatedmargin;
  bool completed = false;
  Animation tinyreemargin;
  bool redbeeris = false;
  TextEditingController _inputcontrollet = TextEditingController();

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    
    
    
    _animatedmargin = TweenSequence(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 10.0), weight: 30.0),
        TweenSequenceItem(
          tween: Tween(begin: 10.0, end: 0.0),
          weight: 70.0,
        ),
      ],
    ).animate(_controller);
    tinyreemargin = Tween(begin: 150.0, end: 180.0).animate(_controller);
    _controller.notifyListeners();
    _controller.repeat(reverse: true);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          completed = false;
        });
      } else if (status == AnimationStatus.completed) {
        setState(() {
          completed = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    authclass _auth = authclass();
    return GestureDetector(
      onTap: () => showDialog(context: context,child: AlertDialog(content: Text('You should click some where in the screen to find the hidden question (that might be an eye!)'),)),
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/authum.png'), fit: BoxFit.fill)),
        child: Stack(children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('images/redbeer.png')),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: AlertDialog(
                      backgroundColor: Colors.brown,
                      content: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Text(
                              'Where is Hassan Saba\'s castle in Iran ? (give me a correct answer please ! ) ',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              controller: _inputcontrollet,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: [
                        Center(
                          child: FlatButton(
                            color: Colors.brown[400],
                            onPressed:() => Navigator.pop(context) ,
                            child: Text(
                              'Close this and search it in the google',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            color: Colors.brown[400],
                            onPressed: () {
                              if (_inputcontrollet.text == 'alamout') {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: AlertDialog(

                                        backgroundColor: Colors.brown,
                                        content: Wrap(
                                          children: [
                                            Text(
                                              'You have found the correct answer , congratulations !',
                                              style: TextStyle(fontSize: 22),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            FlatButton(
                                                color: Colors.brown[400],
                                                onPressed: (){
                                                  _auth.signout();
                                                  Navigator.pop(context);


                                                },
                                                child:
                                                    Text('Lets get out of here ! '))
                                          ],
                                        ),
                                      ),
                                    ));
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      backgroundColor: Colors.brown,
                                      content: Text('trymore !'),
                                    ));
                              }
                            },
                            child: Text(
                              'Click here to submmit your answer',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
              setState(() {
                redbeeris = !redbeeris;
              });
            },
            child: Opacity(
              opacity: redbeeris ? 0 : 1,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('images/beer.png')),
            ),
          ),

          Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/wildlife2.png',
              )),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Align(
              alignment: Alignment.bottomLeft,
              child: Transform.rotate(
                angle: 19,
                child: Container(
                  margin:
                      EdgeInsets.only(left: _animatedmargin.value, bottom: 100),
                  child: Image.asset(
                    'images/bird.png',
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Align(
              alignment: Alignment.bottomRight,
              child: Transform.rotate(
                angle: 19,
                child: Container(
                  margin:
                      EdgeInsets.only(right: _animatedmargin.value, bottom: 100),
                  child: Image.asset(
                    'images/bird.png',
                    height: 150,
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Container(

              margin: EdgeInsets.only(left: tinyreemargin.value),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'images/tinytree.png',
                  height: 50,
                ),
              ),
            ),
          ),

        ]),
      )),
    );
  }
}
