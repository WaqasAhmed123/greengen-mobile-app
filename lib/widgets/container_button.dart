import 'package:flutter/material.dart';

containerButton({
  text,
  onTap,
  context,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          // style: Theme.of(context).textTheme.labelLarge,
          style: const TextStyle(
            fontSize: 18.0,
            // fontFamily: "Poppins",
            color: Colors.white,
          ),
        )),
  );
}
