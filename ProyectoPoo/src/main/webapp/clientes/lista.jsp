<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, beans.cliente" %>

<!DOCTYPE html>
<html>
<head>
    <title>Clientes - Veterinaria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container py-4">

    <h2 class="mb-3 text-center">Gestión de Clientes</h2>

    <!-- BUSCADOR -->
    <form class="d-flex mb-3" action="ClienteController" method="GET">
        <input type="hidden" name="op" value="buscar">
        <input name="buscar" class="form-control me-2" placeholder="Buscar por DNI o Nombre...">
        <button class="btn btn-primary">Buscar</button>
    </form>

    <!-- BOTÓN NUEVO -->
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        Nuevo Cliente
    </button>

    <!-- TABLA -->
    <div class="table-responsive">
        <table class="table table-striped table-bordered align-middle">
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
                    <!-- BOTÓN EDITAR -->
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
                        Editar
                    </button>

                    <!-- BOTÓN ELIMINAR -->
                    <button class="btn btn-danger btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#modalEliminar"
                            onclick="document.getElementById('idEliminar').value='<%=c.getIdCliente()%>'">
                        Eliminar
                    </button>
                </td>
            </tr>

            <%      }
                }
            %>

            </tbody>
        </table>
    </div>
</div>


<!-- ========================================================= -->
<!-- MODAL REGISTRAR CLIENTE -->
<!-- ========================================================= -->
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="ClienteController" method="POST">
            <input type="hidden" name="op" value="insertar">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Registrar Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <div class="mb-2">
                    <label>DNI</label>
                    <input type="text" name="dni" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Nombres</label>
                    <input type="text" name="nombres" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Apellidos</label>
                    <input type="text" name="apellidos" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Teléfono</label>
                    <input type="text" name="telefono" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Email</label>
                    <input type="email" name="email" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Dirección</label>
                    <input type="text" name="direccion" class="form-control">
                </div>

            </div>

            <div class="modal-footer">
                <button class="btn btn-success">Guardar</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>

        </form>
    </div>
</div>


<!-- ========================================================= -->
<!-- MODAL EDITAR CLIENTE -->
<!-- ========================================================= -->
<div class="modal fade" id="modalEditar" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="ClienteController" method="POST">
            <input type="hidden" name="op" value="actualizar">
            <input type="hidden" name="id" id="edit_id">

            <div class="modal-header bg-warning">
                <h5 class="modal-title">Editar Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <div class="mb-2">
                    <label>DNI</label>
                    <input type="text" id="edit_dni" name="dni" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Nombres</label>
                    <input type="text" id="edit_nombres" name="nombres" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Apellidos</label>
                    <input type="text" id="edit_apellidos" name="apellidos" class="form-control" required>
                </div>

                <div class="mb-2">
                    <label>Teléfono</label>
                    <input type="text" id="edit_telefono" name="telefono" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Email</label>
                    <input type="email" id="edit_email" name="email" class="form-control">
                </div>

                <div class="mb-2">
                    <label>Dirección</label>
                    <input type="text" id="edit_direccion" name="direccion" class="form-control">
                </div>

            </div>

            <div class="modal-footer">
                <button class="btn btn-warning">Actualizar</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>

        </form>
    </div>
</div>


<!-- ========================================================= -->
<!-- MODAL ELIMINAR -->
<!-- ========================================================= -->
<div class="modal fade" id="modalEliminar" tabindex="-1">
    <div class="modal-dialog">
        <form class="modal-content" action="ClienteController" method="GET">
            <input type="hidden" name="op" value="eliminar">
            <input type="hidden" name="id" id="idEliminar">

            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">¿Eliminar Cliente?</h5>
            </div>

            <div class="modal-body">
                <p>Esta acción no se puede deshacer.</p>
            </div>

            <div class="modal-footer">
                <button class="btn btn-danger">Eliminar</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            </div>

        </form>
    </div>
</div>

<script>
    function cargarDatos(id, dni, nom, ape, tel, email, dir) {
        document.getElementById('edit_id').value = id;
        document.getElementById('edit_dni').value = dni;
        document.getElementById('edit_nombres').value = nom;
        document.getElementById('edit_apellidos').value = ape;
        document.getElementById('edit_telefono').value = tel;
        document.getElementById('edit_email').value = email;
        document.getElementById('edit_direccion').value = dir;
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
