import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Workshops extends StatelessWidget {
  const Workshops({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/vetcam.png",
              width: 500,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                    size: GFSize.LARGE,
                    onPressed: (){},
                    text:"Alpha"
                ),
                GFButton(
                    size: GFSize.LARGE,
                    onPressed: (){},
                    text:"Tensyland"
                ),
                GFButton(
                    size: GFSize.LARGE,
                    onPressed: (){},
                    text:"NovaBloc"
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


