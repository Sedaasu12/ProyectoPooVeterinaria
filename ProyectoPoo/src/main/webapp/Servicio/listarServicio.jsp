<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Servicio" %>

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
    <title>Gestión de Servicios</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<!-- 🔷 NAVBAR GLOBAL -->
<jsp:include page="/components/navbar.jsp"/>

<div class="container mt-4">

    <h2 class="mb-4 text-center">
        <i class="fas fa-hand-holding-heart"></i> Gestión de Servicios
    </h2>

    <!-- 🔍 BUSCADOR -->
    <form action="ServicioController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por nombre o descripción...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <!-- 📌 SOLO ADMIN PUEDE REGISTRAR -->
    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-plus-circle"></i> Registrar Servicio
    </button>
    <% } %>

    <!-- 📄 TABLA -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Servicio</th>
            <th>Descripción</th>
            <th>Precio (S/.)</th>
            <th>Acciones</th>
        </tr>
        </thead>

        <tbody>
        <%
        List<Servicio> lista = (List<Servicio>) request.getAttribute("listaServicios");
        if(lista != null){
            for(Servicio s : lista){
        %>
        <tr>
            <td><%= s.getIdServicio() %></td>
            <td><%= s.getNombreServicio() %></td>
            <td><%= s.getDescripcion() %></td>
            <td>S/ <%= s.getPrecio() %></td>

            <td>

            <!-- EDITAR 🔷 solo Administrador -->
            <% if(esAdmin){ %>
                <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEditar<%=s.getIdServicio()%>">
                    <i class="fas fa-edit"></i>
                </button>

                <!-- ELIMINAR 🔴 solo Administrador -->
                <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEliminar<%=s.getIdServicio()%>">
                    <i class="fas fa-trash"></i>
                </button>
            <% }else{ %>
                <span class="badge bg-secondary">Solo lectura</span>
            <% } %>

            </td>
        </tr>

        <!-- MODAL EDITAR -->
        <div class="modal fade" id="modalEditar<%=s.getIdServicio()%>" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Editar Servicio</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="ServicioController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idServicio" value="<%=s.getIdServicio()%>">

                        <div class="modal-body">

                            <label class="form-label">Nombre:</label>
                            <input type="text" name="nombreServicio" class="form-control mb-2"
                                   value="<%=s.getNombreServicio()%>" required>

                            <label class="form-label">Descripción:</label>
                            <textarea name="descripcion" class="form-control mb-2" required><%=s.getDescripcion()%></textarea>

                            <label class="form-label">Precio (S/.):</label>
                            <input type="number" step="0.01" name="precio" class="form-control"
                                   value="<%=s.getPrecio()%>" required>

                        </div>

                        <div class="modal-footer">
                            <button type="button" data-bs-dismiss="modal" class="btn btn-secondary">Cancelar</button>
                            <button type="submit" class="btn btn-warning">Actualizar</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <!-- MODAL ELIMINAR -->
        <div class="modal fade" id="modalEliminar<%=s.getIdServicio()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fas fa-trash-alt"></i> Eliminar Servicio</h5>
                        <button type="button" class="btn-close"></button>
                    </div>

                    <div class="modal-body">
                        🗑 ¿Eliminar servicio <b><%=s.getNombreServicio()%></b>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a href="ServicioController?op=eliminar&id=<%=s.getIdServicio()%>" class="btn btn-danger">Eliminar</a>
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
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-plus-circle"></i> Registrar Servicio</h5>
                <button type="button" class="btn-close"></button>
            </div>

            <form action="ServicioController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body">

                    <label class="form-label">Nombre del Servicio:</label>
                    <input type="text" name="nombreServicio" class="form-control mb-2" required>

                    <label class="form-label">Descripción:</label>
                    <textarea name="descripcion" class="form-control mb-2" required></textarea>

                    <label class="form-label">Precio (S/.):</label>
                    <input type="number" step="0.01" name="precio" class="form-control mb-2" required>

                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button class="btn btn-success" type="submit">Registrar</button>
                </div>

            </form>

        </div>
    </div>
</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
