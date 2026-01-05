package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.AtencionModel;
import models.CitaModel;

import models.VeterinarioModel;

import java.io.IOException;
import java.util.List;

import beans.Atencion;


/**
 * Servlet implementation class AtencionController
 */
@WebServlet("/AtencionController")
public class AtencionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	private AtencionModel modeloAtencion = new AtencionModel();
    private CitaModel modeloCita = new CitaModel();
    private VeterinarioModel modeloVeterinario = new VeterinarioModel();

    /* =====================================================
     * MÉTODO CENTRAL
     * ===================================================== */
    protected void procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String op = request.getParameter("op");

        if (op == null) {
            op = "listar";
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
                break;
        }
    }


    /* =====================================================
     * LISTAR
     * ===================================================== */
    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("listaAtenciones", modeloAtencion.listarAtenciones());
        request.setAttribute("listaCitas", modeloCita.listarCitas());
        request.setAttribute("listaVeterinarios", modeloVeterinario.listarVeterinarios());

        request.getRequestDispatcher("Atencion/listarAtencion.jsp")
               .forward(request, response);
    }

    /* =====================================================
     * BUSCAR
     * ===================================================== */
    private void buscar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String texto = request.getParameter("buscar");

        List<Atencion> lista = modeloAtencion.buscarAtenciones(texto);

        request.setAttribute("listaAtenciones", lista);
        request.setAttribute("listaCitas", modeloCita.listarCitas());
        request.setAttribute("listaVeterinarios", modeloVeterinario.listarVeterinarios());

        request.getRequestDispatcher("Atencion/listarAtencion.jsp")
               .forward(request, response);
    }

    /* =====================================================
     * INSERTAR
     * ===================================================== */
    private void insertar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Atencion a = new Atencion();
            a.setIdCita(Integer.parseInt(request.getParameter("idCita")));
            a.setIdVeterinario(Integer.parseInt(request.getParameter("idVeterinario")));
            a.setDiagnostico(request.getParameter("diagnostico"));
            a.setTratamiento(request.getParameter("tratamiento"));
            a.setReceta(request.getParameter("receta"));

            modeloAtencion.insertarAtencion(a);
            response.sendRedirect("AtencionController?op=listar");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    /* =====================================================
     * EDITAR
     * ===================================================== */
    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Atencion a = modeloAtencion.buscarAtencionPorId(id);

        request.setAttribute("atencion", a);
        request.setAttribute("listaVeterinarios", modeloVeterinario.listarVeterinarios());

        request.getRequestDispatcher("Atencion/editarAtencion.jsp")
               .forward(request, response);
    }

    /* =====================================================
     * ACTUALIZAR
     * ===================================================== */
    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Atencion a = new Atencion();
            a.setIdAtencion(Integer.parseInt(request.getParameter("idAtencion")));
            a.setDiagnostico(request.getParameter("diagnostico"));
            a.setTratamiento(request.getParameter("tratamiento"));
            a.setReceta(request.getParameter("receta"));

            modeloAtencion.actualizarAtencion(a);
            response.sendRedirect("AtencionController?op=listar");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    /* =====================================================
     * DESACTIVAR (ELIMINADO LÓGICO)
     * ===================================================== */
    private void desactivar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        modeloAtencion.desactivarAtencion(id);
        response.sendRedirect("AtencionController?op=listar");
    }

    /* =====================================================
     * ACTIVAR
     * ===================================================== */
    private void activar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        modeloAtencion.activarAtencion(id);
        response.sendRedirect("AtencionController?op=listar");
    }

    /* =====================================================
     * MÉTODOS HTTP
     * ===================================================== */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }}
