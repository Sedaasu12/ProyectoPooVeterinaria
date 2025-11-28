package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.CitaModel;
import models.MascotaModel;
import models.ServicioModel;

import java.io.IOException;
import java.util.List;

import beans.Cita;
import beans.Mascota;
import beans.Servicio;

/**
 * Servlet implementation class CitaController
 */
@WebServlet("/CitaController")
public class CitaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	    CitaModel modeloCita = new CitaModel();
	    MascotaModel modeloMascota = new MascotaModel();
	    ServicioModel modeloServicio = new ServicioModel();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CitaController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void Procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {
            listar(request, response);
            return;
        }

        switch (op) {

            case "listar":
                listar(request, response);
                break;

            case "buscar":
                buscar(request, response);
                break;

            case "insertar":
                insertar(request, response);
                break;

            case "editar":
                editar(request, response);
                break;

            case "actualizar":
                actualizar(request, response);
                break;

            case "eliminar":
                eliminar(request, response);
                break;

            default:
                listar(request, response);
                break;
        }
    }

    // =====================================================
    // LISTAR TODAS LAS CITAS
    // =====================================================
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Cita> lista = modeloCita.listarCitas();
        List<Mascota> mascotas = modeloMascota.listarMascotas();
        List<Servicio> servicios = modeloServicio.listarServicios();

        request.setAttribute("listaCitas", lista);
        request.setAttribute("listaMascotas", mascotas);
        request.setAttribute("listaServicios", servicios);

        request.getRequestDispatcher("Cita/listarCita.jsp").forward(request, response);
    }

    // =====================================================
    // BÚSQUEDA GENERAL
    // =====================================================
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String texto = request.getParameter("buscar");

        List<Cita> lista = modeloCita.buscarCita(texto);
        List<Mascota> mascotas = modeloMascota.listarMascotas();
        List<Servicio> servicios = modeloServicio.listarServicios();

        request.setAttribute("listaCitas", lista);
        request.setAttribute("listaMascotas", mascotas);
        request.setAttribute("listaServicios", servicios);

        request.getRequestDispatcher("Cita/listarCita.jsp").forward(request, response);
    }

    // =====================================================
    // INSERTAR
    // =====================================================
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Cita c = new Cita();

            c.setIdMascota(Integer.parseInt(request.getParameter("idMascota")));
            c.setIdServicio(Integer.parseInt(request.getParameter("idServicio")));
            c.setFecha(request.getParameter("fecha"));
            c.setHora(request.getParameter("hora"));
            c.setEstado(request.getParameter("estado"));

            boolean ok = modeloCita.insertarCita(c);

            if (ok) {
                response.sendRedirect("CitaController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // =====================================================
    // EDITAR (Cargar datos en modal)
    // =====================================================
    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Cita cita = modeloCita.buscarCita(id);
            List<Mascota> mascotas = modeloMascota.listarMascotas();
            List<Servicio> servicios = modeloServicio.listarServicios();

            request.setAttribute("cita", cita);
            request.setAttribute("listaMascotas", mascotas);
            request.setAttribute("listaServicios", servicios);

            request.getRequestDispatcher("Cita/editarCita.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // =====================================================
    // ACTUALIZAR
    // =====================================================
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Cita c = new Cita();

            c.setIdCita(Integer.parseInt(request.getParameter("idCita")));
            c.setIdMascota(Integer.parseInt(request.getParameter("idMascota")));
            c.setIdServicio(Integer.parseInt(request.getParameter("idServicio")));
            c.setFecha(request.getParameter("fecha"));
            c.setHora(request.getParameter("hora"));
            c.setEstado(request.getParameter("estado"));

            boolean ok = modeloCita.actualizarCita(c);

            if (ok) {
                response.sendRedirect("CitaController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // =====================================================
    // ELIMINAR
    // =====================================================
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            boolean ok = modeloCita.eliminarCita(id);

            if (ok) {
                response.sendRedirect("CitaController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // Métodos GET y POST
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Procesar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Procesar(request, response);
    }
}

