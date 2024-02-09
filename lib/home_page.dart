// import 'dart:convert';
// import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/bloc/chat_bloc.dart';
import 'package:glycoguide/models/chat_message_model.dart';
import 'package:glycoguide/profile_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlycoGuide'),
        centerTitle: true,
        toolbarHeight: 50.0,
        backgroundColor: Colors.blueGrey[100],
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person_sharp),
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
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.7,
                      image: AssetImage("assets/images/background2.jpeg"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      // height: 100,
                      // child: const Row(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     // Text(
                      //     //   "GlycoGuide",
                      //     //   style: TextStyle(
                      //     //       fontWeight: FontWeight.bold, fontSize: 24),
                      //     // ),
                      //     Icon(Icons.image_search, color: Colors.white)
                      //   ],
                      // ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 12, left: 16, right: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.amber.withOpacity(0.4)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages[index].role == "user"
                                            ? "User"
                                            : "AI",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                messages[index].role == "user"
                                                    ? Colors.amber.shade400
                                                    : Colors.purple.shade400),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        messages[index].parts.first.text,
                                        style: TextStyle(height: 1.2),
                                      ),
                                    ],
                                  ));
                            })),
                    if (chatBloc.generating)
                      const Row(
                        children: [
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   child: Lottie.asset('assets/loader.json'),
                          // ),
                          SizedBox(width: 20),
                          Text("Loading...")
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: TextStyle(color: Colors.black),
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  fillColor: Colors.white,
                                  hintText: "Ask Something from AI",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade400),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor))),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Center(
                                  child: Icon(Icons.send, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
