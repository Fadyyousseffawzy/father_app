import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAddBotton extends StatelessWidget {
  const CustomAddBotton(
      {super.key, this.onTap, this.isloading = false, required this.texet});
  final void Function()? onTap;
  final String texet;

  final bool isloading;

  get kPrimeryColor => null;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: isloading
                ? const SizedBox(
                    height: 24,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : Text(
                    texet,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
      ),
    );
  }
}
