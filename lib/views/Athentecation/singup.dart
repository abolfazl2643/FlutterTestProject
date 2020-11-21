import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minigram/services/auth.dart';
import 'package:minigram/views/Athentecation/loginPage.dart';
import 'package:minigram/views/home/home.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();
   String error  ;
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    authclass _auth = authclass();
    final user = Provider.of<User>(context);
    return Scaffold(
      body: RotatedBox(
        quarterTurns: 8,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/greenleaves.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an email';
                              } else
                                return null;
                            },
                            controller: _emailcontroller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 80,
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              if (value.length < 4) {
                                return 'Please enter an valid password';
                              } else
                                return null;
                            },
                            controller: _passwordcontroller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                hintText: 'Password'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Material(
                                elevation: 16,
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.green[200],
                                child: MaterialButton(
                                  elevation: 18,
                                  animationDuration: Duration(seconds: 1),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    if (_formkey.currentState.validate()) {
                                      FirebaseAuth _result = await _auth.signup(
                                          _emailcontroller.text,
                                          _passwordcontroller.text);
                                      _result!=null ? Navigator.push(context, MaterialPageRoute(builder: (context) => home(),)) : null;
                                    }
                                  },
                                  child: Text('SignUp'),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('You already have an account ?'),
                                ),
                                FlatButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Loginpage(),
                                        )),
                                    child: Text(
                                      'Click here !',
                                      style: TextStyle(
                                        fontSize: 20,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 15.0,
                                            color: Colors.black,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                            loading ? CircularProgressIndicator() : Text('')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
