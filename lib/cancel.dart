import 'package:flutter/material.dart';
import 'package:kwansports/transformer.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({Key? key}) : super(key: key);

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  var data = currentOrderState();
  final _dataToSend = {};

  @override
  Widget build(BuildContext context) {
    print(_dataToSend);
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            String key = data.keys.elementAt(index);

            if (data[key] - (_dataToSend[key] ?? 0) <= 0) {
              return Container(); // or return SizedBox.shrink();
            }

            return ListTile(
              leading: IconButton(
                  onPressed: () {
                    setState(() {
                      if (_dataToSend.containsKey(key)) {
                        _dataToSend[key] > 0 ? _dataToSend[key]-- : null;
                      }
                    });
                  },
                  icon: const Icon(Icons.add_circle)),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      if (data[key] > 0) {
                        if (_dataToSend.containsKey(key)) {
                          _dataToSend[key] = _dataToSend[key] + 1;
                        } else {
                          _dataToSend[key] = 1;
                        }
                      }
                    });
                  },
                  icon: const Icon(Icons.remove_circle)),
              title: Text("$key  ${data[key] - (_dataToSend[key] ?? 0)}"),
            );
          },
        ),
      ),
    );
  }
}
