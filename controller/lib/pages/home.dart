import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/BigButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  showSnackBar(String text, bool goSettings) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
            height: 60,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(text, style: Const.titleText))),
        backgroundColor: Const.lightGrey,
        duration: const Duration(seconds: 1),
        action: goSettings
            ? SnackBarAction(
                label: 'Go to settings',
            textColor: Colors.white,
            onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              )
            : null));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Const.grey,
        appBar: AppBar(
          backgroundColor: Const.darkGrey,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            const SizedBox(width: 45),
            Text('Scroll Text Application', style: Const.BigText),
            const Spacer(),
            Const.ssh.isConnected()
                ? const Tooltip(
                    message: 'Online',
                    child: Icon(Icons.check_circle, color: Colors.green))
                : const Tooltip(
                    message: 'Offline',
                    child: Icon(Icons.error, color: Colors.red)),
            const SizedBox(width: 16)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigButton(
                      onPressed: () {
                        if (Const.ssh.isConnected()) {
                          Navigator.pushNamed(context, '/controller');
                        } else {
                          showSnackBar(
                              "First connect to the liquid galaxy.", true);
                        }
                      },
                      icon: Icons.edit,
                      text: 'Editor'),
                  BigButton(
                      onPressed: () async {
                        if (Const.ssh.isConnected()) {
                          Navigator.pushNamed(context, '/trackpad');
                        } else {
                          showSnackBar(
                              "First connect to the liquid galaxy.", true);
                        }
                      },
                      icon: Icons.control_camera,
                      text: 'Trackpad'),
                  BigButton(
                      onPressed: () async {
                        if (Const.ssh.isConnected()) {
                          await Const.ssh.execute(
                              "bash scroll_text_application/open.sh 3000 ${Const.ssh.password}");
                        } else {
                          showSnackBar(
                              "First connect to the liquid galaxy.", true);
                        }
                      },
                      icon: Icons.rocket_launch,
                      text: 'Start Service'),
                  BigButton(
                      onPressed: () async {
                        if (Const.ssh.isConnected()) {
                          await Const.ssh.execute(
                              "bash scroll_text_application/close.sh ${Const.ssh.password}");
                        } else {
                          showSnackBar(
                              "First connect to the liquid galaxy.", true);
                        }
                      },
                      icon: Icons.stop_circle_outlined,
                      text: 'Stop Service'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BigButton(
                      onPressed: () async {
                        if (Const.ssh.isConnected()) {
                          await Const.ssh.shutDownLG();
                          if (Const.ssh.connected) {
                            showSnackBar(
                                "Error occurred while shutting down.", false);
                          } else {
                            showSnackBar("LG shut down successfully.", false);
                          }
                          setState(() {});
                        } else {
                          showSnackBar(
                              "First connect to the liquid galaxy.", true);
                        }
                      },
                      icon: Icons.power_settings_new_outlined,
                      text: 'Power Off'),
                  BigButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/github');
                      },
                      icon: FontAwesomeIcons.github,
                      text: 'Github'),
                  BigButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, '/info');
                      },
                      icon: Icons.info,
                      text: 'Info'),
                  BigButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    icon: Icons.settings,
                    text: 'Settings',
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          )),
        ));
  }
}
