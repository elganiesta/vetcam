import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GFButton(
                  size: GFSize.LARGE,
                  color: GFColors.DARK,
                  onPressed: () {
                    Navigator.pushNamed(context, '/OrdresTravail');
                  },
                  text: "ORDRES DU TRAVAIL",
                ),
                GFButton(
                  size: GFSize.LARGE,
                  color: GFColors.DARK,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Matieres');
                  },
                  text: "P.D.R",
                ),
                GFButton(
                  size: GFSize.LARGE,
                  color: GFColors.DARK,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Moules');
                  },
                  text: "SUIVI DES MOULES",
                ),
                GFButton(
                  size: GFSize.LARGE,
                  color: GFColors.DARK,
                  onPressed: () {
                    Navigator.pushNamed(context, '/Besoins');
                  },
                  text: "FICHES BESOINS",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
