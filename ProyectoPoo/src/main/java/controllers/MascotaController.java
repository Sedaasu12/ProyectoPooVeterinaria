package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ClienteModel;
import models.MascotaModel;

import java.io.IOException;
import java.util.List;

import beans.Mascota;
import beans.cliente;

/**
 * Servlet implementation class MascotaController
 */
@WebServlet("/MascotaController")
public class MascotaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MascotaModel modeloMascota = new MascotaModel();
    ClienteModel modeloCliente = new ClienteModel();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MascotaController() {
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

        case "eliminar":
            eliminar(request, response);
            break;

        case "editar":
            editar(request, response);
            break;

        case "actualizar":
            actualizar(request, response);
            break;

        default:
            listar(request, response);
            break;
        }
    }

    // ===========================
    // LISTAR MASCOTAS
    // ===========================
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Mascota> lista = modeloMascota.listarMascotas();
        request.setAttribute("listaMascotas", lista);

        // cargar clientes para el modal registrar
        List<cliente> listaClientes = modeloCliente.listarClientes();
        request.setAttribute("listaClientes", listaClientes);

        request.getRequestDispatcher("Mascota/listarMascota.jsp").forward(request, response);
    }

    // ===========================
    // BUSCAR MASCOTA (multi-búsqueda)
    // ===========================
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String busqueda = request.getParameter("buscar");

        List<Mascota> lista = modeloMascota.buscarMascotaPorNombre(busqueda);
        request.setAttribute("listaMascotas", lista);

        List<cliente> listaClientes = modeloCliente.listarClientes();
        request.setAttribute("listaClientes", listaClientes);

        request.getRequestDispatcher("Mascota/listarMascota.jsp").forward(request, response);
    }

    // ===========================
    // INSERTAR MASCOTA
    // ===========================
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Mascota m = new Mascota();

            m.setNombre(request.getParameter("nombre"));
            m.setEspecie(request.getParameter("especie"));
            m.setRaza(request.getParameter("raza"));
            m.setSexo(request.getParameter("sexo"));
            m.setFechaNacimiento(request.getParameter("fechaNacimiento"));
            m.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));

            boolean ok = modeloMascota.insertarMascota(m);

            if (ok) {
                response.sendRedirect("MascotaController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ===========================
    // ELIMINAR MASCOTA
    // ===========================
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ok = modeloMascota.eliminarMascota(id);

            if (ok) {
                response.sendRedirect("MascotaController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ===========================
    // EDITAR (Cargar datos al modal)
    // ===========================
    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Mascota mascota = modeloMascota.buscarMascota(id);
            List<cliente> listaClientes = modeloCliente.listarClientes();

            request.setAttribute("mascota", mascota);
            request.setAttribute("listaClientes", listaClientes);

            request.getRequestDispatcher("Mascota/editarMascota.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ===========================
    // ACTUALIZAR
    // ===========================
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Mascota m = new Mascota();

            m.setIdMascota(Integer.parseInt(request.getParameter("idMascota")));
            m.setNombre(request.getParameter("nombre"));
            m.setEspecie(request.getParameter("especie"));
            m.setRaza(request.getParameter("raza"));
            m.setSexo(request.getParameter("sexo"));
            m.setFechaNacimiento(request.getParameter("fechaNacimiento"));
            m.setIdCliente(Integer.parseInt(request.getParameter("idCliente")));

            boolean ok = modeloMascota.actualizarMascota(m);

            if (ok) {
                response.sendRedirect("MascotaController?op=listar");
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
