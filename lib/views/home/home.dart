import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minigram/services/auth.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin {
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
      onTap: () => showDialog(
          context: context,
          child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              height: 120,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.white.withOpacity(0.5))),
              child: Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Center(
                  child: Text(
                    'You should click some where in the screen to find the hidden question (that might be an eye!) you can\'t logout until find the answer',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          )),
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
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: Container(
                        height: 150,
                        child: Column(
                          children: [
                            Text(
                              'Where is Hassan Saba\'s castle in Iran ? (Area name required!) ',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.white.withOpacity(1))),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                                controller: _inputcontrollet,
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 20),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: [
                        Center(
                          child: FlatButton(
                            color: Colors.transparent,
                            onPressed: () => Navigator.pop(context),
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.white.withOpacity(1))),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Close this and search it in the Google',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: FlatButton(
                            color: Colors.transparent,
                            onPressed: () {
                              if (_inputcontrollet.text == 'alamout') {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: AlertDialog(
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        content: Wrap(
                                          children: [
                                            Text(
                                              'You have found the correct answer,congratulations!',
                                              style: TextStyle(fontSize: 22 , color: Colors.white),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            FlatButton(

                                              color: Colors.transparent,
                                              onPressed: () {
                                                _auth.signout();
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 25,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.white.withOpacity(1))),
                                                child: Center(
                                                  child: Text(
                                                      'Lets get out of here ! ',style: TextStyle(color: Colors.white),),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      content: Container(
                                          height: 100,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.white.withOpacity(0.2))),
                                          child: Center(child: Text('Try more !',style: TextStyle(color: Colors.white ,fontSize: 22 ),))),
                                    ));
                              }
                            },
                            child: Container(
                              height: 25,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.white.withOpacity(1))),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  'Click here to submmit your answer',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
                  margin: EdgeInsets.only(
                      right: _animatedmargin.value, bottom: 100),
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
