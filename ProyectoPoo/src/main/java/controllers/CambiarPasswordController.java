package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.UsuariosModel;

import java.io.IOException;

/**
 * Servlet implementation class CambiarPasswordController
 */
@WebServlet("/CambiarPasswordController")
public class CambiarPasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	UsuariosModel modelo = new UsuariosModel();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CambiarPasswordController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");
        if(op == null) op = "form";

        switch(op){
            case "form":
                mostrarFormulario(request, response);
                break;

            case "cambiar":
                cambiarPassword(request, response);
                break;

            default:
                mostrarFormulario(request, response);
        }
    }

    // ==================== FORMULARIO ====================
    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession(false);
        if(ses == null || ses.getAttribute("usuario") == null){
            response.sendRedirect("LoginController");
            return;
        }

        request.getRequestDispatcher("usuarios/cambiarPassword.jsp").forward(request, response);
    }

    // ==================== CAMBIAR CONTRASEÑA ====================
    private void cambiarPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession ses = request.getSession(false);
        if(ses == null || ses.getAttribute("usuario") == null){
            response.sendRedirect("LoginController");
            return;
        }

        int idUsuario = (int) ses.getAttribute("idUsuario");

        String actual = request.getParameter("passwordActual");
        String nueva = request.getParameter("passwordNueva");
        String repetir = request.getParameter("passwordRepetir");

        // Validaciones
        if(actual == null || nueva == null || repetir == null ||
                actual.isEmpty() || nueva.isEmpty() || repetir.isEmpty())
        {
            request.setAttribute("error", "Debe completar todos los campos");
            mostrarFormulario(request, response);
            return;
        }

        // Validar contraseña actual
        if(modelo.autenticarUsuario((String) ses.getAttribute("nombreUsuario"), actual) == null){
            request.setAttribute("error", "La contraseña actual es incorrecta");
            mostrarFormulario(request, response);
            return;
        }

        // Validar coincidencia
        if(!nueva.equals(repetir)){
            request.setAttribute("error", "La nueva contraseña no coincide");
            mostrarFormulario(request, response);
            return;
        }

        // Llamar al SP
        int r = modelo.cambiarPassword(idUsuario, nueva);

        if(r > 0){
            request.setAttribute("success", "Contraseña actualizada correctamente");
        } else {
            request.setAttribute("error", "No se pudo actualizar la contraseña");
        }

        mostrarFormulario(request, response);
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { processRequest(req, resp); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { processRequest(req, resp); }

}
