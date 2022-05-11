import 'package:flutter/material.dart';


class LoginPageWidget extends StatefulWidget {
  @override
  _LoginPageWidget createState() => _LoginPageWidget();
}

class _LoginPageWidget extends State<LoginPageWidget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Androidlarge1Widget - FRAME

    return Container(
        width: 360,
        height: 800,
        decoration: BoxDecoration(
          color : Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 337,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(300),
                        ),
                        image : DecorationImage(
                            image: AssetImage('assets/images/login_image_background_two.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),Positioned(
                  top: 252,
                  left: 0,
                  child: Container(
                      width: 360,
                      height: 356,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(80),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        color : Color.fromRGBO(255, 255, 255, 1),
                      )
                  )
              ),Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 252,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(80),
                        ),
                        image : DecorationImage(
                            image: AssetImage('assets/images/login_image_background.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),Positioned(
                  top: -36,
                  left: -23,
                  child: Container(
                      width: 360,
                      height: 252,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/login_image_light.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),Positioned(
                  top: 366,

                  child: Container(
                      width: 279,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color : Color.fromRGBO(207, 222, 236, 1),
                      )
                  )
              ),Positioned(



                  top: 380,



                  child: Text('Email', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(162, 182, 201, 1),
                      fontFamily: 'Inter',
                      fontSize: 18,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 56,

                  child: Container(
                      width: 173,
                      height: 98,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/login_image_logo.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),Positioned(
                  top: 508,
                  child: Align(
                      child: Container(
                          width: 279,
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius : BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color : Color.fromRGBO(23, 72, 115, 1),
                          )
                      )
                  )
              ),Positioned(
                  top: 519,
                  child: Text('Sign in', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Inter',
                      fontSize: 20,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 436,

                  child: Container(
                      width: 279,
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius : BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color : Color.fromRGBO(207, 222, 236, 1),
                      )
                  )
              ),Positioned(
                  top: 450,

                  child: Text('Password', textAlign: TextAlign.left, style: TextStyle(
                      color: Color.fromRGBO(162, 182, 201, 1),
                      fontFamily: 'Inter',
                      fontSize: 18,
                      letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1
                  ),)
              ),Positioned(
                  top: 608,
                  left: 0,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 178,
                      decoration: BoxDecoration(
                        image : DecorationImage(
                            image: AssetImage('assets/images/login_image_buildings.png'),
                            fit: BoxFit.fitWidth
                        ),
                      )
                  )
              ),
            ]
        )
    );
  }
}
