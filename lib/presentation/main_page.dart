import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../widgets/button_widgets.dart';
import '../widgets/textfield_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Controller Value
  TextEditingController xController = TextEditingController();
  TextEditingController xkController = TextEditingController();
  TextEditingController xkPlusSatuController = TextEditingController();
  TextEditingController ykController = TextEditingController();
  TextEditingController ykPlusSatuController = TextEditingController();

  // Selected Event
  bool isSelected = false;

  bool showDSS = false;

  // Variable Value
  double y = 0;

  num calculate() {
    double xValue = double.tryParse(xController.value.text) ?? 0.0;
    double xkValue = double.tryParse(xkController.value.text) ?? 0.0;
    double xkPlusSatuValue =
        double.tryParse(xkPlusSatuController.value.text) ?? 0.0;
    double ykValue = double.tryParse(ykController.value.text) ?? 0.0;
    double ykPlusSatuValue =
        double.tryParse(ykPlusSatuController.value.text) ?? 0.0;

    double logXK = math.log(xkValue);
    double logXKPlusSatu = math.log(xkPlusSatuValue);

    y = ((isSelected) ? logXK : ykValue) +
        ((xValue - xkValue) / (xkPlusSatuValue - xkValue)) *
            (((isSelected) ? logXKPlusSatu : ykPlusSatuValue) -
                ((isSelected) ? logXK : ykValue));

    return y;
  }

  // DSS Code
  num analitik() {
    double value = y;
    return value;
  }

  num numerik() {
    double xValue = double.tryParse(xController.value.text) ?? 0.0;
    double value;
    if (isSelected) {
      value = math.log(xValue);
    } else {
      value = y;
    }
    return value;
  }

  num galatMutlak() {
    var value = analitik() - numerik();
    var valueAbs = value.abs();
    return valueAbs;
  }

  num galatRelatif() {
    var value = galatMutlak() / analitik();
    return value;
  }

  num akurasi() {
    var value = 1 - galatRelatif();
    var result = value * 100;
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    xkController;
    xkPlusSatuController;
    ykController;
    ykPlusSatuController;
    xController;

    isSelected;

    analitik();
    numerik();
    galatMutlak();
    galatRelatif();
    akurasi();

    calculate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Metode Interpolasi Linear",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: "Poppins",
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.amber),
                  child: Center(
                      child: Text(
                    'Y* = ${y.toStringAsFixed(3)}',
                    maxLines: 5,
                    style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                xkValue(),
                const SizedBox(
                  height: 15,
                ),
                xkPlusSatuValue(),
                const SizedBox(
                  height: 15,
                ),
                ykValue(),
                const SizedBox(
                  height: 15,
                ),
                ykPlusSatuValue(),
                const SizedBox(
                  height: 15,
                ),
                xValue(),
                const SizedBox(
                  height: 30,
                ),
                calculateButton(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Show DSS",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                            shape: const OvalBorder(),
                            activeColor: const Color.fromARGB(255, 0, 186, 6),
                            value: showDSS,
                            onChanged: (bool? value) {
                              setState(() {
                                showDSS = value!;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "LN Cek ?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 186, 6)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Checkbox(
                          shape: const OvalBorder(),
                          activeColor: const Color.fromARGB(255, 0, 186, 6),
                          value: isSelected,
                          onChanged: (bool? value) {
                            setState(() {
                              isSelected = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                (showDSS)
                    ? Container(
                        width: double.infinity,
                        height: 400,
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Decision Support System",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1.5,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ButtonWidget(
                                  title: "Analitik",
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: ButtonWidget(
                                        title: analitik().toStringAsFixed(3),
                                        color: Colors.white,
                                        textColor: Colors.black)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ButtonWidget(
                                        title: "Numerik",
                                        color: Colors.blue,
                                        textColor: Colors.white)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: ButtonWidget(
                                        title: numerik().toStringAsFixed(3),
                                        color: Colors.white,
                                        textColor: Colors.black)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ButtonWidget(
                                        title: "Galat Mutlak",
                                        color: Colors.blue,
                                        textColor: Colors.white)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: ButtonWidget(
                                        title: galatMutlak().toStringAsFixed(3),
                                        color: Colors.white,
                                        textColor: Colors.black)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ButtonWidget(
                                        title: "Galat Relatif",
                                        color: Colors.blue,
                                        textColor: Colors.white)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: ButtonWidget(
                                        title:
                                            galatRelatif().toStringAsFixed(3),
                                        color: Colors.white,
                                        textColor: Colors.black)),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: ButtonWidget(
                                        title: "Akurasi",
                                        color: Colors.blue,
                                        textColor: Colors.white)),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: ButtonWidget(
                                        title:
                                            "${akurasi().toStringAsFixed(0)}%",
                                        color: Colors.white,
                                        textColor: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row xkValue() {
    return Row(
      children: [
        ButtonWidget(title: "XK", color: Colors.blue, textColor: Colors.white),
        const SizedBox(
          width: 10,
        ),
        TextInputWidget(title: "Masukkan XK", controller: xkController)
      ],
    );
  }

  Row xkPlusSatuValue() {
    return Row(
      children: [
        ButtonWidget(
            title: "XK + 1", color: Colors.blue, textColor: Colors.white),
        const SizedBox(
          width: 10,
        ),
        TextInputWidget(
            title: "Masukkan XK + 1", controller: xkPlusSatuController)
      ],
    );
  }

  Row ykValue() {
    return Row(
      children: [
        ButtonWidget(title: "YK", color: Colors.blue, textColor: Colors.white),
        const SizedBox(
          width: 10,
        ),
        TextInputWidget(
            title: "Masukkan YK",
            controller: isSelected ? xkController : ykController)
      ],
    );
  }

  Row ykPlusSatuValue() {
    return Row(
      children: [
        ButtonWidget(
            title: "YK + 1", color: Colors.blue, textColor: Colors.white),
        const SizedBox(
          width: 10,
        ),
        TextInputWidget(
            title: "Masukkan YK + 1",
            controller:
                isSelected ? xkPlusSatuController : ykPlusSatuController)
      ],
    );
  }

  SizedBox calculateButton() {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: () {
            setState(() {
              calculate();
            });
          },
          child: const Text(
            "Calculate",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 1,
              fontFamily: "Poppins",
              // letterSpacing: -0.40
            ),
          )),
    );
  }

  Row xValue() {
    return Row(
      children: [
        ButtonWidget(title: "X*", color: Colors.blue, textColor: Colors.white),
        const SizedBox(
          width: 10,
        ),
        TextInputWidget(title: "Masukkan X*", controller: xController)
      ],
    );
  }
}
