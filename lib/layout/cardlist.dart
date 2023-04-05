import 'dart:core';
import 'package:flutter/material.dart';

// class CardListContainer extends StatelessWidget {
//   String? property;
//   String? serviceType;
//   int? id;
//   String? text;
//   String? issueType;
//   String? priority;
//   String? unit;
//   String? category;

//   CardListContainer({
//     super.key,
//     this.property,
//     this.serviceType,
//     this.id,
//     this.text,
//     this.issueType,
//     this.priority,
//     this.unit,
//     this.category,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: 340,
//         height: 135,
//         decoration: const BoxDecoration(
//             border: Border(bottom: BorderSide()), color: Colors.white),
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     property!,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text('$serviceType - $id'),
//                   trailing: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 40,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6),
//                         border: Border.all(color: Colors.blue)),
//                     child: Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(text!, textAlign: TextAlign.center),
//                           IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.keyboard_arrow_down_sharp))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             //const SizedBox(height: 6),
//             Flexible(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(issueType!, textAlign: TextAlign.start),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Container(
//               padding: const EdgeInsets.only(left: 15),
//               child: Row(children: [
//                 Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: 70,
//                           child: const Text(
//                             'priority',
//                             textAlign: TextAlign.left,
//                           )),
//                       Container(
//                           width: 70,
//                           child: Text(
//                             priority!,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ))
//                     ]),
//                 Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(width: 140, child: const Text('Location')),
//                       Container(
//                           width: 140,
//                           child: Text(
//                             'Unit: $unit',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ))
//                     ]),
//                 Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(child: const Text('Category')),
//                       Container(
//                           child: Text(
//                         category!,
//                         style: const TextStyle(fontWeight: FontWeight.w300),
//                       ))
//                     ]),
//               ]),
//             )
//           ],
//         ));
//   }
// }

Widget cardListContainer(
    String? property,
    String? serviceType,
    int? id,
    String? text,
    String? issueType,
    String? priority,
    String? unit,
    String? category) {
  return Container(
      width: 340,
      height: 135,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()), color: Colors.white),
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  property!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('$serviceType - $id'),
                trailing: IntrinsicWidth(
                  child: Container(
                    //width: 105,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.blue)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text!, textAlign: TextAlign.center),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.keyboard_arrow_down_sharp))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //const SizedBox(height: 6),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(issueType!, textAlign: TextAlign.start),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 70,
                            child: const Text(
                              'priority',
                              textAlign: TextAlign.left,
                            )),
                        Container(
                            width: 70,
                            child: Text(
                              priority!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 140, child: const Text('Location')),
                        Container(
                            width: 140,
                            child: Text(
                              'Unit: $unit',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(child: const Text('Category')),
                        Container(
                            child: Text(
                          category!,
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ))
                      ]),
                ]),
          )
        ],
      ));
}
// switch (settings.name) {
//       case '/Emergency':
//         return Text(text,style)
//       case '/High':
//         return 
//       case '/least1':        
//         return 
//         case '/least2':        
//         return 
//         case '/least3':        
//         return 
//         case '/Medium':        
//         return 
      
//     }
