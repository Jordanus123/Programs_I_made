import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child:
              Container(
                padding: EdgeInsets.only(top: 70),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        child: Text(
                          "Ground Floor",
                          style:
                              TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      color: Colors.white,
                      child: Image(
                        image: AssetImage('assets/ground.png'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:20),
                      height: 10,
                      color: Colors.black,
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      color: Colors.white,
                      child: Image(
                        image: AssetImage('assets/2nd.png'),
                      ),
                    ),
                    Container(
                      height: 10,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      color: Colors.white,
                      child: Image(
                        image: AssetImage('assets/3rd.png'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:20),
                      height: 10,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      color: Colors.white,
                      child: Image(
                        image: AssetImage('assets/4rth.png'),
                      ),
                    ),

                  ],
                ),
              ),
        ),
        Container(
            color: Colors.transparent,
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 80),
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: Center(
                child: Text(
                  "MAP",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4),
                ),
              ),
            ),
          )
      ],
    );
  }
}
