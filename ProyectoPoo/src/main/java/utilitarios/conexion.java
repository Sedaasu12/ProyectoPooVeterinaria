package utilitarios;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexion {
	private String url = "jdbc:mysql://localhost:3306/veterinaria_db";
	private String usuario = "root";
	private String contrasenia = "123456";
	
	protected Connection conexion;
	
	public void abrirConexion() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conexion = DriverManager.getConnection(url, usuario, contrasenia);
			System.out.print("La conexion a la base de datos a sido exitosa");
		}
		catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			
		}
	}
	
	public void cerrarConexion() {
		try {
			if(conexion != null && !conexion.isClosed()) {
				conexion.close();
				System.out.print("La conexion a la base de datos a sido exitosamente cerrada");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

}
