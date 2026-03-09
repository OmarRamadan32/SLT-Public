import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';

class CommitteeCardDetails extends StatelessWidget {
  const CommitteeCardDetails({
    super.key,
    required this.committeeLeaderName,
    required this.committeeMembersCount,
  });
  final String committeeLeaderName;
  final int committeeMembersCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            committeeLeaderName,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.group, color: Constants.secondaryColor, size: 16.r),
              SizedBox(width: 4.w),
              Text(
                committeeMembersCount.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontFamily: Constants.englishFont,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
