package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.UsuariosModel;
import models.VeterinarioModel;

import java.io.IOException;
import java.util.List;

import beans.Usuario;
import beans.Veterinario;

/**
 * Servlet implementation class VeterinarioController
 */
@WebServlet("/VeterinarioController")
public class VeterinarioController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	

    VeterinarioModel veterinarioModel = new VeterinarioModel();
    UsuariosModel usuarioModel = new UsuariosModel();

    // ================= PROCESAR =================
    protected void procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        if (op == null) op = "listar";

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
            case "actualizar":
                actualizar(request, response);
                break;
            case "desactivar":
                desactivar(request, response);
                break;
            case "activar":
                activar(request, response);
                break;
            default:
                listar(request, response);
        }
    }

    // ================= LISTAR =================
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Veterinario> lista = veterinarioModel.listarVeterinarios();
        List<Usuario> usuarios = usuarioModel.listarUsuarios(); // SOLO usuarios libres

        request.setAttribute("listaVeterinarios", lista);
        request.setAttribute("listaUsuarios", usuarios);

        request.getRequestDispatcher("Veterinario/listarVeterinario.jsp")
               .forward(request, response);
    }

    // ================= BUSCAR =================
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String texto = request.getParameter("buscar");

        if (texto == null || texto.trim().isEmpty()) {
            listar(request, response);
            return;
        }

        List<Veterinario> lista = veterinarioModel.buscarVeterinario(texto);
        List<Usuario> usuarios = usuarioModel.listarUsuarios();

        request.setAttribute("listaVeterinarios", lista);
        request.setAttribute("listaUsuarios", usuarios);

        request.getRequestDispatcher("Veterinario/listarVeterinario.jsp")
               .forward(request, response);
    }

    // ================= INSERTAR =================
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession s = request.getSession();
        if (!"ADMIN".equals(s.getAttribute("rol"))) {
            response.sendRedirect("error.jsp");
            return;
        }

        Veterinario v = new Veterinario();
        v.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
        v.setNombres(request.getParameter("nombres"));
        v.setApellidos(request.getParameter("apellidos"));
        v.setDni(request.getParameter("dni"));
        v.setTelefono(request.getParameter("telefono"));
        v.setEspecialidad(request.getParameter("especialidad"));

        veterinarioModel.insertarVeterinario(v);
        response.sendRedirect("VeterinarioController?op=listar");
    }

    // ================= ACTUALIZAR =================
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession s = request.getSession();
        if (!"ADMIN".equals(s.getAttribute("rol"))) {
            response.sendRedirect("error.jsp");
            return;
        }

        Veterinario v = new Veterinario();
        v.setIdVeterinario(Integer.parseInt(request.getParameter("idVeterinario")));
        v.setNombres(request.getParameter("nombres"));
        v.setApellidos(request.getParameter("apellidos"));
        v.setTelefono(request.getParameter("telefono"));
        v.setEspecialidad(request.getParameter("especialidad"));

        veterinarioModel.actualizarVeterinario(v);
        response.sendRedirect("VeterinarioController?op=listar");
    }

    // ================= DESACTIVAR =================
    private void desactivar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession s = request.getSession();
        if (!"ADMIN".equals(s.getAttribute("rol"))) {
            response.sendRedirect("error.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        veterinarioModel.desactivarVeterinario(id);

        response.sendRedirect("VeterinarioController?op=listar");
    }

    // ================= ACTIVAR =================
    private void activar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession s = request.getSession();
        if (!"ADMIN".equals(s.getAttribute("rol"))) {
            response.sendRedirect("error.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        veterinarioModel.activarVeterinario(id);

        response.sendRedirect("VeterinarioController?op=listar");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }
}