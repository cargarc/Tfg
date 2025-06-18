import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/calendar_page.dart';
import 'package:flutter_application_2/Pages/check_hours.dart';
import 'package:flutter_application_2/models/employee.dart';
import 'package:flutter_application_2/service/employee_service.dart';

class HomePage extends StatefulWidget {
  final String dni;
  const HomePage({Key? key, required this.dni}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeService _employeeService = EmployeeService();
  final employee = Employee();
  bool isLoading = false;

  final List<DrawerItem> _todasOpciones = [
    DrawerItem(Icons.menu, 'Menú', '/menu', todos: true),
    DrawerItem(Icons.calendar_today, 'Calendario', '/calendario', todos: true),

    DrawerItem(
      Icons.access_time,
      'Horas trabajadas',
      '/horas',
      gerente: true,
      todos: true,
    ),
    DrawerItem(
      Icons.inventory,
      'Almacén',
      '/almacen',
      gerente: true,
      todos: true,
    ),
    DrawerItem(
      Icons.people,
      'Personal',
      '/personal',
      gerente: true,
      organizacion: true,
    ),

    DrawerItem(
      Icons.assignment,
      'Tareas',
      '/tareas',
      gerente: true,
      limitados: true,
    ),
    DrawerItem(Icons.event, 'Gestión Eventos', '/eventos', gerente: true),
    DrawerItem(Icons.message, 'Mensajes', '/mensajes', gerente: true),
  ];

  @override
  void initState() {
    super.initState();
    loadEmployeeData();
  }

  void loadEmployeeData() async {
    isLoading = true;
    try {
      await _employeeService.getEmployeeById(widget.dni);
      print('Empleado - HomePage: ${employee?.toJson()}');
    } catch (e) {
      print('Error al cargar los datos del empleado: $e');
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Empleado: ${employee?.toJson()}');

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Acción al presionar el botón de notificaciones
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Acción al presionar el botón de configuración
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            _buildHeader(employee),
            ..._buildMenuOptions(employee),
            Divider(),
            _buildLogoutOption(),
          ],
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Bienvenido a la página de inicio'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Checkhours()),
                        );
                      },
                      child: Text('Ver horas trabajadas'),
                    ),
                  ],
                ),
              ),
    );
  }

  List<Widget> _buildMenuOptions(Employee employee) {
    return _todasOpciones
        .where((option) {
          if (option.todos) return true;
          if (employee.esGerente) return true;
          if (employee.esOrganizacion &&
              (option.organizacion || option.limitados))
            return true;
          if (employee.esRolLimitado && option.limitados) return true;
          return false;
        })
        .map((option) => _buildOption(option))
        .toList();
  }

  Widget _buildHeader(Employee employee) {
    return UserAccountsDrawerHeader(
      accountName: Text('${employee.nombre} ${employee.apellidos}'),
      accountEmail: Text(employee.categoria?.toUpperCase() ?? ''),
    );
  }

  Widget _buildOption(DrawerItem option) {
    return ListTile(
      leading: Icon(option.icon),
      title: Text(option.text),
      onTap: () => Navigator.pushNamed(context, option.route),
    );
  }

  Widget _buildLogoutOption() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Cerrar Sesión'),
      onTap: () => Navigator.pushReplacementNamed(context, '/login'),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String text;
  final String route;
  final bool todos;
  final bool limitados;
  final bool organizacion;
  final bool gerente;

  DrawerItem(
    this.icon,
    this.text,
    this.route, {
    this.todos = false,
    this.limitados = false,
    this.organizacion = false,
    this.gerente = false,
  });
}
