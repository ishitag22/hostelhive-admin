import 'package:hostelhive_admin/notices.dart';
import 'package:hostelhive_admin/Register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Header.dart';
import 'navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;
  bool stayLoggedIn = false;
  void _toggle(){
    setState(() {
      showPassword = !showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return<Widget>[
            const SliverAppBar(
              backgroundColor:Colors.amber,
              expandedHeight: 200,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                background:Header(title: 'Welcome') ,

              ),
            )


          ];
        },body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        child:Padding(
          padding: const   EdgeInsets.fromLTRB(15,40,15,20),
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment :CrossAxisAlignment.start,
              children:  [
                const Text('Email',style: TextStyle(fontWeight: FontWeight.w700,fontFamily:'Quicksand',fontSize: 18 )),
                const TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Password',style: TextStyle(fontWeight: FontWeight.w700,fontFamily:'Quicksand',fontSize: 18 )),
                TextField(decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                  suffixIcon: InkWell(onTap: _toggle,
                      child: Icon(showPassword? CupertinoIcons.eye_slash: CupertinoIcons.eye_fill,size: 20,)),
                ),
                  obscureText: showPassword,
                ),

                const SizedBox(height: 10),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SizedBox(width: 15,
                        child: Checkbox(value: stayLoggedIn,
                            activeColor: Colors.blueAccent,
                            checkColor: Colors.white,
                            onChanged: (bool? value) {setState(() {
                              stayLoggedIn = !stayLoggedIn;
                            });
                            }),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Stay logged in?',style: TextStyle(fontSize: 15,color: Colors.grey),),)
                    ],),


                  ],
                ),
                const SizedBox(height: 20),
                Container(decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(100)
                ),
                  width: MediaQuery.of(context).size.width,height: 40,
                  child: ElevatedButton( onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> NavBar()));
                  },
                    child: Text("Login", style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(30),
                  child: Center(
                    child: InkWell(onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (_)=> const SignUp())),
                      child: const Text.rich(TextSpan(children: [
                        TextSpan(text:"Don't have an account yet? Register",style: TextStyle(fontSize:12 )),
                        TextSpan(text: ' here',style: TextStyle(fontSize: 12,color: Colors.amberAccent, fontWeight: FontWeight.w900)),
                      ])),
                    ),
                  ),
                )
              ],
            ),
          ),

        ),),
      ),
    );
  }
}
