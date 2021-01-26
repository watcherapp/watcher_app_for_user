import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watcher_app_for_user/Common/appColors.dart';
import 'package:watcher_app_for_user/Common/fontStyles.dart';

class DialogOpenFormField extends StatelessWidget {
  String lable;
  String value;
  VoidCallback onTap;

  DialogOpenFormField(
      {@required this.lable, @required this.onTap, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
          child: Text(lable ?? "", style: fontConstants.formFieldLabel),
        ),
        Container(
          height: 50,
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    "${value ?? "$lable"}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.arrow_drop_down_circle_rounded,
                    size: 20,
                    color: appPrimaryMaterialColor,
                  ),
                )
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0)),
        ),
      ],
    );
  }
}
