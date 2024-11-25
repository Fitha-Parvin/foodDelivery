// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery/pages/payment/payment.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:food_delivery/theme.dart';
//
// class AddressPaymentPage extends StatefulWidget {
//   final double amount; // Amount to be passed
//
//   const AddressPaymentPage({
//     Key? key,
//     required this.amount,
//   }) : super(key: key);
//
//   @override
//   _AddressPaymentPageState createState() => _AddressPaymentPageState();
// }
//
// class _AddressPaymentPageState extends State<AddressPaymentPage> {
//   late Razorpay _razorpay;
//   final _addressController = TextEditingController();
//   final _nameController = TextEditingController();
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
//     _addressController.dispose();
//     _nameController.dispose();
//     super.dispose();
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     if (mounted) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Order Successful!'),
//             content: Text(
//               'Thank you, ${_nameController.text}! Your order has been placed successfully and will be delivered to ${_addressController.text}.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                   Navigator.of(context).pop(); // Navigate back after the order confirmation
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
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
//       'amount': widget.amount * 100, // Amount in paise
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
//     final amount = widget.amount.toStringAsFixed(2); // Format amount to two decimal places
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: AppColor.primaryColor,
//         title: const Text('Address & Payment'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Delivery Address:',
//                 style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColor),
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(style: TextStyle(color: Colors.white),
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your Name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(style: TextStyle(color: Colors.white),
//                       controller: _addressController,
//                       decoration: const InputDecoration(
//                         labelText: 'Address',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your address';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text(
//                     'Amount you have to pay: ', // Display the amount
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
//                   ),
//                   Text(
//                     ' \$${amount}', // Display the amount
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               // Your Payment Widget
//               PaymentWidget(amount: widget.amount),
//               Padding(
//                 padding: const EdgeInsets.only(left: 170, top: 30),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.primaryColor,
//                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//
//                       // Display a snackbar confirming order
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                          content:
//                             AlertDialog(backgroundColor: AppColor.primaryColor,
//                         title: const Text('Order Successful!'),
//                         content: Text(
//                           'Thank you, ${_nameController.text}! Your order has been placed successfully and will be delivered to ${_addressController.text}.',
//                         ),
//                             ) ),
//                       );
//
//                       // Proceed to Razorpay checkout
//                       _openCheckout();
//                     }
//                   },
//                   child: const Text('Confirm Order', style: TextStyle(color: Colors.black)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
