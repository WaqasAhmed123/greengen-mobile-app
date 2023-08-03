import 'package:flutter/material.dart';

containerButton({
  text,
  onTap,
  context,
  loading,
}) {
  AnimationController controller;
  return InkWell(
    onTap: onTap,
    child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 57.0,
        // padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
        )),
  );
}
