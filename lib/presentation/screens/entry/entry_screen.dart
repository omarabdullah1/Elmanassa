import 'package:edumaster/presentation/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/app_localization.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = GlobalCubit.get(context);
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Color(0xFFA1C6EA)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height,
                left: MediaQuery.of(context).size.width,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.55,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x7F00467A),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 24,
                top: 500,
                child: Text(
                  'أول منصة تعليمية ألكترونية بالكامل',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF00467A),
                    fontSize: 20,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
              ),
              const Positioned(
                left: 30,
                top: 543,
                child: Text(
                  'التعليم الجيد و المستمر هو مفتاحك لمستقبل أفضل\nمكان واحد تقدر تتعلم فيه كل المواد و الكورسات.. \nابدأ دلوقتي في المنصة',
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF00467A),
                    fontSize: 14,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    height: 0.11,
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width*0.28,
                top: 416,
                child: Container(
                  width: 171,
                  height: 43,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/171x43"),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x7FFFB400),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                top: 61,
                child: Container(
                  width: 321,
                  height: 271,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/321x271"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 107,
                top: 642,
                child: Container(
                  width: 147,
                  height: 38,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 147,
                          height: 38,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFDF2935),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(21),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 15,
                        top: 6,
                        child: Text(
                          'تسجيل الدخول',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w700,
                            height: 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 107,
                top: 709,
                child: Container(
                  width: 146,
                  height: 52,
                  child: const Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Text(
                          'ان كنت طالب جديد بالنظام',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF00467A),
                            fontSize: 14,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            height: 0.11,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 27,
                        top: 25,
                        child: Text(
                          'حساب جديد',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFDF2935),
                            fontSize: 18,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.w700,
                            height: 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

      },
    );
  }
}
