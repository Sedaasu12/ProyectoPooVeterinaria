package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.Mascota;
import utilitarios.conexion;

public class MascotaModel extends conexion{
	CallableStatement cs;
    ResultSet rs;

    public List<Mascota> listarMascotas() {
        List<Mascota> lista = new ArrayList<>();
        try {
            abrirConexion();
            cs = conexion.prepareCall("{ CALL sp_listarMascotas() }");
            rs = cs.executeQuery();
            while (rs.next()) {
                Mascota m = new Mascota();
                m.setIdMascota(rs.getInt("idMascota"));
                m.setNombre(rs.getString("MascotaNombre"));
                m.setEspecie(rs.getString("MascotaEspecie"));
                m.setRaza(rs.getString("MascotaRaza"));
                m.setSexo(rs.getString("MascotaSexo"));
                m.setFechaNacimiento(rs.getString("MascotaFecha"));
                m.setIdCliente(rs.getInt("idCliente"));
                m.setClienteNombre(rs.getString("ClienteNombre"));
                lista.add(m);
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally { cerrarConexion(); }
        return lista;
    }

    public Mascota buscarMascota(int id) {
        Mascota m = null;
        try {
            abrirConexion();
            cs = conexion.prepareCall("{ CALL sp_buscarMascota(?) }");
            cs.setInt(1, id);
            rs = cs.executeQuery();
            if (rs.next()) {
                m = new Mascota();
                m.setIdMascota(rs.getInt("idMascota"));
                m.setNombre(rs.getString("MascotaNombre"));
                m.setEspecie(rs.getString("MascotaEspecie"));
                m.setRaza(rs.getString("MascotaRaza"));
                m.setSexo(rs.getString("MascotaSexo"));
                m.setFechaNacimiento(rs.getString("MascotaFecha"));
                m.setIdCliente(rs.getInt("idCliente"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        finally { cerrarConexion(); }
        return m;
    }

    public boolean insertarMascota(Mascota m) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{ CALL sp_insertarMascota(?,?,?,?,?,?) }");
            cs.setString(1, m.getNombre());
            cs.setString(2, m.getEspecie());
            cs.setString(3, m.getRaza());
            cs.setString(4, m.getSexo());
            cs.setString(5, m.getFechaNacimiento());
            cs.setInt(6, m.getIdCliente());
            return cs.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally { cerrarConexion(); }
    }

    public boolean actualizarMascota(Mascota m) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{ CALL sp_actualizarMascota(?,?,?,?,?,?,?) }");
            cs.setInt(1, m.getIdMascota());
            cs.setString(2, m.getNombre());
            cs.setString(3, m.getEspecie());
            cs.setString(4, m.getRaza());
            cs.setString(5, m.getSexo());
            cs.setString(6, m.getFechaNacimiento());
            cs.setInt(7, m.getIdCliente());
            return cs.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally { cerrarConexion(); }
    }

    public boolean eliminarMascota(int id) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{ CALL sp_eliminarMascota(?) }");
            cs.setInt(1, id);
            return cs.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally { cerrarConexion(); }
    }
    
    public List<Mascota> buscarMascotaPorNombre(String nombre) {
        List<Mascota> lista = new ArrayList<>();
        try {
            abrirConexion();
            cs = conexion.prepareCall("{ CALL sp_buscarMascotaPorNombre(?) }");
            cs.setString(1, nombre);
            rs = cs.executeQuery();
            while (rs.next()) {
                Mascota m = new Mascota();
                m.setIdMascota(rs.getInt("idMascota"));
                m.setNombre(rs.getString("MascotaNombre"));
                m.setEspecie(rs.getString("MascotaEspecie"));
                m.setRaza(rs.getString("MascotaRaza"));
                m.setSexo(rs.getString("MascotaSexo"));
                m.setFechaNacimiento(rs.getString("MascotaFecha"));
                m.setIdCliente(rs.getInt("idCliente"));
                m.setClienteNombre(rs.getString("ClienteNombre"));
                lista.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return lista;
    }


}
