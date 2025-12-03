<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Usuario" %>

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
<title>Gestión de Usuarios</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body>

<!-- NAVBAR -->
<jsp:include page="/components/navbar.jsp" />

<div class="container mt-4">

    <h2 class="mb-4 text-center">
        <i class="fas fa-users"></i> Gestión de Usuarios
    </h2>

    <!-- 🔍 BUSCADOR -->
    <form action="UsuariosController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por nombre, email, rol...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <!-- 📌 BOTÓN ABRIR MODAL REGISTRO -->
    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-user-plus"></i> Registrar Usuario
    </button>
    <% } %>

    <!-- 📄 TABLA -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Nombre Completo</th>
                <th>Email</th>
                <th>Rol</th>
                <th>Estado</th>
                <th>Fecha Registro</th>
                <th>Acciones</th>
            </tr>
        </thead>

        <tbody>
        <%
        List<Usuario> lista = (List<Usuario>) request.getAttribute("usuarios");
        if(lista != null){
            for(Usuario u : lista){
        %>

        <tr>
            <td><%=u.getIdUsuario()%></td>
            <td><%=u.getNombreUsuario()%></td>
            <td><%=u.getNombreCompleto()%></td>
            <td><%=u.getEmail()%></td>
            <td><span class="badge bg-primary"><%=u.getRol()%></span></td>
            <td>
                <span class="badge <%=u.getEstado().equals("ACTIVO") ? "bg-success" : "bg-danger"%>">
                    <%=u.getEstado()%>
                </span>
            </td>
            <td><%=u.getFechaCreacion()%></td>

            <td>
                <!-- BOTON EDITAR -->
                <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEditar<%=u.getIdUsuario()%>">
                        <i class="fas fa-edit"></i>
                </button>

                <!-- BOTON ELIMINAR -->
                <% if(esAdmin){ %>
                <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEliminar<%=u.getIdUsuario()%>">
                        <i class="fas fa-trash"></i>
                </button>
                <% } %>
            </td>
        </tr>

        <!-- ====================== MODAL EDITAR ====================== -->
        <div class="modal fade" id="modalEditar<%=u.getIdUsuario()%>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header bg-warning">
                        <h5 class="modal-title"><i class="fas fa-user-edit"></i> Editar Usuario</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="UsuariosController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idUsuario" value="<%=u.getIdUsuario()%>">

                        <div class="modal-body row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Usuario:</label>
                                <input type="text" name="usuario" class="form-control" value="<%=u.getNombreUsuario()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Nombre Completo:</label>
                                <input type="text" name="nombreCompleto" class="form-control" value="<%=u.getNombreCompleto()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email:</label>
                                <input type="email" name="email" class="form-control" value="<%=u.getEmail()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Rol:</label>
                                <select name="rol" class="form-select">
                                    <option value="ADMIN" <%=u.getRol().equals("ADMIN")?"selected":""%>>ADMIN</option>
                                    <option value="USER"  <%=u.getRol().equals("USER")?"selected":""%>>USER</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Estado:</label>
                                <select name="estado" class="form-select">
                                    <option value="ACTIVO" <%=u.getEstado().equals("ACTIVO")?"selected":""%>>ACTIVO</option>
                                    <option value="INACTIVO" <%=u.getEstado().equals("INACTIVO")?"selected":""%>>INACTIVO</option>
                                </select>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button class="btn btn-warning" type="submit">Actualizar</button>
                        </div>

                    </form>

                </div>
            </div>
        </div>

        <!-- ====================== MODAL ELIMINAR ====================== -->
        <% if(esAdmin){ %>
        <div class="modal fade" id="modalEliminar<%=u.getIdUsuario()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fas fa-trash"></i> Eliminar usuario</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        ¿Eliminar permanentemente a <strong><%=u.getNombreUsuario()%></strong>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a class="btn btn-danger" href="UsuariosController?op=eliminar&id=<%=u.getIdUsuario()%>">
                            Eliminar
                        </a>
                    </div>

                </div>
            </div>
        </div>
        <% } %>

        <% }} %>
        </tbody>
    </table>

</div>


<!-- ====================== MODAL REGISTRAR ====================== -->
<% if(esAdmin){ %>
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-user-plus"></i> Registrar Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="UsuariosController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-6">
                        <label class="form-label">Usuario:</label>
                        <input type="text" name="usuario" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Contraseña:</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Nombre Completo:</label>
                        <input type="text" name="nombreCompleto" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Email:</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Rol:</label>
                        <select name="rol" class="form-select">
                            <option value="ADMIN">ADMIN</option>
                            <option value="USER">USER</option>
                        </select>
                    </div>

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
