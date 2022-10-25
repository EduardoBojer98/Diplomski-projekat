import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleauth/screens/home_screen.dart';
import 'package:googleauth/screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.roboto(),
      ),
      leading: GestureDetector(onTap: (){Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage()));},
        child: Image.asset(
          'assets/logo.png',
          scale: 1.6,
        ),
      ),
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.person_outlined))
      ],
    );
  }
}
