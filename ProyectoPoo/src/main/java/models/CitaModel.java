package models;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import beans.Cita;
import utilitarios.conexion;

public class CitaModel extends conexion{
	CallableStatement cs;
    ResultSet rs;

    public List<Cita> listarCitas(){
        List<Cita> lista = new ArrayList<>();
        try{
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_listarCitas()}");
            rs = cs.executeQuery();

            while(rs.next()){
                Cita c = new Cita();
                c.setIdCita(rs.getInt("id_cita"));

                
                c.setIdMascota(rs.getInt("id_mascota"));
                c.setIdServicio(rs.getInt("id_servicio"));

                c.setMascota(rs.getString("mascota"));
                c.setCliente(rs.getString("cliente"));
                c.setServicio(rs.getString("servicio"));

                c.setFecha(rs.getString("fecha_cita"));
                c.setHora(rs.getString("hora_cita"));
                c.setEstado(rs.getString("estado"));
                lista.add(c);
            
            }
        }catch(Exception e){ e.printStackTrace(); }
        finally{ cerrarConexion(); }

        return lista;
    }

    public boolean insertarCita(Cita c){
        try{
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_insertarCita(?,?,?,?,?)}");
            cs.setInt(1,c.getIdMascota());
            cs.setInt(2,c.getIdServicio());
            cs.setString(3,c.getFecha());
            cs.setString(4,c.getHora());
            cs.setString(5,c.getEstado());
            return cs.executeUpdate()>0;
        }catch(Exception e){ e.printStackTrace(); return false; }
        finally{ cerrarConexion(); }
    }

    public Cita buscarCita(int id){
        try{
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_buscarCita(?)}");
            cs.setInt(1,id);
            rs = cs.executeQuery();

            if(rs.next()){
                Cita c = new Cita();
                c.setIdCita(rs.getInt("id_cita"));
                c.setIdMascota(rs.getInt("id_mascota"));
                c.setIdServicio(rs.getInt("id_servicio"));
                c.setFecha(rs.getString("fecha_cita"));
                c.setHora(rs.getString("hora_cita"));
                c.setEstado(rs.getString("estado"));
                return c;
            }
        }catch(Exception e){ e.printStackTrace(); }
        finally { cerrarConexion(); }

        return null;
    }


    public boolean actualizarCita(Cita c){
        try{
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_actualizarCita(?,?,?,?,?,?)}");
            cs.setInt(1,c.getIdCita());
            cs.setInt(2,c.getIdMascota());
            cs.setInt(3,c.getIdServicio());
            cs.setString(4,c.getFecha());
            cs.setString(5,c.getHora());
            cs.setString(6,c.getEstado());
            return cs.executeUpdate()>0;
        }catch(Exception e){ e.printStackTrace(); return false; }
        finally{ cerrarConexion(); }
    }

    public boolean eliminarCita(int id){
        try{
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_eliminarCita(?)}");
            cs.setInt(1,id);

            return cs.executeUpdate()>0;
        }catch(Exception e){ e.printStackTrace(); return false; }
        finally{ cerrarConexion(); }
    }
    public List<Cita> buscarCita(String texto){
        List<Cita> lista = new ArrayList<>();
        try{
            abrirConexion();
            cs = conexion.prepareCall("{CALL sp_buscarCitaTexto(?)}");
            cs.setString(1,texto);
            rs = cs.executeQuery();

            while(rs.next()){
                Cita c = new Cita();
                c.setIdCita(rs.getInt("id_cita"));
                c.setMascota(rs.getString("mascota"));
                c.setCliente(rs.getString("cliente"));
                c.setServicio(rs.getString("servicio"));
                c.setFecha(rs.getString("fecha_cita"));
                c.setHora(rs.getString("hora_cita"));
                c.setEstado(rs.getString("estado"));
                lista.add(c);
            }

        }catch(Exception e){ e.printStackTrace(); }
        finally{ cerrarConexion(); }
        return lista;
    }
	

}
