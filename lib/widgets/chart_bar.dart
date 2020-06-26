import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double percentOfTotal;

  ChartBar(this.label, this.amountSpent, this.percentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  '\$${amountSpent.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            //Keep the spacing between text and Bar
            SizedBox(height: constraints.maxHeight * 0.02),
            Container(
              height: constraints.maxHeight * 0.7,
              width: 13,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(3)),
                ),
                FractionallySizedBox(
                  heightFactor: percentOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff303030),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
