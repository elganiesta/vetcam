import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/notifiers/workshops_notifier.dart';

class Sections extends StatelessWidget {
  const Sections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorkshopsNotifier workshopsNotifier =
        Provider.of<WorkshopsNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/vetcam.png",
              width: 500,
              height: 250,
            ),
            Text(
              workshopsNotifier.currWorkshopModel?.name as String,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sections
                  .map((section) {
                    return GFButton(
                      size: GFSize.LARGE,
                      color: GFColors.DARK,
                      onPressed: () {
                        workshopsNotifier.currSection = section;
                        Navigator.pushNamed(context, '/Services');
                      },
                      text: section,
                    );
                  })
                  .toList()
                  .cast<Widget>(),
            ),
          ],
        ),
      ),
    );
  }
}
