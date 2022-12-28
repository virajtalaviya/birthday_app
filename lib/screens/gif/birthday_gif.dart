import 'dart:math';

import 'package:birthday_app/constants.dart';
import 'package:birthday_app/retrofit_service/model/gif/gif_model.dart';
import 'package:birthday_app/screens/gif/gif_download.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BirthdayGIF extends StatefulWidget {
  const BirthdayGIF({Key? key}) : super(key: key);

  @override
  State<BirthdayGIF> createState() => _BirthdayGIFState();
}

class _BirthdayGIFState extends State<BirthdayGIF> {
  GIFModel? gifModel;
  bool connectedToInternet = true;

  getGIF() {
    Constants.apiClient.getGIF()
      ..then((value) {
        if (mounted) {
          setState(() {
            gifModel = value;
          });
        }
      })
      ..onError((DioError error, stackTrace) {
        if (error.message.contains("SocketException")) {
          if (mounted) {
            setState(() {
              gifModel = GIFModel(code: 1, data: [], message: "");
              connectedToInternet = false;
            });
          }
        }

        return GIFModel(code: 1, data: [], message: "");
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGIF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Image.asset(
              "assets/images/ic_back.png",
              height: 27,
            ),
          ),
        ),
        title: Text(
          "Birthday GIF",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: gifModel == null
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF7232FB)))
          : !connectedToInternet
              ? const Center(
                  child: Text(
                    "Make sure you are connected to internet",
                    style: TextStyle(
                      color: Color(0xFF7232FB),
                      fontSize: 18,
                    ),
                  ),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: gifModel!.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    Random random = Random();
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GifDownload(gifLink: gifModel!.data![index]),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade100,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(gifModel!.data![index]),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, right: 20, left: 20),
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7232FB),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/ic_download.png",
                                  height: 25,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "${random.nextInt(999)}K",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
