// import 'package:flutter/material.dart';
//
// import 'package:food_delivery/theme.dart';
//
// import 'justmain2.dart';
//
//
//
// class AddressPaymentPage extends StatefulWidget {
//   const AddressPaymentPage({Key? key}) : super(key: key);
//
//   @override
//   _AddressPaymentPageState createState() => _AddressPaymentPageState();
// }
//
// class _AddressPaymentPageState extends State<AddressPaymentPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _address = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text('Address and Payment',style: TextStyle(color: AppColor.primaryColor,),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Address Input Field
//               const Text('Enter your address:', style: TextStyle(fontWeight: FontWeight.bold,color: AppColor.primaryColor,)),
//               TextFormField(style: TextStyle(color: Colors.white),
//                 decoration: const InputDecoration(border: OutlineInputBorder(),
//                   hintText: '123 Main St, City, Country',
//                   hintStyle: TextStyle(color: Colors.grey)
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _address = value!;
//                 },
//               ),
//               const SizedBox(height: 20),
//
//               // Payment Widget
//               const PaymentWidget(),
//               const SizedBox(height: 20),
//
//               // Confirm Order Button
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                   backgroundColor: textboxColor, // Button background color
//                   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // Process the order and payment
//                       _processOrder();
//                     }
//                   },
//                   child: const Text('Confirm Order'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _processOrder() {
//     // Simulate order processing
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Order placed successfully!')),
//     );
//   }
// }
//
//
