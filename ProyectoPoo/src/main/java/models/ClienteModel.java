package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.cliente;
import utilitarios.conexion;

public class ClienteModel extends conexion{
	 CallableStatement cs;
	    ResultSet rs;

	    // LISTAR
	    public List<cliente> listarClientes() {
	        List<cliente> lista = new ArrayList<>();

	        try {
	            this.abrirConexion();
	            cs = conexion.prepareCall("{ CALL sp_listarCliente() }");
	            rs = cs.executeQuery();

	            while (rs.next()) {
	                cliente c = new cliente();
	                c.setIdCliente(rs.getInt("idCliente"));
	                c.setClienteDni(rs.getString("ClienteDni"));
	                c.setClienteNombre(rs.getString("ClienteNombre"));
	                c.setClienteApellido(rs.getString("ClienteApellido"));
	                c.setClienteTelefono(rs.getString("ClienteTelefono"));
	                c.setClienteEmail(rs.getString("ClienteEmail"));
	                c.setClienteDireccion(rs.getString("ClienteDireccion"));
	                lista.add(c);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            this.cerrarConexion();
	        }

	        return lista;
	    }

	    // INSERTAR
	    public boolean insertarCliente(cliente c) {
	        try {
	            this.abrirConexion();
	            cs = conexion.prepareCall("{ CALL sp_insertarCliente(?,?,?,?,?,?) }");
	            cs.setString(1, c.getClienteDni());
	            cs.setString(2, c.getClienteNombre());
	            cs.setString(3, c.getClienteApellido());
	            cs.setString(4, c.getClienteTelefono());
	            cs.setString(5, c.getClienteEmail());
	            cs.setString(6, c.getClienteDireccion());

	            return cs.executeUpdate() > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;

	        } finally {
	            this.cerrarConexion();
	        }
	    }
	    // BUSCAR CLIENTE POR ID PARA EL ACTUALIZAR
	    
	    public cliente buscarCliente(int idCliente) {
	        try {
	            String sql = "CALL sp_buscarCliente(?)";
	            this.abrirConexion();
	            cs = conexion.prepareCall(sql);
	            cs.setInt(1, idCliente);
	            rs = cs.executeQuery();

	            cliente cliente = null;
	            if (rs.next()) {
	                cliente = new cliente();
	                cliente.setIdCliente(rs.getInt("idCliente"));
	                cliente.setClienteDni(rs.getString("ClienteDni"));
	                cliente.setClienteNombre(rs.getString("ClienteNombre"));
	                cliente.setClienteApellido(rs.getString("ClienteApellido"));
	                cliente.setClienteTelefono(rs.getString("ClienteTelefono"));
	                cliente.setClienteEmail(rs.getString("ClienteEmail"));
	                cliente.setClienteDireccion(rs.getString("ClienteDireccion"));
	            }
	            this.cerrarConexion();
	            return cliente;
	        } catch (SQLException e) {
	            e.printStackTrace();
	            this.cerrarConexion();
	            return null;
	        }
	    }

	    // ACTUALIZAR
	    public boolean actualizarCliente(cliente c) {
	        try {
	            this.abrirConexion();
	            cs = conexion.prepareCall("{ CALL sp_actualizarCliente(?,?,?,?,?,?,?) }");

	            cs.setInt(1, c.getIdCliente());
	            cs.setString(2, c.getClienteDni());
	            cs.setString(3, c.getClienteNombre());
	            cs.setString(4, c.getClienteApellido());
	            cs.setString(5, c.getClienteTelefono());
	            cs.setString(6, c.getClienteEmail());
	            cs.setString(7, c.getClienteDireccion());

	            return cs.executeUpdate() > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;

	        } finally {
	            this.cerrarConexion();
	        }
	    }

	    // ELIMINAR
	    public boolean eliminarCliente(int idCliente) {
	        try {
	            this.abrirConexion();
	            cs = conexion.prepareCall("{ CALL sp_eliminarCliente(?) }");
	            cs.setInt(1, idCliente);

	            return cs.executeUpdate() > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;

	        } finally {
	            this.cerrarConexion();
	        }
	    }
	    // BUSCAR CLIENTE 
	    
	    public List<cliente> buscarClientes(String criterio) {
	        List<cliente> lista = new ArrayList<>();

	        try {
	            this.abrirConexion();
	            cs = conexion.prepareCall("{ CALL sp_buscarClienteGeneral(?) }");
	            cs.setString(1, criterio);
	            rs = cs.executeQuery();

	            while (rs.next()) {
	                cliente c = new cliente();
	                c.setIdCliente(rs.getInt("idCliente"));
	                c.setClienteDni(rs.getString("ClienteDni"));
	                c.setClienteNombre(rs.getString("ClienteNombre"));
	                c.setClienteApellido(rs.getString("ClienteApellido"));
	                c.setClienteTelefono(rs.getString("ClienteTelefono"));
	                c.setClienteEmail(rs.getString("ClienteEmail"));
	                c.setClienteDireccion(rs.getString("ClienteDireccion"));
	                lista.add(c);
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            this.cerrarConexion();
	        }

	        return lista;
	    }

}
