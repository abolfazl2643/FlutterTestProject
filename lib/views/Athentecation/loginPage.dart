import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minigram/services/auth.dart';
import 'package:minigram/views/Athentecation/singup.dart';
import 'package:minigram/views/home/home.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false ;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    authclass _auth = authclass();
    final user = Provider.of<User>(context);

    return user!=null ? home()  : Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                  'images/purepng.com-autumn-leafnatureleafautumn-961524674624cn4te.png')),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Form(
                  key: _formkey,
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
                            padding: const EdgeInsets.only(bottom:16),
                            child: Material(
                      borderRadius: BorderRadius.circular(50),
                              color: Colors.orange[200],
                              elevation: 15,
                              child: MaterialButton(
                                elevation: 18,
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (_formkey.currentState.validate()) {
                                    FirebaseAuth result = await _auth.signin(
                                        _emailcontroller.text,
                                        _passwordcontroller.text);


                                  }
                                },

                                child: Text('Login'),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child:
                                    Text('Do you want to create an account ?'),
                              ),
                              FlatButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      )),
                                  child: Container(

                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.orange[200],width: 3)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        'Click here !',
                                        style: TextStyle(
                                          fontSize: 18,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 15.0,
                                              color: Colors.orange[200],
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
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
        ],
      ),
    );
  }
}
