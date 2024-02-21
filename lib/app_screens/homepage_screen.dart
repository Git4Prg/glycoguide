// import 'dart:convert';
// import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/app_screens/navbar_screen.dart';
import 'package:glycoguide/bloc/chat_bloc.dart';
import 'package:glycoguide/models/chat_message_model.dart';
import 'package:glycoguide/app_screens/profile_page.dart';
import 'package:glycoguide/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
// import 'package:glycoguide/settings.dart';
// import 'package:http/http.dart' as http;
// import 'package:bloc/bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "glyco guide",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 65,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              _showDoubleInputDialog(context);
            },
            icon: const Icon(
              Icons.edit_note_rounded,
              color: Colors.white,
            ),
            iconSize: 30.0,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.person_sharp,
              color: Colors.white,
            ),
            iconSize: 30.0,
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   padding: const EdgeInsets.all(8.0),
                  //   color: Color.fromARGB(255, 128, 131, 130),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 0, left: 10, right: 10),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                messages[index].role == "user"
                                    ? "User"
                                    : "GlycoGuide",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: messages[index].role == "user"
                                        ? Colors.amber.shade500
                                        : Colors.green.shade500),
                              ),
                              // const SizedBox(
                              //   height: 12,
                              // ),
                              Text(
                                messages[index].parts.first.text,
                                style: const TextStyle(
                                  height: 1.2,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  if (chatBloc.generating)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          height: 100,
                          width: 100,
                          child: Lottie.asset('assets/loader.json'),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor: Colors.white,
                                hintText: "Ask about your diet plan",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColor))),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            if (textEditingController.text.isNotEmpty) {
                              String text = textEditingController.text;
                              textEditingController.clear();
                              chatBloc.add(ChatGenerateNewTextMessageEvent(
                                  inputMessage: text));
                            }
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.shade800,
                            child: const Center(
                              child: Icon(Icons.send, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade800,
                          child: IconButton(
                            onPressed: () {
                              _pickImageFromGallery;
                            },
                            icon: const Icon(
                              Icons.image_outlined,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      selectedImage = File(returnedImage.path);
    });
  }

  void _showDoubleInputDialog(BuildContext context) {
    TextEditingController bloodSugarController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Hi Parigyan,',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              fontSize: 20,
            ),
          ),
          content: TextField(
            autofocus: true,
            controller: bloodSugarController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              hintText: 'Enter your Fasting Blood Sugar',
              hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontSize: 15,
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                double? inputValue = double.tryParse(bloodSugarController.text);
                if (inputValue != null) {
                  // Do something with the input value
                  print('Entered value: $inputValue');
                } else {
                  // Handle invalid input
                  print('Invalid input');
                }
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
