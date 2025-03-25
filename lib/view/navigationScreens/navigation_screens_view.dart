import 'package:cabeleleila/app/theme.dart';  // Importação do tema do app para acessar as cores e estilos definidos globalmente
import 'package:cabeleleila/view/history/history_view.dart';  // Importação da tela de histórico
import 'package:cabeleleila/view/home/home_view.dart';  // Importação da tela inicial
import 'package:cabeleleila/view/services/services_view.dart';  // Importação da tela de serviços
import 'package:flutter/material.dart';  // Biblioteca principal do Flutter

/// Tela de navegação com barra inferior para alternar entre as páginas de serviços, início e histórico.
///
/// Esta tela utiliza o `PageView` para criar uma navegação entre diferentes telas de forma simples.
/// A barra de navegação inferior permite ao usuário selecionar entre os itens disponíveis e navegar entre eles.
class NavigationScreensView extends StatefulWidget {
  // Construtor da classe
  const NavigationScreensView({super.key});

  @override
  State<NavigationScreensView> createState() => _NavigationScreensViewState();
}

class _NavigationScreensViewState extends State<NavigationScreensView> {
  // Variável para controlar a página inicial (padrão: página 1)
  int initialPage = 1;
  
  // Controlador do PageView para gerenciar as mudanças de páginas
  late PageController pagecontroller;

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador da página com a página inicial definida
    pagecontroller = PageController(initialPage: initialPage);
  }

  // Função para atualizar a página atual quando o usuário seleciona uma nova página
  setActualPage(page) {
    setState(() {
      initialPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extende o corpo do Scaffold para não ser sobreposto por outros elementos
      extendBody: true,
      body: PageView(
        // Controlador do PageView para gerenciar as páginas
        controller: pagecontroller,
        // Método acionado ao mudar de página
        onPageChanged: setActualPage,
        // As páginas a serem exibidas no PageView
        children: [
          ServicesView(),  // Página de serviços
          HomeView(),      // Página inicial
          HistoryView(),   // Página de histórico
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Índice da página selecionada no BottomNavigationBar
        currentIndex: initialPage,
        backgroundColor: ColorSchemeManagerClass.colorPrimary,  // Cor de fundo do BottomNavigationBar
        selectedItemColor: Colors.blueAccent,  // Cor do ícone selecionado
        type: BottomNavigationBarType.fixed,  // Tipo de navegação fixa
        unselectedItemColor: ColorSchemeManagerClass.colorSecondary,  // Cor dos ícones não selecionados
        elevation: 0,  // Elevation para o BottomNavigationBar
        useLegacyColorScheme: true,  // Utiliza o esquema de cores antigo
        // Itens do BottomNavigationBar com ícones e rótulos
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service_rounded),  // Ícone para serviços
            label: 'Serviços',  // Rótulo do item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),  // Ícone para página inicial
            label: 'Início',  // Rótulo do item
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),  // Ícone para histórico
            label: 'Histórico',  // Rótulo do item
          ),
        ],
        // Ação quando um item é tocado no BottomNavigationBar
        onTap: (page) {
          // Altera a página do PageView com animação
          pagecontroller.animateToPage(
            page,
            duration: Duration(milliseconds: 100),  // Duração da animação
            curve: Curves.easeIn,  // Curvatura da animação
          );
        },
      ),
    );
  }
}
