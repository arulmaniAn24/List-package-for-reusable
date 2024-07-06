import 'package:flutter/material.dart';

import 'beneficiarydetails.dart';
import '../constants/colors.dart';

class Beneficiaries extends StatefulWidget {
  const Beneficiaries({super.key});

  @override
  State<Beneficiaries> createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  final List<Beneficiary> beneficiaries = [
    Beneficiary(
        name: "Harry",
        type: "Individual",
        phone: "+91 93*******",
        eligibility: 3,
        applied: 2),
    Beneficiary(
        name: "Lakshmi",
        type: "Family",
        phone: "+91 87*******",
        eligibility: 4,
        applied: 3),
    Beneficiary(
        name: "Priya",
        type: "Family",
        phone: "+91 77*******",
        eligibility: 3,
        applied: 1),
    Beneficiary(
        name: "John",
        type: "Individual",
        phone: "+91 65*******",
        eligibility: 2,
        applied: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary2Color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("My Beneficiaries"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: beneficiaries.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeneficiaryDetails(
                      beneficiary: beneficiaries[index],
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  margin: const EdgeInsets.all(6.0),
                  color: AppColors.primary2Color,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          beneficiaries[index].name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          beneficiaries[index].type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                beneficiaries[index].phone,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    beneficiaries[index].eligibility.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Eligibility",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    beneficiaries[index].applied.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Applied",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Beneficiary {
  final String name;
  final String type;
  final String phone;
  final int eligibility;
  final int applied;

  Beneficiary({
    required this.name,
    required this.type,
    required this.phone,
    required this.eligibility,
    required this.applied,
  });
}
