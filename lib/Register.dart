import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Header.dart';
import 'navbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showPassword = false;
  bool confirmPassword = false;
  bool stayLoggedIn = false;

  void _toggle(){
    setState(() {
      showPassword = !showPassword;
    });
  }

  void _toggleConfirmPassword(){
    setState(() {
      confirmPassword = !confirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body:NestedScrollView(headerSliverBuilder: (BuildContext context , bool innerBoxIsScrolled){
          return <Widget> [
            const SliverAppBar(
              toolbarHeight: 70, expandedHeight: 200,
              backgroundColor:  Colors.amber,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Header(title:'Register Yourself'),
              ),
            )

          ];
        },
          body: Container(
            decoration:  const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            child:  Padding(
              padding:   const EdgeInsets.fromLTRB(15, 40, 15, 20),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:  [
                  const Text('Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Quickend')),

                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('Email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Quickend')),

                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('Mobile number',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Quickend')),

                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter your mobile number',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 12)
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text('Password',style: TextStyle(fontWeight: FontWeight.w700,fontFamily:'Quicksand',fontSize: 18 )),
                  TextField(decoration: InputDecoration(
                    hintText: 'Create your password',
                    hintStyle: const TextStyle(color: Colors.grey,fontSize: 12),
                    suffixIcon: InkWell(onTap: _toggleConfirmPassword,
                        child: Icon(confirmPassword? CupertinoIcons.eye_slash: CupertinoIcons.eye_fill,size: 20,)),
                  ),
                      obscureText: confirmPassword),
                  const SizedBox(height: 30),

                  Container(decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(100)
                  ),
                    width: MediaQuery.of(context).size.width,height: 40,
                    child: ElevatedButton( onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> NavBar()));
                    },
                      child: Text("Register", style: TextStyle(color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                  ),
                ],
                ),
              ),
            ),
          ),
        )
    );
  }
}


