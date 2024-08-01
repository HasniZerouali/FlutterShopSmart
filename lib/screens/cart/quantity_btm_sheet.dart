import 'package:flutter/material.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              //bach tnjm dirha dakhal column dir bsh makach scrol tarika 1 : w zid dir column fi singl..Scrol.
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              //tarika taniya dirha fi expended
              itemCount: 22,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  //bach twali btm w tani kayn GestureDetector
                  onTap: () {
                    print('index  $index');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: SubtitleTextWidget(
                        label: "${index + 1}",
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
