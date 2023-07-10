import 'package:flutter/material.dart';

class ProfileSelectionPage extends StatefulWidget {
  const ProfileSelectionPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileSelectionPageState createState() => _ProfileSelectionPageState();
}

class _ProfileSelectionPageState extends State<ProfileSelectionPage> {
  String selectedProfile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Please select your profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedProfile = 'Shipper';
                    });
                  },
                  child: Container(
                    width: 300,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedProfile == 'Shipper'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio<String>(
                            value: 'Shipper',
                            groupValue: selectedProfile,
                            onChanged: (value) {
                              setState(() {
                                selectedProfile = value!;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Shipper',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedProfile = 'Transporter';
                    });
                  },
                  child: Container(
                    width: 300,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedProfile == 'Transporter'
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Transporter',
                            groupValue: selectedProfile,
                            onChanged: (value) {
                              setState(() {
                                selectedProfile = value!;
                              });
                            },
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Transporter',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Lorem ipsum dolor sit amet,\nconsectetur adipiscing',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (selectedProfile == 'Shipper') {
                      // Handle Shipper selection
                      // Navigate to the desired Shipper page
                    } else if (selectedProfile == 'Transporter') {
                      // Handle Transporter selection
                      // Navigate to the desired Transporter page
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        const Color(0xFF2E3B62), // Set the background color
                    minimumSize:
                        const Size(double.infinity, 36), // Adjust the height
                    padding:
                        const EdgeInsets.only(left: 20), // Adjust the padding
                  ),
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
