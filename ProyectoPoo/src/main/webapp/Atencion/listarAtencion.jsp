<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Atencion, beans.Cita, beans.Veterinario" %>

<%
if (session.getAttribute("usuario") == null) {
    response.sendRedirect(request.getContextPath() + "/LoginController");
    return;
}

String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);
boolean esVet = "VETERINARIO".equals(rol);
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Atenciones</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-light">

<jsp:include page="/components/navbar.jsp"/>

<div class="container mt-4">

    <h2 class="mb-4 text-center">
        <i class="fas fa-notes-medical"></i> Gestión de Atenciones
    </h2>

    <!-- BUSCADOR -->
    <form action="AtencionController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2"
               placeholder="Buscar por mascota, cliente, servicio o diagnóstico">
        <button class="btn btn-primary">
            <i class="fas fa-search"></i>
        </button>
    </form>

    <% if (esAdmin || esVet) { %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-plus-circle"></i> Registrar Atención
    </button>
    <% } %>

    <!-- TABLA -->
    <table class="table table-bordered table-striped text-center align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Mascota</th>
                <th>Cliente</th>
                <th>Servicio</th>
                <th>Veterinario</th>
                <th>Fecha</th>
                <th>Diagnóstico</th>
                <th>Tratamiento</th>
                <th>Receta</th>
                <th>Estado</th>
                <th style="width:130px;">Acciones</th>
            </tr>
        </thead>

        <tbody>
        <%
        List<Atencion> lista = (List<Atencion>) request.getAttribute("listaAtenciones");

        if (lista != null && !lista.isEmpty()) {
            for (Atencion a : lista) {
        %>
            <tr>
                <td><%=a.getIdAtencion()%></td>
                <td><%=a.getMascota()%></td>
                <td><%=a.getCliente()%></td>
                <td><%=a.getServicio()%></td>
                <td><%=a.getVeterinario()%></td>
                <td><%=a.getFechaAtencion()%></td>
                <td><%=a.getDiagnostico()%></td>
                <td><%=a.getTratamiento()%></td>
                <td><%=a.getReceta()%></td>
                <td>
                    <span class="badge <%= "ACTIVO".equals(a.getEstado()) ? "bg-success" : "bg-secondary" %>">
                        <%=a.getEstado()%>
                    </span>
                </td>

                <td>
                <% if (esAdmin || esVet) { %>

                    <!-- EDITAR -->
                    <button class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEditar<%=a.getIdAtencion()%>">
                        <i class="fas fa-edit"></i>
                    </button>

                    <% if ("ACTIVO".equals(a.getEstado())) { %>
                        <a class="btn btn-danger btn-sm"
                           href="AtencionController?op=desactivar&id=<%=a.getIdAtencion()%>">
                            <i class="fas fa-ban"></i>
                        </a>
                    <% } else if (esAdmin) { %>
                        <a class="btn btn-success btn-sm"
                           href="AtencionController?op=activar&id=<%=a.getIdAtencion()%>">
                            <i class="fas fa-check"></i>
                        </a>
                    <% } %>

                <% } else { %>
                    <span class="badge bg-secondary">Solo lectura</span>
                <% } %>
                </td>
            </tr>

            <!-- MODAL EDITAR -->
            <div class="modal fade" id="modalEditar<%=a.getIdAtencion()%>" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <div class="modal-header bg-warning">
                            <h5 class="modal-title">
                                <i class="fas fa-edit"></i> Editar Atención
                            </h5>
                            <button class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <form action="AtencionController" method="post">
                            <input type="hidden" name="op" value="actualizar">
                            <input type="hidden" name="idAtencion" value="<%=a.getIdAtencion()%>">

                            <div class="modal-body row g-3">
                                <div class="col-md-6">
                                    <label>Diagnóstico</label>
                                    <textarea name="diagnostico" class="form-control" required><%=a.getDiagnostico()%></textarea>
                                </div>

                                <div class="col-md-6">
                                    <label>Tratamiento</label>
                                    <textarea name="tratamiento" class="form-control" required><%=a.getTratamiento()%></textarea>
                                </div>

                                <div class="col-md-12">
                                    <label>Receta</label>
                                    <textarea name="receta" class="form-control" required><%=a.getReceta()%></textarea>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button class="btn btn-warning">Actualizar</button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>

        <% } } else { %>
            <tr>
                <td colspan="11" class="text-center">No hay atenciones registradas</td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- MODAL REGISTRAR -->
<% if (esAdmin || esVet) { %>
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">
                    <i class="fas fa-plus-circle"></i> Registrar Atención
                </h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="AtencionController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-12">
                        <label>Cita</label>
                        <select name="idCita" class="form-select" required>
                            <option value="">Seleccione una cita</option>
                            <%
                            List<Cita> citas = (List<Cita>) request.getAttribute("listaCitas");
                            if (citas != null) {
                                for (Cita c : citas) {
                            %>
                                <option value="<%=c.getIdCita()%>">
                                    <%=c.getMascota()%> - <%=c.getCliente()%> | <%=c.getServicio()%>
                                </option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>

                    <div class="col-md-12">
                        <label>Veterinario</label>
                        <select name="idVeterinario" class="form-select" required>
                            <option value="">Seleccione veterinario</option>
                            <%
                            List<Veterinario> vets =
                                (List<Veterinario>) request.getAttribute("listaVeterinarios");
                            if (vets != null) {
                                for (Veterinario v : vets) {
                            %>
                                <option value="<%=v.getIdVeterinario()%>">
                                    <%=v.getNombres()%> <%=v.getApellidos()%>
                                </option>
                            <%
                                }
                            }
                            %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label>Diagnóstico</label>
                        <textarea name="diagnostico" class="form-control" required></textarea>
                    </div>

                    <div class="col-md-6">
                        <label>Tratamiento</label>
                        <textarea name="tratamiento" class="form-control" required></textarea>
                    </div>

                    <div class="col-md-12">
                        <label>Receta</label>
                        <textarea name="receta" class="form-control" required></textarea>
                    </div>

                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button class="btn btn-success">Registrar</button>
                </div>
            </form>

        </div>
    </div>
</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
