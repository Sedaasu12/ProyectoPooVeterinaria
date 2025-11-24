package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ServicioModel;

import java.io.IOException;
import java.util.List;

import beans.Servicio;

/**
 * Servlet implementation class ServicioController
 */
@WebServlet("/ServicioController")
public class ServicioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ServicioModel modeloServicio = new ServicioModel();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServicioController() {
        super();
        // TODO Auto-generated constructor stub
    }

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

    // ===========================
    // LISTAR SERVICIOS
    // ===========================
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Servicio> lista = modeloServicio.listarServicios();
        request.setAttribute("listaServicios", lista);

        request.getRequestDispatcher("Servicio/listarServicio.jsp").forward(request, response);
    }

    // ===========================
    // BUSCAR SERVICIO
    // ===========================
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String busqueda = request.getParameter("buscar");

        List<Servicio> lista = modeloServicio.buscarServicio(busqueda);
        request.setAttribute("listaServicios", lista);

        request.getRequestDispatcher("Servicio/listarServicio.jsp").forward(request, response);
    }

    // ===========================
    // INSERTAR SERVICIO
    // ===========================
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Servicio s = new Servicio();
            s.setNombreServicio(request.getParameter("nombreServicio"));
            s.setDescripcion(request.getParameter("descripcion"));
            s.setPrecio(Double.parseDouble(request.getParameter("precio")));

            boolean ok = modeloServicio.insertarServicio(s);

            if (ok) {
                response.sendRedirect("ServicioController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ===========================
    // EDITAR (Cargar en modal)
    // ===========================
    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Servicio s = modeloServicio.buscarServicioID(id);
            request.setAttribute("servicio", s);

            request.getRequestDispatcher("Servicio/editarServicio.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ===========================
    // ACTUALIZAR SERVICIO
    // ===========================
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Servicio s = new Servicio();

            s.setIdServicio(Integer.parseInt(request.getParameter("idServicio")));
            s.setNombreServicio(request.getParameter("nombreServicio"));
            s.setDescripcion(request.getParameter("descripcion"));
            s.setPrecio(Double.parseDouble(request.getParameter("precio")));

            boolean ok = modeloServicio.actualizarServicio(s);

            if (ok) {
                response.sendRedirect("ServicioController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ===========================
    // ELIMINAR
    // ===========================
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            boolean ok = modeloServicio.eliminarServicio(id);

            if (ok) {
                response.sendRedirect("ServicioController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // Métodos GET y POST
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Procesar(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Procesar(request, response);
    }
}
