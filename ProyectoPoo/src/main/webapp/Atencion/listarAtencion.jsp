<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Atencion, beans.Cita" %>

<%
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);

if(session.getAttribute("usuario") == null){
    response.sendRedirect(request.getContextPath() + "/LoginController");
    return;
}
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

<!-- NAVBAR -->
<jsp:include page="/components/navbar.jsp"/>

<div class="container mt-4">

    <h2 class="mb-4 text-center">
        <i class="fas fa-notes-medical"></i> Gestión de Atenciones
    </h2>

    <!-- BUSCADOR -->
    <form action="<%= request.getContextPath() %>/AtencionController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2"
               placeholder="Buscar por mascota, cliente, servicio o diagnóstico...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-plus-circle"></i> Registrar Atención
    </button>
    <% } %>

    <!-- TABLA -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Mascota</th>
            <th>Cliente</th>
            <th>Servicio</th>
            <th>Fecha Atención</th>
            <th>Diagnóstico</th>
            <th>Tratamiento</th>
            <th>Receta</th>
            <th style="width: 120px;">Acciones</th>
        </tr>
        </thead>

        <tbody>
        <%
        List<Atencion> lista = (List<Atencion>) request.getAttribute("listaAtenciones");
        List<Cita> citas = (List<Cita>) request.getAttribute("listaCitas");

        if(lista != null){
            for(Atencion a : lista){
        %>

        <tr>
            <td><%=a.getIdAtencion()%></td>
            <td><%=a.getMascota()%></td>
            <td><%=a.getCliente()%></td>
            <td><%=a.getServicio()%></td>
            <td><%=a.getFechaAtencion()%></td>
            <td><%=a.getDiagnostico()%></td>
            <td><%=a.getTratamiento()%></td>
            <td><%=a.getReceta()%></td>

            <td class="text-center">
                <div class="btn-group">

                    <% if(esAdmin){ %>

                    <!-- EDITAR -->
                    <button class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEditar<%=a.getIdAtencion()%>">
                        <i class="fas fa-edit"></i>
                    </button>

                    <!-- ELIMINAR -->
                    <button class="btn btn-danger btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEliminar<%=a.getIdAtencion()%>">
                        <i class="fas fa-trash-alt"></i>
                    </button>

                    <% }else{ %>
                        <span class="badge bg-secondary">Solo lectura</span>
                    <% } %>

                </div>
            </td>
        </tr>

        <!-- MODAL EDITAR -->
        <div class="modal fade" id="modalEditar<%=a.getIdAtencion()%>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header bg-warning">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Editar Atención</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="AtencionController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idAtencion" value="<%=a.getIdAtencion()%>">

                        <div class="modal-body row g-3">

                            <div class="col-md-12">
                                <label>Cita:</label>
                                <select class="form-select" name="idCita">
                                    <% for(Cita c : citas){ %>
                                    <option value="<%=c.getIdCita()%>"
                                        <%=c.getIdCita()==a.getIdCita() ? "selected" : ""%>>
                                        <%=c.getMascota()%> - <%=c.getCliente()%> | <%=c.getServicio()%>
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Diagnóstico:</label>
                                <input type="text" name="diagnostico" class="form-control" value="<%=a.getDiagnostico()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Tratamiento:</label>
                                <input type="text" name="tratamiento" class="form-control" value="<%=a.getTratamiento()%>" required>
                            </div>

                            <div class="col-md-12">
                                <label>Receta:</label>
                                <input type="text" name="receta" class="form-control" value="<%=a.getReceta()%>" required>
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

        <!-- MODAL ELIMINAR -->
        <div class="modal fade" id="modalEliminar<%=a.getIdAtencion()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fas fa-trash"></i> Eliminar Atención</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        ¿Eliminar atención de <b><%=a.getMascota()%></b>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a class="btn btn-danger" href="AtencionController?op=eliminar&id=<%=a.getIdAtencion()%>">Eliminar</a>
                    </div>

                </div>
            </div>
        </div>

        <% } } %>

        </tbody>
    </table>
</div>

<!-- MODAL REGISTRAR -->
<% if(esAdmin){ %>
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Registrar Atención</h5>
                <button class="btn-close"></button>
            </div>

            <form action="AtencionController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-12">
                        <label>Cita:</label>
                        <select name="idCita" class="form-select" required>
                            <option value="">Seleccione una cita</option>

                            <% if(citas != null){ 
                                for(Cita c: citas){ %>
                                <option value="<%=c.getIdCita()%>">
                                    <%=c.getMascota()%> - <%=c.getCliente()%> | <%=c.getServicio()%>
                                </option>
                            <% }} %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label>Diagnóstico:</label>
                        <input type="text" name="diagnostico" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label>Tratamiento:</label>
                        <input type="text" name="tratamiento" class="form-control" required>
                    </div>

                    <div class="col-md-12">
                        <label>Receta:</label>
                        <input type="text" name="receta" class="form-control" required>
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
