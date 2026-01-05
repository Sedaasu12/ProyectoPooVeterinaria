package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.Atencion;
import utilitarios.conexion;

public class AtencionModel extends conexion {
	 private CallableStatement cs;
	    private ResultSet rs;

	    /* =====================================================
	     * LISTAR ATENCIONES (SOLO ACTIVAS)
	     * ===================================================== */
	    public List<Atencion> listarAtenciones() {
	        List<Atencion> lista = new ArrayList<>();

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_listarAtenciones()}");
	            rs = cs.executeQuery();

	            while (rs.next()) {
	                Atencion a = new Atencion();
	                a.setIdAtencion(rs.getInt("id_atencion"));
	                a.setIdCita(rs.getInt("id_cita"));
	                a.setFechaAtencion(rs.getString("fecha_atencion"));
	                a.setDiagnostico(rs.getString("diagnostico"));
	                a.setTratamiento(rs.getString("tratamiento"));
	                a.setReceta(rs.getString("receta"));

	                a.setIdMascota(rs.getInt("id_mascota"));
	                a.setMascota(rs.getString("mascota"));
	                a.setCliente(rs.getString("cliente"));
	                a.setServicio(rs.getString("servicio"));

	                a.setVeterinario(rs.getString("veterinario"));
	                a.setEstado(rs.getString("estado"));

	                lista.add(a);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            cerrarConexion();
	        }

	        return lista;
	    }

	    /* =====================================================
	     * BUSCAR ATENCIONES (TEXTO)
	     * ===================================================== */
	    public List<Atencion> buscarAtenciones(String texto) {

	        if (texto == null || texto.trim().isEmpty()) {
	            return listarAtenciones();
	        }

	        List<Atencion> lista = new ArrayList<>();

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_buscarAtencionTexto(?)}");
	            cs.setString(1, texto);
	            rs = cs.executeQuery();

	            while (rs.next()) {
	                Atencion a = new Atencion();
	                a.setIdAtencion(rs.getInt("id_atencion"));
	                a.setIdCita(rs.getInt("id_cita"));
	                a.setFechaAtencion(rs.getString("fecha_atencion"));
	                a.setDiagnostico(rs.getString("diagnostico"));
	                a.setTratamiento(rs.getString("tratamiento"));
	                a.setReceta(rs.getString("receta"));

	                a.setIdMascota(rs.getInt("id_mascota"));
	                a.setMascota(rs.getString("mascota"));
	                a.setCliente(rs.getString("cliente"));
	                a.setServicio(rs.getString("servicio"));

	                lista.add(a);
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            cerrarConexion();
	        }

	        return lista;
	    }

	    /* =====================================================
	     * BUSCAR ATENCIÓN POR ID
	     * ===================================================== */
	    public Atencion buscarAtencionPorId(int id) {
	        Atencion a = null;

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_buscarAtencion(?)}");
	            cs.setInt(1, id);
	            rs = cs.executeQuery();

	            if (rs.next()) {
	                a = new Atencion();
	                a.setIdAtencion(rs.getInt("id_atencion"));
	                a.setIdCita(rs.getInt("id_cita"));
	                a.setFechaAtencion(rs.getString("fecha_atencion"));
	                a.setDiagnostico(rs.getString("diagnostico"));
	                a.setTratamiento(rs.getString("tratamiento"));
	                a.setReceta(rs.getString("receta"));

	                a.setIdMascota(rs.getInt("id_mascota"));
	                a.setMascota(rs.getString("mascota"));
	                a.setCliente(rs.getString("cliente"));
	                a.setServicio(rs.getString("servicio"));
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            cerrarConexion();
	        }

	        return a;
	    }

	    /* =====================================================
	     * INSERTAR ATENCIÓN
	     * ===================================================== */
	    public boolean insertarAtencion(Atencion a) {

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_insertarAtencion(?,?,?,?,?)}");
	            cs.setInt(1, a.getIdCita());
	            cs.setInt(2, a.getIdVeterinario());
	            cs.setString(3, a.getDiagnostico());
	            cs.setString(4, a.getTratamiento());
	            cs.setString(5, a.getReceta());

	            return cs.executeUpdate() > 0;

	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        } finally {
	            cerrarConexion();
	        }
	    }

	    /* =====================================================
	     * ACTUALIZAR ATENCIÓN
	     * ===================================================== */
	    public boolean actualizarAtencion(Atencion a) {

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_actualizarAtencion(?,?,?,?)}");
	            cs.setInt(1, a.getIdAtencion());
	            cs.setString(2, a.getDiagnostico());
	            cs.setString(3, a.getTratamiento());
	            cs.setString(4, a.getReceta());

	            return cs.executeUpdate() > 0;

	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        } finally {
	            cerrarConexion();
	        }
	    }

	    /* =====================================================
	     * DESACTIVAR ATENCIÓN (ELIMINADO LÓGICO)
	     * ===================================================== */
	    public boolean desactivarAtencion(int id) {

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_desactivarAtencion(?)}");
	            cs.setInt(1, id);
	            return cs.executeUpdate() > 0;

	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        } finally {
	            cerrarConexion();
	        }
	    }

	    /* =====================================================
	     * ACTIVAR ATENCIÓN
	     * ===================================================== */
	    public boolean activarAtencion(int id) {

	        try {
	            abrirConexion();
	            cs = conexion.prepareCall("{CALL sp_activarAtencion(?)}");
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