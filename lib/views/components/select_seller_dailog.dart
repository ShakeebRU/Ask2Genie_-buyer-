import 'package:flutter/material.dart';
import 'package:genie/controllers/auth/query_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/query/buyer_notification_list_model.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';

class SelectNotificationDialog extends StatelessWidget {
  final List<NotificationModel> notificationsList;

  const SelectNotificationDialog({super.key, required this.notificationsList});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Constants.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select a Notification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center,
              children: List.generate(notificationsList.length, (index) {
                NotificationModel notification = notificationsList[index];
                String queryTime =
                    Utils.getTimeElapsed(notification.queryDateTime);

                return GestureDetector(
                  onTap: () async {
                    Navigator.pop(context, notification);
                  },
                  child: Container(
                    height: 90,
                    width: 200,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Constants.secondaryColor,
                      border: BorderDirectional(
                          bottom: BorderSide(
                              color: Constants.primaryColor, width: 0.7)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              queryTime.toString(),
                              style: TextStyle(
                                fontSize: 8,
                                fontFamily: GoogleFonts.akatab().fontFamily,
                                color: Constants.textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFFC4C4C4),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(notification.sellerImageURL),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                    spreadRadius: 0.6,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 45,
                              height: 20,
                              child: Text(
                                notification.sellerName,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: GoogleFonts.anta().fontFamily,
                                  color: Constants.primaryColor,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Text(
                              notification.sellerRemarks,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: GoogleFonts.akatab().fontFamily,
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
