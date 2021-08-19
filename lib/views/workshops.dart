import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/models/workshop_model.dart';
import 'package:vetcam/notifiers/workshops_notifier.dart';

class Workshops extends StatelessWidget {
  const Workshops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkshopsNotifier workshopsNotifier = Provider.of<WorkshopsNotifier>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/vetcam.png",
              width: 500,
              height: 300,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: workshops.map((workshop) {
                return GFButton(
                    size: GFSize.LARGE,
                    color: GFColors.DARK,
                    onPressed: (){
                      WorkshopModel workShopModel = WorkshopModel({
                        'name': workshop
                      });
                      workshopsNotifier.currWorkshopModel = workShopModel;
                      Navigator.pushNamed(context, '/Sections');
                    },
                    text: workshop
                );
              }).toList().cast<Widget>(),
            ),
          ],
        ),
      ),
    );
  }
}


