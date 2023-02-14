import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/app_fonts.dart';
import '../../../style/app_size.dart';
import '../../../widget/button_clip.dart';
import '../../search_screen.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ButtonClip(
      color: Colors.grey.shade100,
      radius: 10,
      onPress: (){
        Get.to(()=>SearchScreen());
      },
      padding: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child:Row(
          children: [
            Icon(Icons.search),
            SizedBox(width: 15,),
            Text('Search a Task...',
              style: largeFonts,
            )
          ],
        ),
      ),
    );
  }
}