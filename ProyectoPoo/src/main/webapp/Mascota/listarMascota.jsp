<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Mascota, beans.cliente" %>

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
    <title>Gestión de Mascotas</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<!-- 🔷 NAVBAR GLOBAL -->
<jsp:include page="/components/navbar.jsp"/>

<div class="container mt-4">

    <h2 class="mb-4 text-center">
        <i class="fas fa-paw"></i> Gestión de Mascotas
    </h2>

    <!-- 🔍 BUSCADOR -->
    <form action="MascotaController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por nombre, raza o dueño...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <!-- AGREGAR NUEVA MASCOTA 🌱 SOLO ADMIN -->
    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-plus-circle"></i> Registrar Mascota
    </button>
    <% } %>

    <!-- 📄 TABLA DE MASCOTAS -->
    <table class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Especie</th>
            <th>Raza</th>
            <th>Sexo</th>
            <th>F. Nacimiento</th>
            <th>Dueño</th>
            <th>Acciones</th>
        </tr>
        </thead>

        <tbody>
        <%
        List<Mascota> lista = (List<Mascota>) request.getAttribute("listaMascotas");
        List<cliente> clientes = (List<cliente>) request.getAttribute("listaClientes");

        if(lista != null){
            for(Mascota m : lista){
        %>
        <tr>
            <td><%=m.getIdMascota()%></td>
            <td><%=m.getNombre()%></td>
            <td><%=m.getEspecie()%></td>
            <td><%=m.getRaza()%></td>
            <td><%=m.getSexo()%></td>
            <td><%=m.getFechaNacimiento()%></td>
            <td><%=m.getClienteNombre()%></td>

            <td>
                <% if(esAdmin){ %>

                <!-- EDITAR -->
                <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEditar<%=m.getIdMascota()%>">
                    <i class="fas fa-edit"></i>
                </button>

                <!-- ELIMINAR -->
                <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEliminar<%=m.getIdMascota()%>">
                    <i class="fas fa-trash-alt"></i>
                </button>

                <% }else{ %>
                    <span class="badge bg-secondary">Solo lectura</span>
                <% } %>
            </td>
        </tr>

        <!-- 🔶 MODAL EDITAR -->
        <div class="modal fade" id="modalEditar<%=m.getIdMascota()%>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Editar Mascota</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="MascotaController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idMascota" value="<%=m.getIdMascota()%>">

                        <div class="modal-body row g-3">
                            <div class="col-md-6">
                                <label>Nombre:</label>
                                <input type="text" name="nombre" class="form-control" value="<%=m.getNombre()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Especie:</label>
                                <input type="text" name="especie" class="form-control" value="<%=m.getEspecie()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Raza:</label>
                                <input type="text" name="raza" class="form-control" value="<%=m.getRaza()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Sexo:</label>
                                <select name="sexo" class="form-select">
                                    <option <%=m.getSexo().equals("Macho")?"selected":""%>>Macho</option>
                                    <option <%=m.getSexo().equals("Hembra")?"selected":""%>>Hembra</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Fecha Nacimiento:</label>
                                <input type="date" name="fechaNacimiento" class="form-control"
                                       value="<%=m.getFechaNacimiento()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Dueño:</label>
                                <select name="idCliente" class="form-select">
                                    <% for(cliente c : clientes){ %>
                                    <option value="<%=c.getIdCliente()%>"
                                      <%= c.getIdCliente()==m.getIdCliente()?"selected":""%>>
                                        <%=c.getClienteNombre()%> <%=c.getClienteApellido()%>
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

        <!-- 🔴 MODAL ELIMINAR -->
        <div class="modal fade" id="modalEliminar<%=m.getIdMascota()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fas fa-trash"></i> Eliminar Mascota</h5>
                        <button class="btn-close"></button>
                    </div>

                    <div class="modal-body">
                        ¿Eliminar a <b><%=m.getNombre()%></b> definitivamente?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a class="btn btn-danger" href="MascotaController?op=eliminar&id=<%=m.getIdMascota()%>">Eliminar</a>
                    </div>

                </div>
            </div>
        </div>

        <% } } %>
        </tbody>
    </table>

</div>

<!-- 🟢 MODAL REGISTRAR -->
<% if(esAdmin){ %>
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-plus"></i> Registrar Nueva Mascota</h5>
                <button class="btn-close"></button>
            </div>

            <form action="MascotaController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-6"><input placeholder="Nombre" name="nombre" class="form-control" required></div>
                    <div class="col-md-6"><input placeholder="Especie" name="especie" class="form-control" required></div>
                    <div class="col-md-6"><input placeholder="Raza" name="raza" class="form-control" required></div>

                    <div class="col-md-6">
                        <select name="sexo" class="form-select" required>
                            <option value="">Sexo</option><option>Macho</option><option>Hembra</option>
                        </select>
                    </div>

                    <div class="col-md-6"><input type="date" name="fechaNacimiento" class="form-control" required></div>

                    <div class="col-md-6">
                        <select name="idCliente" class="form-select" required>
                            <option value="">Seleccione dueño</option>
                            <% if(clientes!=null){ for(cliente c:clientes){ %>
                            <option value="<%=c.getIdCliente()%>"><%=c.getClienteNombre()%> <%=c.getClienteApellido()%></option>
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
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
