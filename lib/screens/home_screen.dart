import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/const/const.dart';
import 'package:weather_app/const/screen_size.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/model/hourly_weather_model.dart';
import 'package:weather_app/model/weather_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    print(ScreenSize.screenHeight);
    print(ScreenSize.screenWidth);
    var controller = Get.put(WeatherController());
    var date = DateFormat('EEEE, MMM d, yyy').format(DateTime.now());

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(() => controller.isloaded == true
            ? SafeArea(
                child: FutureBuilder(
                  future: controller.weaterData,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    } else {
                      CurrentWeatherData data = snapshot.data;
                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  // height:
                                  //     MediaQuery.of(context).size.height * 0.54,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                      color: textColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          "$date"
                                              .text
                                              .size(ScreenSize.screenWidth / 30)
                                              .fontFamily('poppins')
                                              .white
                                              .make(),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.light_mode_rounded),
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                      "${data.name}"
                                          .text
                                          .white
                                          .size(ScreenSize.screenWidth / 15)
                                          .fontFamily('poppins_bold')
                                          .make(),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              Image.asset(
                                                  height: ScreenSize
                                                      .getScreenHieght(150),
                                                  'assets/images/${data.weather![0].icon}.png'),
                                              Container(
                                                child: Lottie.asset(
                                                  width:
                                                      ScreenSize.getScreenWidth(
                                                          60),
                                                  height: ScreenSize
                                                      .getScreenHieght(120),
                                                  'assets/icons/logo.json',
                                                ),
                                              ),
                                            ],
                                          ),
                                          ScreenSize.getScreenWidth(30)
                                              .widthBox,
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '${data.main!.temp}${degree}',
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenSize.screenWidth /
                                                            13,
                                                    fontFamily:
                                                        'poppins_bold')),
                                            TextSpan(
                                                text: data.weather![0].main,
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenSize.screenWidth /
                                                            20,
                                                    fontFamily: 'poppins')),
                                          ]))
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton.icon(
                                            onPressed: null,
                                            label:
                                                "${data.main!.tempMax!} $degree"
                                                    .text
                                                    .size(
                                                        ScreenSize.screenWidth /
                                                            20)
                                                    .white
                                                    .make(),
                                            icon: const Icon(
                                              Icons.expand_less_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          TextButton.icon(
                                              onPressed: null,
                                              label:
                                                  "${data.main!.tempMin!} $degree"
                                                      .text
                                                      .size(ScreenSize
                                                              .screenWidth /
                                                          20)
                                                      .white
                                                      .make(),
                                              icon: const Icon(
                                                Icons.expand_more_rounded,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 2,
                                      ), // ignore: prefer_const_constructors
                                      const Divider(
                                        thickness: 1,
                                        color: dividerColor,
                                      ),
                                      // SizedBox(
                                      //     height:
                                      //         ScreenSize.getScreenHieght(10)),
                                      Spacer(
                                        flex: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: List.generate(3, (index) {
                                          var iconList = [
                                            clouds,
                                            humidity,
                                            windspeed
                                          ];
                                          var valueList = [
                                            '${data.clouds!.all} %',
                                            '${data.main!.humidity} %',
                                            '${data.wind!.speed}km/h'
                                          ];
                                          return Column(
                                            children: [
                                              Image.asset(
                                                iconList[index],
                                                width:
                                                    ScreenSize.getScreenWidth(
                                                        60),
                                                height:
                                                    ScreenSize.getScreenHieght(
                                                        90),
                                              )
                                                  .box
                                                  .color(Colors.grey
                                                      .withOpacity(0.5))
                                                  .padding(
                                                      const EdgeInsets.all(4))
                                                  .roundedSM
                                                  .make(),
                                              ScreenSize.getScreenHieght(20)
                                                  .heightBox,
                                              valueList[index]
                                                  .text
                                                  .size(ScreenSize.screenWidth /
                                                      24)
                                                  .white
                                                  .make(),
                                            ],
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: ScreenSize.getScreenHieght(15),
                            child: FutureBuilder(
                              future: controller.HourlyWeatherData,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  );
                                } else {
                                  HourlyWeatherData hourlyData = snapshot.data;
                                  return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: hourlyData.list!.length > 6
                                        ? 6
                                        : hourlyData.list!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var time = DateFormat.jm().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              hourlyData.list![index].dt!
                                                      .toInt() *
                                                  1000));

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height:
                                              ScreenSize.getScreenHieght(80),
                                          width: ScreenSize.getScreenWidth(80),
                                          decoration: BoxDecoration(
                                              color: textColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Column(
                                                children: [
                                                  '${hourlyData.list![index].main!.temp} $degree'
                                                      .text
                                                      .size(16)
                                                      .semiBold
                                                      .white
                                                      .make(),
                                                  Image.asset(
                                                      width: ScreenSize
                                                          .getScreenWidth(60),
                                                      'assets/images/${hourlyData.list![index].weather![0].icon}.png'),
                                                  '$time'
                                                      .text
                                                      .size(18)
                                                      .semiBold
                                                      .white
                                                      .make(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              height: 20,
                              width: double.infinity,
                              color: Colors.white,
                              child: Center(
                                child: 'Next 7 Days'
                                    .text
                                    .size(10)
                                    .color(textColor)
                                    .semiBold
                                    .fontFamily('poppins')
                                    .make(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 7,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var weather = [
                                        'clear',
                                        'suny',
                                        'cloudy',
                                        'cloudy',
                                        'suny',
                                        'fogy',
                                        'clear'
                                      ];
                                      var temp = [
                                        '27',
                                        '30',
                                        '26',
                                        '26',
                                        '29',
                                        '22',
                                        '24'
                                      ];
                                      var days = DateFormat('EEEE').format(
                                          DateTime.now()
                                              .add(Duration(days: index + 1)));
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            color: textColor,
                                            height: 50,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                      width: 100,
                                                      child: days.text
                                                          .fontFamily('poppins')
                                                          .semiBold
                                                          .white
                                                          .make()),
                                                  const Spacer(),
                                                  Image.asset(clouds),
                                                  5.widthBox,
                                                  weather[index]
                                                      .text
                                                      .white
                                                      .make(),
                                                  const Spacer(),
                                                  '${temp[index]} $degree'
                                                      .text
                                                      .white
                                                      .make(),
                                                ],
                                              ),
                                            )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white)),
              )));
  }
}
