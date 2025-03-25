import 'package:animated_custom_dropdown/custom_dropdown.dart';  // Biblioteca para criar o dropdown customizado
import 'package:cabeleleila/app/theme.dart';  // Tema do app, utilizado para acessar cores e estilos
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter

/// Tela para exibir os serviços e agendamentos do usuário.
///
/// Esta tela permite ao usuário selecionar um tipo de serviço de um dropdown,
/// adicionar outro serviço, escolher uma data e hora para o serviço.
class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  // Variáveis para armazenar a data e o horário selecionados
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  /// Função para selecionar o horário utilizando o showTimePicker.
  Future<void> _selectTime(BuildContext context) async {
    // Exibe o seletor de hora e aguarda a escolha do usuário
    final TimeOfDay? picked = await showTimePicker(
      context: context, initialTime: TimeOfDay.now(),
    );

    // Atualiza o estado se o horário selecionado for diferente do atual
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  /// Função para selecionar a data utilizando o showDatePicker.
  Future<void> _selectDate(BuildContext context) async {
    // Exibe o seletor de data e aguarda a escolha do usuário
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),  // Data inicial
      firstDate: DateTime.now(),    // Primeira data permitida
      lastDate: DateTime(2100),     // Última data permitida
    );

    // Atualiza o estado se a data selecionada for diferente da atual
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lista de tipos de trabalho disponíveis no dropdown
    final List<String> list = ['Developer', 'Designer', 'Consultant', 'Student'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),  // Espaçamento em torno dos widgets
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centraliza os widgets
          spacing: 20.0,  // Espaçamento entre os widgets
          children: [
            // Dropdown personalizado para selecionar um tipo de trabalho
            CustomDropdown<String>(
              decoration: CustomDropdownDecoration(
                listItemDecoration: ListItemDecoration(),
                closedBorder: Border.all(width: 3, color: ColorSchemeManagerClass.colorPrimary),
                expandedBorder: Border.all(width: 3, color: ColorSchemeManagerClass.colorPrimary),
                headerStyle: TextStyle(color: ColorSchemeManagerClass.colorBlack),
                listItemStyle: TextStyle(color: ColorSchemeManagerClass.colorBlack),
                expandedBorderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Selecionar trabalho',  // Texto do hint no dropdown
              items: list,  // Itens disponíveis no dropdown
              initialItem: list[0],  // Item inicial selecionado
              excludeSelected: false,
              onChanged: (value) {},  // Função que é chamada ao selecionar um item (aqui não faz nada)
            ),
            
            // Botão para adicionar outro serviço
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),  // Ícone de adicionar
                  Text('Adicionar outro serviço')  // Texto
                ],
              ),
            ),
            
            // Seletor de data
            GestureDetector(
              onTap: () => _selectDate(context),  // Chama a função para selecionar a data
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  selectedDate == null
                      ? 'Selecionar data'  // Texto padrão quando nenhuma data for selecionada
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',  // Exibe a data selecionada
                ),
                trailing: Icon(Icons.calendar_month_outlined),  // Ícone de calendário
              ),
            ),
            
            // Seletor de horário
            GestureDetector(
              onTap: () => _selectTime(context),  // Chama a função para selecionar o horário
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  selectedTime == null
                      ? 'Selecionar horário'  // Texto padrão quando nenhum horário for selecionado
                      : selectedTime!.format(context),  // Exibe o horário selecionado
                ),
                trailing: Icon(Icons.timer_outlined),  // Ícone de relógio
              ),
            ),
          ],
        ),
      ),
    );
  }
}
