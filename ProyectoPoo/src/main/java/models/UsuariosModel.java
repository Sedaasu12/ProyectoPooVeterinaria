package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Usuario;
import utilitarios.conexion;

public class UsuariosModel extends conexion {

    CallableStatement cs;
    ResultSet rs;

    /**
     * Autentica un usuario
     */
    public Usuario autenticarUsuario(String nombreUsuario, String password) {
        Usuario usuario = null;
        try {
            String sql = "CALL sp_autenticarUsuario(?,?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setString(1, nombreUsuario);
            cs.setString(2, password);
            rs = cs.executeQuery();
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idusuario"));
                usuario.setNombreUsuario(rs.getString("nombre_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
            }
            
            this.cerrarConexion();
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
        }
        return usuario;
    }

    /**
     * Lista todos los usuarios
     */
    public List<Usuario> listarUsuarios() {
        try {
            ArrayList<Usuario> usuarios = new ArrayList<>();
            String sql = "CALL sp_listarUsuarios()";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            rs = cs.executeQuery();
            
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("idusuario"));
                usuario.setNombreUsuario(rs.getString("nombre_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                usuarios.add(usuario);
            }
            
            this.cerrarConexion();
            return usuarios;
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return null;
        }
    }

    /**
     * Inserta un nuevo usuario
     */
    public int insertarUsuario(Usuario usuario) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_insertarUsuario(?,?,?,?,?)";
            
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setString(1, usuario.getNombreUsuario());
            cs.setString(2, usuario.getPassword());
            cs.setString(3, usuario.getNombreCompleto());
            cs.setString(4, usuario.getEmail());
            cs.setString(5, usuario.getRol());
            filasAfectadas = cs.executeUpdate();
            this.cerrarConexion();
            return filasAfectadas;
            
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return 0;
        }
    }

    /**
     * Obtiene un usuario por ID
     */
    public Usuario obtenerUsuario(int idUsuario) {
        Usuario usuario = new Usuario();
        try {
            String sql = "CALL sp_obtenerUsuario(?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idUsuario);
            rs = cs.executeQuery();
            
            if (rs.next()) {
                usuario.setIdUsuario(rs.getInt("idusuario"));
                usuario.setNombreUsuario(rs.getString("nombre_usuario"));
                usuario.setNombreCompleto(rs.getString("nombre_completo"));
                usuario.setEmail(rs.getString("email"));
                usuario.setRol(rs.getString("rol"));
                usuario.setEstado(rs.getString("estado"));
                usuario.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
            }
            this.cerrarConexion();
        } catch (Exception e) {
            e.printStackTrace();
            this.cerrarConexion();
            return null;
        }
        return usuario;
    }

    /**
     * Modifica un usuario
     */
    public int modificarUsuario(Usuario usuario) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_modificarUsuario(?,?,?,?,?,?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, usuario.getIdUsuario());
            cs.setString(2, usuario.getNombreUsuario());
            cs.setString(3, usuario.getNombreCompleto());
            cs.setString(4, usuario.getEmail());
            cs.setString(5, usuario.getRol());
            cs.setString(6, usuario.getEstado());
            filasAfectadas = cs.executeUpdate();
            
            this.cerrarConexion();
            return filasAfectadas;
            
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return 0;
        }
    }

    /**
     * Cambia la contraseña de un usuario
     */
    public int cambiarPassword(int idUsuario, String passwordNueva) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_cambiarPassword(?,?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idUsuario);
            cs.setString(2, passwordNueva);
            filasAfectadas = cs.executeUpdate();
            
            this.cerrarConexion();
            return filasAfectadas;
            
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return 0;
        }
    }

    /**
     * Elimina un usuario
     */
    public int eliminarUsuario(int idUsuario) {
        try {
            int filasAfectadas = 0;
            String sql = "CALL sp_eliminarUsuario(?)";
            this.abrirConexion();
            cs = conexion.prepareCall(sql);
            cs.setInt(1, idUsuario);
            filasAfectadas = cs.executeUpdate();
            
            this.cerrarConexion();
            return filasAfectadas;
            
        } catch (SQLException e) {
            e.printStackTrace();
            this.cerrarConexion();
            return 0;
        }
    }
    
    public List<Usuario> buscarUsuario(String texto) {
        List<Usuario> lista = new ArrayList<>();
        try {
            this.abrirConexion();
            cs = conexion.prepareCall("CALL sp_buscarUsuario(?)");
            cs.setString(1, texto);
            rs = cs.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idusuario"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setNombreCompleto(rs.getString("nombre_completo"));
                u.setEmail(rs.getString("email"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getString("estado"));
                u.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.cerrarConexion();
        }
        return lista;
    }
}