import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:vetcam/const.dart';
import 'package:vetcam/notifiers/workshops_notifier.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

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
              '${workshopsNotifier.currWorkshopModel?.name as String} : ${workshopsNotifier.currSection as String}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: services
                  .map((service) {
                    return GFButton(
                      size: GFSize.LARGE,
                      color: GFColors.PRIMARY,
                      onPressed: () {
                        Navigator.pushNamed(context, '/OrdresTravail');
                      },
                      text: service,
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
