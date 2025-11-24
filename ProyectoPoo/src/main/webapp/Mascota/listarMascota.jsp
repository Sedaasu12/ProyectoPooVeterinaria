<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Mascota, beans.cliente" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Mascotas</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-4">

    <h2 class="mb-4 text-center">Gestión de Mascotas</h2>

    <!-- BUSCADOR -->
    <form action="MascotaController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por nombre, raza, especie o dueño...">
        <button class="btn btn-primary">Buscar</button>
    </form>

    <!-- BOTÓN MODAL REGISTRAR -->
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        Registrar Mascota
    </button>

    <!-- TABLA -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Especie</th>
            <th>Raza</th>
            <th>Sexo</th>
            <th>F. Nac</th>
            <th>Dueño</th>
            <th>Acciones</th>
        </tr>
        </thead>

        <tbody>

        <%
            List<Mascota> lista = (List<Mascota>) request.getAttribute("listaMascotas");
            List<cliente> clientes = (List<cliente>) request.getAttribute("listaClientes");

            if (lista != null) {
                for (Mascota m : lista) {
        %>

        <tr>
            <td><%= m.getIdMascota() %></td>
            <td><%= m.getNombre() %></td>
            <td><%= m.getEspecie() %></td>
            <td><%= m.getRaza() %></td>
            <td><%= m.getSexo() %></td>
            <td><%= m.getFechaNacimiento() %></td>
            <td><%= m.getClienteNombre() %></td>

            <td>

                <!-- BOTÓN MODAL EDITAR -->
                <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEditar<%= m.getIdMascota() %>">
                    Editar
                </button>

                <!-- BOTÓN MODAL ELIMINAR -->
                <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEliminar<%= m.getIdMascota() %>">
                    Eliminar
                </button>

            </td>
        </tr>

        <!-- =========================== -->
        <!--     MODAL EDITAR MASCOTA    -->
        <!-- =========================== -->
        <div class="modal fade" id="modalEditar<%= m.getIdMascota() %>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Editar Mascota</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="MascotaController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idMascota" value="<%= m.getIdMascota() %>">

                        <div class="modal-body row g-3">

                            <div class="col-md-6">
                                <label class="form-label">Nombre:</label>
                                <input type="text" name="nombre" class="form-control" value="<%= m.getNombre() %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Especie:</label>
                                <input type="text" name="especie" class="form-control" value="<%= m.getEspecie() %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Raza:</label>
                                <input type="text" name="raza" class="form-control" value="<%= m.getRaza() %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Sexo:</label>
                                <select name="sexo" class="form-select">
                                    <option value="Macho" <%= m.getSexo().equals("Macho") ? "selected" : "" %>>Macho</option>
                                    <option value="Hembra" <%= m.getSexo().equals("Hembra") ? "selected" : "" %>>Hembra</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Fecha Nacimiento:</label>
                                <input type="date" name="fechaNacimiento" class="form-control"
                                       value="<%= m.getFechaNacimiento() %>" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Dueño:</label>
                                <select name="idCliente" class="form-select">
                                    <% for (cliente c : clientes) { %>
                                        <option value="<%= c.getIdCliente() %>"
                                            <%= (c.getIdCliente() == m.getIdCliente()) ? "selected" : "" %>>
                                            <%= c.getClienteNombre() %> <%= c.getClienteApellido() %>
                                        </option>
                                    <% } %>
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

        <!-- =========================== -->
        <!--     MODAL ELIMINAR         -->
        <!-- =========================== -->
        <div class="modal fade" id="modalEliminar<%= m.getIdMascota() %>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">Eliminar Mascota</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        ¿Seguro que deseas eliminar a <strong><%= m.getNombre() %></strong>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>

                        <a class="btn btn-danger" href="MascotaController?op=eliminar&id=<%= m.getIdMascota() %>">
                            Eliminar
                        </a>
                    </div>

                </div>
            </div>
        </div>

        <% }} %>

        </tbody>
    </table>

</div>

<!-- =========================== -->
<!--     MODAL REGISTRAR         -->
<!-- =========================== -->
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Registrar Mascota</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="MascotaController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-6">
                        <label class="form-label">Nombre:</label>
                        <input type="text" name="nombre" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Especie:</label>
                        <input type="text" name="especie" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Raza:</label>
                        <input type="text" name="raza" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Sexo:</label>
                        <select name="sexo" class="form-select" required>
                            <option value="">Seleccione</option>
                            <option value="Macho">Macho</option>
                            <option value="Hembra">Hembra</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Fecha Nacimiento:</label>
                        <input type="date" name="fechaNacimiento" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Dueño:</label>
                        <select name="idCliente" class="form-select" required>
                            <option value="">Seleccione un cliente</option>
                            <% if (clientes != null) {
                                for (cliente c : clientes) { %>
                                    <option value="<%= c.getIdCliente() %>">
                                        <%= c.getClienteNombre() %> <%= c.getClienteApellido() %>
                                    </option>
                            <% }} %>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
