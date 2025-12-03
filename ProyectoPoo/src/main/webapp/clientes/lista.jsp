<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, beans.cliente" %>

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
    <title>Clientes - Veterinaria</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-light">

<!-- 🔷 NAVBAR -->
<jsp:include page="/components/navbar.jsp" />

<div class="container py-4">

    <h2 class="mb-3 text-center">
        <i class="fas fa-user-friends"></i> Gestión de Clientes
    </h2>

    <!-- 🔍 BUSCADOR -->
    <form class="d-flex mb-3" action="ClienteController" method="GET">
        <input type="hidden" name="op" value="buscar">
        <input name="buscar" class="form-control me-2" placeholder="Buscar por DNI o Nombre...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <!-- ➕ Registrar Cliente SOLO ADMIN -->
    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-user-plus"></i> Nuevo Cliente
    </button>
    <% } %>

    <!-- 📄 TABLA DE CLIENTES -->
    <div class="table-responsive">
        <table class="table table-striped table-bordered align-middle text-center">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>DNI</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Teléfono</th>
                <th>Email</th>
                <th>Dirección</th>
                <th>Opciones</th>
            </tr>
            </thead>

            <tbody>
            <%
                List<cliente> lista = (List<cliente>) request.getAttribute("listaClientes");
                if (lista != null) {
                    for (cliente c : lista) {
            %>

            <tr>
                <td><%=c.getIdCliente()%></td>
                <td><%=c.getClienteDni()%></td>
                <td><%=c.getClienteNombre()%></td>
                <td><%=c.getClienteApellido()%></td>
                <td><%=c.getClienteTelefono()%></td>
                <td><%=c.getClienteEmail()%></td>
                <td><%=c.getClienteDireccion()%></td>

                <td>
                <% if(esAdmin){ %>
                    <!-- EDITAR -->
                    <button class="btn btn-warning btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEditar"
                            onclick="cargarDatos(
                                    '<%=c.getIdCliente()%>',
                                    '<%=c.getClienteDni()%>',
                                    '<%=c.getClienteNombre()%>',
                                    '<%=c.getClienteApellido()%>',
                                    '<%=c.getClienteTelefono()%>',
                                    '<%=c.getClienteEmail()%>',
                                    '<%=c.getClienteDireccion()%>'
                            )">
                        <i class="fas fa-edit"></i>
                    </button>

                    <!-- ELIMINAR -->
                    <button class="btn btn-danger btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEliminar"
                            onclick="document.getElementById('idEliminar').value='<%=c.getIdCliente()%>'">
                        <i class="fas fa-trash-alt"></i>
                    </button>

                <% } else { %>
                    <span class="badge bg-secondary">Solo lectura</span>
                <% } %>
                </td>
            </tr>

            <% }} %>
            </tbody>
        </table>
    </div>
</div>


<!-- ============================= -->
<!-- 🟢 MODAL REGISTRAR CLIENTE -->
<!-- ============================= -->
<% if(esAdmin){ %>
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="ClienteController" method="POST">
            <input type="hidden" name="op" value="insertar">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-user-plus"></i> Registrar Cliente</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <input class="form-control mb-2" name="dni" placeholder="DNI" required>
                <input class="form-control mb-2" name="nombres" placeholder="Nombres" required>
                <input class="form-control mb-2" name="apellidos" placeholder="Apellidos" required>
                <input class="form-control mb-2" name="telefono" placeholder="Teléfono">
                <input class="form-control mb-2" type="email" name="email" placeholder="Correo">
                <input class="form-control mb-2" name="direccion" placeholder="Dirección">

            </div>

            <div class="modal-footer">
                <button class="btn btn-success">Guardar</button>
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>

        </form>
    </div>
</div>
<% } %>


<!-- ============================= -->
<!-- 🔶 MODAL EDITAR CLIENTE -->
<!-- ============================= -->
<div class="modal fade" id="modalEditar" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="ClienteController" method="POST">
            <input type="hidden" name="op" value="actualizar">
            <input type="hidden" name="id" id="edit_id">

            <div class="modal-header bg-warning">
                <h5 class="modal-title"><i class="fas fa-edit"></i> Editar Cliente</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <input id="edit_dni" class="form-control mb-2" name="dni" required>
                <input id="edit_nombres" class="form-control mb-2" name="nombres" required>
                <input id="edit_apellidos" class="form-control mb-2" name="apellidos" required>
                <input id="edit_telefono" class="form-control mb-2" name="telefono">
                <input type="email" id="edit_email" class="form-control mb-2" name="email">
                <input id="edit_direccion" class="form-control mb-2" name="direccion">

            </div>

            <div class="modal-footer">
                <button class="btn btn-warning">Actualizar</button>
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </form>
    </div>
</div>


<!-- ============================= -->
<!-- 🔴 MODAL ELIMINAR CLIENTE -->
<!-- ============================= -->
<div class="modal fade" id="modalEliminar" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="ClienteController" method="GET">
            <input type="hidden" name="op" value="eliminar">
            <input type="hidden" name="id" id="idEliminar">

            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle"></i> ¿Eliminar Cliente?</h5>
            </div>

            <div class="modal-body text-center">
                <b>Esta acción no se puede deshacer</b>
            </div>

            <div class="modal-footer">
                <button class="btn btn-danger">Eliminar</button>
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </form>
    </div>
</div>


<script>
function cargarDatos(id,dni,nom,ape,tel,email,dir){
    edit_id.value = id;
    edit_dni.value = dni;
    edit_nombres.value = nom;
    edit_apellidos.value = ape;
    edit_telefono.value = tel;
    edit_email.value = email;
    edit_direccion.value = dir;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
