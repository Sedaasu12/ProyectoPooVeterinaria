package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.Servicio;
import utilitarios.conexion;

public class ServicioModel extends conexion{
	
	CallableStatement cs;
    ResultSet rs;
    
    public List<Servicio> listarServicios() {
        List<Servicio> lista = new ArrayList<>();

        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_listarServicios()}");
            rs = cs.executeQuery();

            while (rs.next()) {
                Servicio s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setNombreServicio(rs.getString("nombre_servicio"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
                lista.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return lista;
    }

    public boolean insertarServicio(Servicio s) {

        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_insertarServicio(?,?,?)}");

            cs.setString(1, s.getNombreServicio());
            cs.setString(2, s.getDescripcion());
            cs.setDouble(3, s.getPrecio());

            return cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarConexion();
        }
    }

    public Servicio buscarServicioID(int id) {
        Servicio s = null;

        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_buscarServicioID(?)}");
            cs.setInt(1, id);
            rs = cs.executeQuery();

            if (rs.next()) {
                s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setNombreServicio(rs.getString("nombre_servicio"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return s;
    }

    public List<Servicio> buscarServicio(String texto) {
        List<Servicio> lista = new ArrayList<>();

        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_buscarServicio(?)}");
            cs.setString(1, texto);
            rs = cs.executeQuery();

            while (rs.next()) {
                Servicio s = new Servicio();
                s.setIdServicio(rs.getInt("id_servicio"));
                s.setNombreServicio(rs.getString("nombre_servicio"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setPrecio(rs.getDouble("precio"));
                lista.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return lista;
    }

    public boolean actualizarServicio(Servicio s) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_actualizarServicio(?,?,?,?)}");

            cs.setInt(1, s.getIdServicio());
            cs.setString(2, s.getNombreServicio());
            cs.setString(3, s.getDescripcion());
            cs.setDouble(4, s.getPrecio());

            return cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarConexion();
        }
    }

    public boolean eliminarServicio(int id) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_eliminarServicio(?)}");
            cs.setInt(1, id);

            return cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarConexion();
        }
    }

}
