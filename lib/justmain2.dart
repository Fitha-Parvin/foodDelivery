import 'package:flutter/material.dart';
import 'package:food_delivery/theme.dart';

class PaymentScreen extends StatefulWidget {
  final List<String> foodImages; // Updated to accept a list of images
  final double amount;
  final List<String> foodNames;
  final List<int> quantities;
  // Added to accept a list of quantities

  const PaymentScreen({
    Key? key,
    required this.foodImages,
    required this.amount,
    required this.foodNames,
    required this.quantities,
    // Added
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCountry = 'United States of America';
  String? _selectedState = 'Alabama';
  String _selectedPaymentMethod = 'Credit Card';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Billing Information
              Text(
                'Billing Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              // DropdownButtonFormField<String>(
              //   value: _selectedCountry,
              //   items: ['India', 'United States of America', 'Canada']
              //       .map((country) => DropdownMenuItem<String>(
              //     value: country,
              //     child: Text(country),
              //   ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedCountry = value;
              //     });
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'Country',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedState,
                items: ['Kerala', 'Karnataka', 'Alabama', 'Alaska', 'Arizona']
                    .map((state) => DropdownMenuItem<String>(
                  value: state,
                  child: Text(state),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Payment Method
              Text(
                'Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Row(
                        children: [
                          Image.asset(
                            'assets/images/visa.png',
                            height: 24,
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            'assets/images/mastercard.png',
                            height: 24,
                          ),
                        ],
                      ),
                      leading: Radio<String>(
                        value: 'Credit Card',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Image.asset(
                        'assets/images/paypal.png',
                        height: 24,
                      ),
                      leading: Radio<String>(
                        value: 'PayPal',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _selectedPaymentMethod == 'Credit Card'
                  ? Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your card number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expirationController,
                          decoration: InputDecoration(
                            labelText: 'Expiration',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expiration date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : SizedBox.shrink(),
              SizedBox(height: 20),

              // Order Summary
              Text(
                'You\'re buying',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(widget.foodImages.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Image.asset(widget.foodImages[index], height: 50, width: 50),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${widget.foodNames[index]} x${widget.quantities[index]}', // Show quantity here
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              SizedBox(height: 10),

              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${widget.amount.toStringAsFixed(2)} USD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: AlertDialog(
                          backgroundColor: AppColor.primaryColor,
                          title: const Text('Order Successful!'),
                          content: Text(
                            'Thank you, ${_firstNameController.text}! Your order has been placed successfully and will be delivered to ${_addressController.text}, ${_selectedState}, ${_selectedCountry}.',
                          ),
                        ),
                      ),
                    );
                    // Handle form submission
                    print('Form is valid');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Submit order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
