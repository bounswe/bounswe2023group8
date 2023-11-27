import 'package:flutter/material.dart';
import 'package:mobile/data/models/interest_area.dart';

class BunchWidget extends StatelessWidget {
  final InterestArea ia;
  final void Function()? onTap;
  const BunchWidget({super.key, required this.ia, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xffCDCFCF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ia.name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff434343)),
            ),
            Icon(
              ia.accessLevel == 'PUBLIC' ? Icons.public : Icons.lock,
            )
          ],
        ),
      ),
    );
  }
}
