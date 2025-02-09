
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minner/app/app.dart';
import 'package:minner/core/utils/responsive/responsive_sizes.dart';

class MinersPage extends StatefulWidget{
  const MinersPage({super.key});

  @override
  State<MinersPage> createState() => _MinersPageState();

}


class _MinersPageState extends State<MinersPage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      title: const Text("Available Miners"),
    ),
     body: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           const Center(child: Text("data is coming",)),
         Container( height: 500.h,
           decoration: BoxDecoration(
             color: Theme.of(context).colorScheme.surface
           ),
           child: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child:Column(
               children: List.generate(14,(index)=> _buildMinerMachine(context,index)),
             ) ,
           ),
         )
         ],

       ),
     ),
   );
  }
Widget _buildMinerMachine(BuildContext context, int index){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.w,horizontal: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8)
              ),
              height: 120.h,
              child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text("data"),
                    ],
                  ),
                  Container( height: 100.h, width: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: Text("data"))),),
                ],
              ),
            ),
          ),
        ],
      ),
    );

}

}