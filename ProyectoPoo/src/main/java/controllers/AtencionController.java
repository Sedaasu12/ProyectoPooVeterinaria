package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.AtencionModel;
import models.CitaModel;
import models.MascotaModel;
import models.ServicioModel;

import java.io.IOException;
import java.util.List;

import beans.Atencion;


/**
 * Servlet implementation class AtencionController
 */
@WebServlet("/AtencionController")
public class AtencionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	AtencionModel modeloAtencion = new AtencionModel();
    MascotaModel modeloMascota = new MascotaModel();
    ServicioModel modeloServicio = new ServicioModel();
    CitaModel modeloCita = new CitaModel(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AtencionController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    protected void Procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        if(op==null){ listar(request,response); return; }
        switch(op){
            case "listar": listar(request,response); break;
            case "buscar": buscar(request,response); break;
            case "insertar": insertar(request,response); break;
            case "editar": editar(request,response); break;
            case "actualizar": actualizar(request,response); break;
            case "eliminar": eliminar(request,response); break;
            default: listar(request,response); break;
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("listaAtenciones", modeloAtencion.listarAtenciones());
        request.setAttribute("listaCitas", modeloCita.listarCitas());   // <---
        request.setAttribute("listaMascotas", modeloMascota.listarMascotas());
        request.setAttribute("listaServicios", modeloServicio.listarServicios());

        request.getRequestDispatcher("Atencion/listarAtencion.jsp").forward(request,response);
    }

    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String texto = request.getParameter("buscar");

        // 🔥 SI EL BUSCADOR ESTÁ VACÍO → LISTAR TODO
        if (texto == null || texto.trim().isEmpty()) {
            listar(request, response);
            return;
        }

        List<Atencion> lista = modeloAtencion.buscarAtencion(texto);

        request.setAttribute("listaAtenciones", lista);
        request.setAttribute("listaCitas", modeloCita.listarCitas());
        request.getRequestDispatcher("Atencion/listarAtencion.jsp").forward(request, response);
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try{
            Atencion a = new Atencion();
            a.setIdCita(Integer.parseInt(request.getParameter("idCita"))); 
            a.setDiagnostico(request.getParameter("diagnostico"));
            a.setTratamiento(request.getParameter("tratamiento"));
            a.setReceta(request.getParameter("receta"));

            boolean ok = modeloAtencion.insertarAtencion(a);
            response.sendRedirect("AtencionController?op=listar");

        }catch(Exception e){
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }


    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Atencion a = modeloAtencion.buscarAtencionPorId(id);

        request.setAttribute("atencion", a);
        request.setAttribute("listaCitas", modeloCita.listarCitas()); // <---
        request.setAttribute("listaMascotas", modeloMascota.listarMascotas());
        request.setAttribute("listaServicios", modeloServicio.listarServicios());

        request.getRequestDispatcher("Atencion/editarAtencion.jsp").forward(request,response);
    }


    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            Atencion a = new Atencion();
            a.setIdAtencion(Integer.parseInt(request.getParameter("idAtencion")));
            a.setIdCita(Integer.parseInt(request.getParameter("idCita")));
            a.setDiagnostico(request.getParameter("diagnostico"));
            a.setTratamiento(request.getParameter("tratamiento"));
            a.setReceta(request.getParameter("receta"));

            boolean ok = modeloAtencion.actualizarAtencion(a);
            if(ok) response.sendRedirect("AtencionController?op=listar");
            else response.sendRedirect("error.jsp");
        }catch(Exception e){ e.printStackTrace(); response.sendRedirect("error.jsp"); }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ok = modeloAtencion.eliminarAtencion(id);
            if(ok) response.sendRedirect("AtencionController?op=listar");
            else response.sendRedirect("error.jsp");
        }catch(Exception e){ e.printStackTrace(); response.sendRedirect("error.jsp"); }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { Procesar(req,resp); }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { Procesar(req,resp); }
}
