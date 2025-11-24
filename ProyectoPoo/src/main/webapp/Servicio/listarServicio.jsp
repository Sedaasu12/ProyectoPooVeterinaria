<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Servicio" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Servicios</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-4">

    <h2 class="mb-4 text-center">Gestión de Servicios</h2>

    <!-- BUSCADOR -->
    <form action="ServicioController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por nombre o descripción...">
        <button class="btn btn-primary">Buscar</button>
    </form>

    <!-- BOTÓN MODAL REGISTRAR -->
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        Registrar Servicio
    </button>

    <!-- TABLA -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nombre del Servicio</th>
            <th>Descripción</th>
            <th>Precio (S/.)</th>
            <th>Acciones</th>
        </tr>
        </thead>

        <tbody>

        <%
            List<Servicio> lista = (List<Servicio>) request.getAttribute("listaServicios");
            if (lista != null) {
                for (Servicio s : lista) {
        %>

        <tr>
            <td><%= s.getIdServicio() %></td>
            <td><%= s.getNombreServicio() %></td>
            <td><%= s.getDescripcion() %></td>
            <td>S/ <%= s.getPrecio() %></td>

            <td>

                <!-- BOTÓN MODAL EDITAR -->
                <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEditar<%= s.getIdServicio() %>">
                    Editar
                </button>

                <!-- BOTÓN MODAL ELIMINAR -->
                <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEliminar<%= s.getIdServicio() %>">
                    Eliminar
                </button>

            </td>
        </tr>

        <!-- =========================== -->
        <!--       MODAL EDITAR          -->
        <!-- =========================== -->
        <div class="modal fade" id="modalEditar<%= s.getIdServicio() %>" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Editar Servicio</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="ServicioController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idServicio" value="<%= s.getIdServicio() %>">

                        <div class="modal-body">

                            <label class="form-label">Nombre del Servicio:</label>
                            <input type="text" name="nombreServicio" class="form-control mb-3"
                                   value="<%= s.getNombreServicio() %>" required>

                            <label class="form-label">Descripción:</label>
                            <textarea name="descripcion" class="form-control mb-3" required><%= s.getDescripcion() %></textarea>

                            <label class="form-label">Precio (S/.):</label>
                            <input type="number" step="0.01" name="precio" class="form-control"
                                   value="<%= s.getPrecio() %>" required>

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
        <!--      MODAL ELIMINAR         -->
        <!-- =========================== -->
        <div class="modal fade" id="modalEliminar<%= s.getIdServicio() %>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">Eliminar Servicio</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        ¿Seguro que deseas eliminar el servicio
                        <strong><%= s.getNombreServicio() %></strong>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>

                        <a class="btn btn-danger" href="ServicioController?op=eliminar&id=<%= s.getIdServicio() %>">
                            Eliminar
                        </a>
                    </div>

                </div>
            </div>
        </div>

        <% } } %>

        </tbody>
    </table>

</div>

<!-- =========================== -->
<!--      MODAL REGISTRAR        -->
<!-- =========================== -->
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Registrar Servicio</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="ServicioController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body">

                    <label class="form-label">Nombre del Servicio:</label>
                    <input type="text" name="nombreServicio" class="form-control mb-3" required>

                    <label class="form-label">Descripción:</label>
                    <textarea name="descripcion" class="form-control mb-3" required></textarea>

                    <label class="form-label">Precio (S/.):</label>
                    <input type="number" step="0.01" name="precio" class="form-control" required>

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
