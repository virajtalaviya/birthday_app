import 'package:birthday_app/constants.dart';
import 'package:birthday_app/retrofit_service/model/songs/songs_model.dart';
import 'package:birthday_app/screens/songs/play_song.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BirthdaySongs extends StatefulWidget {
  const BirthdaySongs({Key? key}) : super(key: key);

  @override
  State<BirthdaySongs> createState() => _BirthdaySongsState();
}

class _BirthdaySongsState extends State<BirthdaySongs> {
  SongsModel? songsModel;
  bool connectedToInternet = true;

  getSongs() {
    Constants.apiClient.getSongs()
      ..then((value) {
        setState(() {
          songsModel = value;
        });
      })
      ..onError((DioError error, stackTrace) {
        if (error.message.contains("SocketException")) {
          setState(() {
            songsModel = SongsModel(code: 1, data: [], message: "");
            connectedToInternet = false;
          });
        }
        return SongsModel(code: 0, message: "", data: []);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
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
          "Birthday Songs",
          style: TextStyle(
            color: Colors.black,
            fontFamily: Constants.fontFamilyRegular,
          ),
        ),
      ),
      body: songsModel == null
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
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  itemCount: songsModel!.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaySong(
                                name: songsModel!.data![index].name ?? "",
                                songLink: songsModel!.data![index].songname ?? "",
                                icon: songsModel!.data![index].icon_url ?? "",
                              ),
                            ),
                          );
                        },
                        leading: Image.network(
                          songsModel!.data![index].icon_url ?? "",
                          height: 30,
                        ),
                        title: Text(
                          "${songsModel!.data![index].name}",
                          style: TextStyle(
                            fontFamily: Constants.fontFamilyRegular,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
