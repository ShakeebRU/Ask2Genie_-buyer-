import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:genie/controllers/auth/query_controller.dart';
import 'package:genie/utils/constants.dart';
import 'package:genie/utils/utils.dart';
import 'package:provider/provider.dart';
import '../../models/query/buyer_notification_list_model.dart'; // Ensure this import

class RateSellerDialog extends StatefulWidget {
  final NotificationModel notification;

  RateSellerDialog({required this.notification});

  @override
  _RateSellerDialogState createState() => _RateSellerDialogState();
}

class _RateSellerDialogState extends State<RateSellerDialog> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rate Seller: ${widget.notification.sellerName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Display seller details
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.notification.sellerImageURL),
            ),
            SizedBox(height: 10),
            Text(
              'Product: ${widget.notification.productName}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Price: ${widget.notification.rate}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              widget.notification.sellerRemarks,
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),

            // Star rating bar
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating;
                });
              },
            ),
            SizedBox(height: 20),

            // Submit button to return the rating value
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Constants.primaryColor),
                  shape: WidgetStatePropertyAll(BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ))),
              onPressed: () async {
                Navigator.pop(context, rating.toInt());
              },
              child: Text('Submit Rating'),
            ),
          ],
        ),
      ),
    );
  }
}
