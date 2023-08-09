import 'package:flutter/material.dart';

containerButton({
  text,
  onTap,
  context,
  loading = false,
  alert = false,
}) {
  AnimationController controller;
  return Center(
    child: InkWell(
      onTap: onTap,
      child: Container(
          width: alert
              ? MediaQuery.of(context).size.width * 0.4
              : MediaQuery.of(context).size.width * 0.7,
          // height: 57.0,
          height: alert ? 37.0 : 57.0,
          // padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: alert ? BorderRadius.circular(10) : null,
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
    ),
  );
}
