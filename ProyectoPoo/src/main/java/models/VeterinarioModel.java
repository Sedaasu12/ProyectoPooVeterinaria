package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.Veterinario;
import utilitarios.conexion;

public class VeterinarioModel extends conexion{
	
	private CallableStatement cs;
    private ResultSet rs;

    // ================= LISTAR =================
    public List<Veterinario> listarVeterinarios() {
        List<Veterinario> lista = new ArrayList<>();
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_listarVeterinarios()}");
            rs = cs.executeQuery();

            while (rs.next()) {
                Veterinario v = new Veterinario();
                v.setIdVeterinario(rs.getInt("id_veterinario"));
                v.setNombres(rs.getString("nombres"));
                v.setApellidos(rs.getString("apellidos"));
                v.setDni(rs.getString("dni"));
                v.setTelefono(rs.getString("telefono"));
                v.setEspecialidad(rs.getString("especialidad"));
                v.setEstado(rs.getString("estado"));
                v.setFechaRegistro(rs.getTimestamp("fecha_registro"));

                lista.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return lista;
    }

    // ================= BUSCAR =================
    public List<Veterinario> buscarVeterinario(String texto) {
        List<Veterinario> lista = new ArrayList<>();
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_buscarVeterinario(?)}");
            cs.setString(1, texto);
            rs = cs.executeQuery();

            while (rs.next()) {
                Veterinario v = new Veterinario();
                v.setIdVeterinario(rs.getInt("id_veterinario"));
                v.setNombres(rs.getString("nombres"));
                v.setApellidos(rs.getString("apellidos"));
                v.setDni(rs.getString("dni"));
                v.setTelefono(rs.getString("telefono"));
                v.setEspecialidad(rs.getString("especialidad"));
                v.setEstado(rs.getString("estado"));

                lista.add(v);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return lista;
    }

    // ================= INSERTAR =================
    public boolean insertarVeterinario(Veterinario v) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_insertarVeterinario(?,?,?,?,?,?,?)}");
            cs.setInt(1, v.getIdUsuario());
            cs.setString(2, v.getNombres());
            cs.setString(3, v.getApellidos());
            cs.setString(4, v.getDni());
            cs.setString(5, v.getTelefono());
            cs.setString(6, v.getEmail());
            cs.setString(7, v.getEspecialidad());

            return cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarConexion();
        }
    }

    // ================= OBTENER POR ID =================
    public Veterinario obtenerVeterinario(int id) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_obtenerVeterinario(?)}");
            cs.setInt(1, id);
            rs = cs.executeQuery();

            if (rs.next()) {
                Veterinario v = new Veterinario();
                v.setIdVeterinario(rs.getInt("id_veterinario"));
                v.setNombres(rs.getString("nombres"));
                v.setApellidos(rs.getString("apellidos"));
                v.setDni(rs.getString("dni"));
                v.setTelefono(rs.getString("telefono"));
                v.setEspecialidad(rs.getString("especialidad"));
                v.setEstado(rs.getString("estado"));
                return v;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarConexion();
        }
        return null;
    }

    // ================= ACTUALIZAR =================
    public boolean actualizarVeterinario(Veterinario v) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_actualizarVeterinario(?,?,?,?,?)}");

            cs.setInt(1, v.getIdVeterinario());
            cs.setString(2, v.getNombres());
            cs.setString(3, v.getApellidos());
            cs.setString(4, v.getTelefono());
            cs.setString(5, v.getEspecialidad());

            return cs.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarConexion();
        }
    }
    // ================= DESACTIVAR =================
    public boolean desactivarVeterinario(int id) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_desactivarVeterinario(?)}");
            cs.setInt(1, id);
            return cs.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarConexion();
        }
    }

    // ================= ACTIVAR =================
    public boolean activarVeterinario(int id) {
        try {
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_activarVeterinario(?)}");
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
