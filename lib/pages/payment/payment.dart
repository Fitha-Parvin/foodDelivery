// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// import '../../theme.dart';
//
// class PaymentWidget extends StatefulWidget {
//   final double amount; // Amount to be passed
//
//   const PaymentWidget({Key? key, required this.amount}) : super(key: key);
//
//   @override
//   _PaymentWidgetState createState() => _PaymentWidgetState();
// }
//
// class _PaymentWidgetState extends State<PaymentWidget> {
//   late Razorpay _razorpay;
//   String _selectedPaymentMethod = 'Credit Card';
//   final _creditCardController = TextEditingController();
//   final _expiryDateController = TextEditingController();
//   final _cvvController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     _creditCardController.dispose();
//     _expiryDateController.dispose();
//     _cvvController.dispose();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Payment Successful: ${response.paymentId}')),
//     );
//     // Navigate to success page or clear the cart here
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Payment Error: ${response.code} - ${response.message}')),
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('External Wallet: ${response.walletName}')),
//     );
//   }
//
//   void _openCheckout() {
//     var options = {
//       'key': 'rzp_live_ILgsfZCZoFIKMb', // Replace with your Razorpay key
//       'amount': widget.amount * 100, // Use the amount from widget
//       'name': 'Food Delivery',
//       'description': 'Order Payment',
//       'prefill': {
//         'contact': '1234567890',
//         'email': 'test@example.com'
//       },
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Select Payment Method:',
//           style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
//         ),
//         DropdownButton<String>(
//           value: _selectedPaymentMethod,
//           onChanged: (String? newValue) {
//             setState(() {
//               _selectedPaymentMethod = newValue!;
//             });
//           },
//           items: <String>['Credit Card', 'PayPal', 'Google Pay', 'Cash on Delivery']
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value, style: TextStyle(color: AppColor.primaryColor)),
//             );
//           }).toList(),
//         ),
//         const SizedBox(height: 20),
//
//         if (_selectedPaymentMethod == 'Credit Card') ...[
//           const Text(
//             'Enter Credit Card Details:',
//             style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
//           ),
//           _buildCreditCardForm(),
//         ],
//
//         if (_selectedPaymentMethod == 'PayPal') ...[
//           const Text('Redirecting to PayPal...', style: TextStyle(color: Colors.blue)),
//         ],
//         if (_selectedPaymentMethod == 'Google Pay') ...[
//           const Text('Redirecting to Google Pay...', style: TextStyle(color: Colors.green)),
//         ],
//       ],
//     );
//   }
//
//   Widget _buildCreditCardForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           TextFormField(
//             controller: _creditCardController,
//             decoration: const InputDecoration(
//               labelText: 'Credit Card Number',
//               hintText: '1234 5678 9012 3456',
//               border: OutlineInputBorder(),
//             ),
//             keyboardType: TextInputType.number,
//             validator: (value) {
//               if (value == null || value.isEmpty || value.length != 16) {
//                 return 'Please enter a valid 16-digit credit card number';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _expiryDateController,
//                   decoration: const InputDecoration(
//                     labelText: 'Expiry Date',
//                     hintText: 'MM/YY',
//                     hintStyle: TextStyle(color: Colors.grey),
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.datetime,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || !RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
//                       return 'Please enter a valid expiry date';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: TextFormField(
//                   controller: _cvvController,
//                   decoration: const InputDecoration(
//                     labelText: 'CVV',
//                     hintText: '123',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || value.length != 3) {
//                       return 'Please enter a valid 3-digit CVV';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.primaryColor,
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//             onPressed: () {
//               if (_formKey.currentState!.validate()) {
//
//                 _openCheckout();
//               }
//             },
//             child: const Text('Proceed To Payement'),
//           ),
//         ],
//       ),
//     );
//   }
// }
