import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class CompanyListViewSkeletonLoader extends StatefulWidget {
  // #region Constructor

  const CompanyListViewSkeletonLoader({super.key});

  // #endregion

  @override
  State<CompanyListViewSkeletonLoader> createState() =>
      _CompanyListViewSkeletonLoaderState();
}

class _CompanyListViewSkeletonLoaderState
    extends State<CompanyListViewSkeletonLoader> {
  // #region Members 'Build' :: build()

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SkeletonLoader(
          builder: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 7)),
              SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.only(bottom: 40));
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 10,
                          color: Colors.white,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 12)),
                        Container(
                          width: double.infinity,
                          height: 10,
                          color: Colors.white,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 12)),
                        Container(
                          width: double.infinity,
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          items: 1,
          period: const Duration(seconds: 2),
          highlightColor: const Color(0xFF023b78),
          direction: SkeletonDirection.ltr,
        ),
      ),
    );
  }

  // #endregion
}
