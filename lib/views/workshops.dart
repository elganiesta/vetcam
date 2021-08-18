import 'package:flutter/material.dart';

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
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Workshop(
                  name: 'Alpha',
                  onTap: () {
                    Navigator.pushNamed(context, '/test');
                  },
                ),
                Workshop(
                  name: 'Tensyland',
                  onTap: () {},
                ),
                Workshop(
                  name: 'NovaBloc',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Workshop extends StatelessWidget {

  const Workshop({
    Key? key, required this.onTap, required this.name,
  }) : super(key: key);

  final void Function() onTap;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 25.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        child: Text(name),
      ),
    );
  }
}
