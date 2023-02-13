import 'package:flutter/material.dart';

void main() {
  runApp( const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(
    ),
  ));
}


class Home extends StatefulWidget {
   const Home({super.key});
  

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _infoText = 'Informe seus dados !';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void resetFields(){
    setState(() {
      weightController.text= '';
      heightController.text = '';
      _infoText = '';
      formKey = GlobalKey<FormState>(); 

    });
  }

  void errorTexts(){
    setState(() {
    if (weightController.text == '' && heightController.text == ''){
       _infoText = 'Informe seus Dados!';
    }else if( heightController.text == ''){
      _infoText = 'Informe sua Altura!';
    }else if(weightController.text == ''){
      _infoText = 'Informe seu Peso!';
    }
    });
    
  }

  void calculateImc(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text)/ 100;
      double imc = (weight/(height*height));
      if (imc< 18.6){
        _infoText = 'Você está abaixo do peso: (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 18.6 && imc < 24.9 ){
        _infoText = 'Você está no peso ideal: (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 24.9 && imc < 29.9 ){
        _infoText = 'Levemente acima do peso: (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 29.9 && imc < 34.9 ){
        _infoText = 'Obesidade Grau I: (${imc.toStringAsPrecision(3)})';
      }else if(imc >= 34.9 && imc < 39.9 ){
        _infoText = 'Obesidade Grau II: (${imc.toStringAsPrecision(3)})';  
      }else if(imc >= 39.9){
        _infoText = 'Obesidade Grau III: (${imc.toStringAsPrecision(3)})';
      }
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(onPressed: resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white70,
      body:  SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
               const Icon(Icons.person_2_outlined, size: 120, color: Colors.lightBlueAccent,),
               TextFormField(keyboardType: TextInputType.number, controller: weightController, validator: (value){
                  if(value!.isEmpty){
                    return 'Insira seu Peso';
                  }
                },
                decoration: const InputDecoration(
                labelText: 'Peso (Kg)',
                labelStyle: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold,),
               ),
               textAlign: TextAlign.center,),
                TextFormField(keyboardType: TextInputType.number, controller: heightController, validator: (value){
                  if(value!.isEmpty){
                    return 'Insira sua Altura!';
                  }
                }, decoration: const InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
               ),
               textAlign: TextAlign.center,),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                 child: SizedBox(
                  height: 50,
                  child: ElevatedButton(onPressed: (){
                    if(formKey.currentState!.validate()){
                      calculateImc();
                    }
                  }, style:ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent,), child:  const Text('Calcular', style: TextStyle(fontSize: 20),),)),
               ),
                 Text(_infoText, textAlign: TextAlign.center, style: const TextStyle(color: Colors.lightBlueAccent),)
            ],
          ),
        ),
      ),
    );
  }
}
