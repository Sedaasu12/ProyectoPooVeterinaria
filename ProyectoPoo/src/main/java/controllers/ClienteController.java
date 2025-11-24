package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ClienteModel;

import java.io.IOException;
import java.util.List;

import beans.cliente;

/**
 * Servlet implementation class ClienteController
 */
@WebServlet("/ClienteController")
public class ClienteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ClienteModel model = new ClienteModel();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClienteController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    
 // ======================================================
    // MÉTODO PRINCIPAL DE CONTROL
    // ======================================================
    protected void Procedimientos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operacion = request.getParameter("op");
        if (operacion == null) {
            listar(request, response);
            return;
        }

        switch (operacion) {
            case "listar":
                listar(request, response);
                break;

            case "buscar":
                buscar(request, response);
                break;

            case "nuevo":
                nuevo(request, response);
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
                throw new IllegalArgumentException("Operación no válida: " + operacion);
        }
    }

    // ======================================================
    // LISTAR CLIENTES
    // ======================================================
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<cliente> lista = model.listarClientes();
        request.setAttribute("listaClientes", lista);
        request.getRequestDispatcher("clientes/lista.jsp").forward(request, response);
    }

    // ======================================================
    // BUSCAR CLIENTE POR NOMBRE o DNI
    // ======================================================
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String criterio = request.getParameter("buscar");

        List<cliente> lista = model.buscarClientes(criterio);

        request.setAttribute("listaClientes", lista);
        request.getRequestDispatcher("clientes/lista.jsp").forward(request, response);
    }

    // ======================================================
    // NUEVO CLIENTE (solo muestra formulario)
    // ======================================================
    private void nuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("clientes/registrar.jsp").forward(request, response);
    }

    // ======================================================
    // INSERTAR CLIENTE
    // ======================================================
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            cliente c = new cliente();
            c.setClienteDni(request.getParameter("dni"));
            c.setClienteNombre(request.getParameter("nombres"));
            c.setClienteApellido(request.getParameter("apellidos"));
            c.setClienteTelefono(request.getParameter("telefono"));
            c.setClienteEmail(request.getParameter("email"));
            c.setClienteDireccion(request.getParameter("direccion"));

            boolean resultado = model.insertarCliente(c);

            if (resultado) {
                response.sendRedirect("ClienteController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ======================================================
    // EDITAR (BUSCAR POR ID)
    // ======================================================
    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            cliente cliente = model.buscarCliente(id);

            if (cliente != null) {
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("clientes/editar.jsp").forward(request, response);
            } else {
                response.sendRedirect("ClienteController?op=listar");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ======================================================
    // ACTUALIZAR CLIENTE
    // ======================================================
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            cliente c = new cliente();
            c.setIdCliente(Integer.parseInt(request.getParameter("id")));
            c.setClienteDni(request.getParameter("dni"));
            c.setClienteNombre(request.getParameter("nombres"));
            c.setClienteApellido(request.getParameter("apellidos"));
            c.setClienteTelefono(request.getParameter("telefono"));
            c.setClienteEmail(request.getParameter("email"));
            c.setClienteDireccion(request.getParameter("direccion"));

            boolean resultado = model.actualizarCliente(c);

            if (resultado) {
                response.sendRedirect("ClienteController?op=listar");
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ======================================================
    // ELIMINAR CLIENTE
    // ======================================================
    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            model.eliminarCliente(id);
            response.sendRedirect("ClienteController?op=listar");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    // ======================================================
    // doGet y doPost
    // ======================================================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Procedimientos(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Procedimientos(request, response);
    }

}
