import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator BMI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BMIScreen(), // Memanggil layar BMI kita
    );
  }
}
// ===========================================

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  double? _hasilBMI;
  String _keterangan = 'Silakan Masukkan Data Anda!';
  String _gender = 'Laki-laki';

  void _hitungBMI() {
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbInCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbInCm > 0) {
        final double tbInM = tbInCm / 100;
        final double bmi = bb / (tbInM * tbInM);
        _hasilBMI = bmi;

        if (_gender == 'Laki-laki') {
          if (bmi < 18.5)
            _keterangan = 'Kurus (Pria)';
          else if (bmi < 25)
            _keterangan = 'Ideal (Pria)';
          else if (bmi < 30)
            _keterangan = 'Gemuk (Pria)';
          else
            _keterangan = 'Obesitas (Pria)!!!';
        } else {
          if (bmi < 18.5)
            _keterangan = 'Kurus (Wanita)';
          else if (bmi < 24)
            _keterangan = 'Ideal (Wanita)';
          else if (bmi < 29)
            _keterangan = 'Gemuk (Wanita)';
          else
            _keterangan = 'Obesitas (Wanita)!!!';
        }
      } else {
        _hasilBMI = null;
        _keterangan = 'Masukkan Data Yang Valid!!!';
      }
    });
  }

  void _reset() {
    _bbController.clear();
    _tbController.clear();
    setState(() {
      _hasilBMI = null;
      _keterangan = 'Silakan Masukkan Data Anda!';
      _gender = 'Laki-laki';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Kalkulator BMI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        leading: const Icon(Icons.calculate, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio<String>(
                            value: 'Laki-laki',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          const Text('Laki-laki'),
                          const SizedBox(width: 20),
                          Radio<String>(
                            value: 'Perempuan',
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          const Text('Perempuan'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _bbController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.monitor_weight,
                            color: Colors.blueAccent,
                          ),
                          labelText: 'Berat Badan (kg)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _tbController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.height,
                            color: Colors.blueAccent,
                          ),
                          labelText: 'Tinggi Badan (cm)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _hitungBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'HITUNG',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'RESET',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Hasil BMI Anda',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? '--',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _keterangan,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: _keterangan.contains('!!!')
                            ? Colors.red
                            : Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
