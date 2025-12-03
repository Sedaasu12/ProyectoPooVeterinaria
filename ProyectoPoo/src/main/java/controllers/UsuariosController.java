package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.UsuariosModel;

import java.io.IOException;
import java.util.List;

import beans.Usuario;

/**
 * Servlet implementation class UsuariosController
 */
@WebServlet("/UsuariosController")
public class UsuariosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	UsuariosModel modelo = new UsuariosModel();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuariosController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String op = request.getParameter("op");
        if(op == null) op = "listar";

        switch(op){

            case "listar": listar(request, response); break;
            case "buscar": buscar(request, response); break;

            case "insertar": insertar(request, response); break;
            case "editar": cargarEdicion(request, response); break;
            case "actualizar": actualizar(request, response); break;
            case "eliminar": eliminar(request, response); break;

            default: listar(request, response); break;
        }
    }

    // ================= LISTAR =====================
    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario> lista = modelo.listarUsuarios();
        request.setAttribute("usuarios", lista);
        request.getRequestDispatcher("usuarios/usuarios.jsp").forward(request,response);
    }

    // ================= BUSCAR =====================
    private void buscar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String txt = request.getParameter("buscar");
        List<Usuario> lista = modelo.buscarUsuario(txt);
        request.setAttribute("usuarios", lista);
        request.getRequestDispatcher("usuarios/usuarios.jsp").forward(request,response);
    }

    // ================= INSERTAR =====================
    private void insertar(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession s = request.getSession();
        if(!"ADMIN".equals(s.getAttribute("rol"))){ response.sendRedirect("error.jsp"); return; }

        Usuario u = new Usuario();
        u.setNombreUsuario(request.getParameter("usuario"));
        u.setPassword(request.getParameter("password"));
        u.setNombreCompleto(request.getParameter("nombreCompleto"));
        u.setEmail(request.getParameter("email"));
        u.setRol(request.getParameter("rol"));

        modelo.insertarUsuario(u);
        response.sendRedirect("UsuariosController?op=listar");
    }

    // ================= CARGAR PARA EDITAR =====================
    private void cargarEdicion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Usuario u = modelo.obtenerUsuario(id);

        request.setAttribute("user", u);
        request.getRequestDispatcher("usuarios/editarUsuario.jsp").forward(request,response);
    }

    // ================= ACTUALIZAR =====================
    private void actualizar(HttpServletRequest request, HttpServletResponse response) throws IOException {

        Usuario u = new Usuario();
        u.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
        u.setNombreUsuario(request.getParameter("usuario"));
        u.setNombreCompleto(request.getParameter("nombreCompleto"));
        u.setEmail(request.getParameter("email"));
        u.setRol(request.getParameter("rol"));
        u.setEstado(request.getParameter("estado"));

        modelo.modificarUsuario(u);
        response.sendRedirect("UsuariosController?op=listar");
    }

    // ================= ELIMINAR =====================
    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession s = request.getSession();
        if(!"ADMIN".equals(s.getAttribute("rol"))){ response.sendRedirect("error.jsp"); return; }

        int id = Integer.parseInt(request.getParameter("id"));
        modelo.eliminarUsuario(id);

        response.sendRedirect("UsuariosController?op=listar");
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { process(req,res); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { process(req,res); }

}