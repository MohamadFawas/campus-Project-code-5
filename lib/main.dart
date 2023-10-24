import 'package:flutter/material.dart';
import 'photo.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController username = TextEditingController();
  TextEditingController password =  TextEditingController();
  bool test = true;

  check(String user, String pass) {
    if (user == "fawas" && pass == "1997") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: username,
                maxLength: 30,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 3,
                    color: Colors.greenAccent,
                  )),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 2, color: Colors.redAccent)),
                  hintText: "username",
                ),
              ),
              TextField(
                controller: password,
                maxLength: 15,
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.no_encryption),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.greenAccent,
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.redAccent)),
                    hintText: "password"),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    setState(() {
                      test = check(username.text, password.text);
                      if ('$test' == "true") {
                        Text('sucsess');
                        print('suceess1');

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return LearnFlutterPage();
                          }),
                        );
                      } else {
                        Text('fail');
                        print('fail1');
                      }
                    });
                  },
                  child: Text('Login'),
                ),
              ),

              // Text('$test'),
            ],
          ),
        ),
      ),
    );
  }
}
