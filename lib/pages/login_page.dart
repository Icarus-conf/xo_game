import 'package:flutter/material.dart';
import 'package:xo_game/components/text_format.dart';
import 'package:xo_game/components/textfield_styling.dart';
import 'package:xo_game/model/player_model.dart';
import 'package:xo_game/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = 'LoginPage';
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  final playerOneController = TextEditingController();
  final playerTwoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1b263b),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    25,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 200,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFieldStyling(
                              labelText: 'Player One',
                              controller: playerOneController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter a valid name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFieldStyling(
                              labelText: 'Player Two',
                              controller: playerTwoController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter a valid name";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFffffff),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                context,
                                HomePage.routeName,
                                arguments: PlayerModel(
                                  playerOneName: playerOneController.text,
                                  playerTwoName: playerTwoController.text,
                                ),
                              );
                            }
                          },
                          child: PoppinsText(
                            text: 'Start the game',
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
