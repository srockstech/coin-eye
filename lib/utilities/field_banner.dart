import 'package:flutter/material.dart';
import 'constants.dart';

class FieldBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Container(
                    child: Text(
                      'COIN NAME',
                      style: kFieldNameTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    'PRICE',
                    textAlign: TextAlign.center,
                    style: kFieldNameTextStyle,
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Text(
                    '24H CHANGE',
                    textAlign: TextAlign.center,
                    style: kFieldNameTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: SizedBox(
            height: 0,
            child: Divider(
              // height: ,
              thickness: 1,
            ),
          ),
        ),
      ],
    );
  }
}
