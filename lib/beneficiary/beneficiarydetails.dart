import 'package:flutter/material.dart';

import '../applied/applied_section.dart';
import '../checkeligibilty/check_eligibility_section.dart';
import '../constants/colors.dart';
import '../familymembers/family_members_section.dart';
import 'beneficiaries.dart';
import 'profile_completion_section.dart';

class BeneficiaryDetails extends StatefulWidget {
  final Beneficiary beneficiary;
  const BeneficiaryDetails({super.key, required this.beneficiary});

  @override
  State<BeneficiaryDetails> createState() => _BeneficiaryDetailsState();
}

class _BeneficiaryDetailsState extends State<BeneficiaryDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary2Color,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("${widget.beneficiary.name}'s Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const ProfileCompletionSection(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Material(
                color: Colors.transparent,
                child: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  indicatorColor: AppColors.backgroundColor,
                  labelColor: AppColors.backgroundColor,
                  unselectedLabelColor: AppColors.backgroundColor,
                  labelStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: 'Family Members'),
                    Tab(text: 'Applied'),
                    Tab(text: 'Check Eligibility'),
                  ],
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTabBarView(),
        ],
      ),
    );
  }

  Widget _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          FamilyMembersSection(),
          AppliedSection(),
          EligibilityCheckSection(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
