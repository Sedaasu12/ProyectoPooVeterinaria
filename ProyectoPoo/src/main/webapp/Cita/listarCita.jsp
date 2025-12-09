<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Cita, beans.Mascota, beans.Servicio" %>

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
    <title>Gestión de Citas</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<body class="bg-light">

<!-- NAVBAR -->
<jsp:include page="/components/navbar.jsp"/>

<div class="container mt-4">

    <h2 class="mb-4 text-center">
        <i class="fas fa-calendar-check"></i> Gestión de Citas
    </h2>

    <!-- BUSCADOR -->
    <form action="CitaController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por mascota, cliente o servicio...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <!-- NUEVA CITA -->
    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-plus-circle"></i> Nueva Cita
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
            <th>Fecha</th>
            <th>Hora</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>

        <tbody>

        <%
        List<Cita> citas = (List<Cita>) request.getAttribute("listaCitas");
        List<Mascota> mascotas = (List<Mascota>) request.getAttribute("listaMascotas");
        List<Servicio> servicios = (List<Servicio>) request.getAttribute("listaServicios");

        if(citas != null){
            for(Cita c : citas){
        %>

        <tr>
            <td><%=c.getIdCita()%></td>
            <td><%=c.getMascota()%></td>
            <td><%=c.getCliente()%></td>
            <td><%=c.getServicio()%></td>
            <td><%=c.getFecha()%></td>
            <td><%=c.getHora()%></td>
            <td><%=c.getEstado()%></td>

            <td>
                <% if(esAdmin){ %>

                <!-- EDITAR -->
                <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEditar<%=c.getIdCita()%>">
                    <i class="fas fa-edit"></i>
                </button>

                <!-- ELIMINAR -->
                <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal"
                        data-bs-target="#modalEliminar<%=c.getIdCita()%>">
                    <i class="fas fa-trash-alt"></i>
                </button>

                <% }else{ %>
                    <span class="badge bg-secondary">Solo lectura</span>
                <% } %>
            </td>
        </tr>


        <!-- ------------------------ -->
        <!-- MODAL EDITAR (funciona) -->
        <!-- ------------------------ -->
        <div class="modal fade" id="modalEditar<%=c.getIdCita()%>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header bg-warning text-dark">
                        <h5 class="modal-title"><i class="fas fa-edit"></i> Editar Cita</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="CitaController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idCita" value="<%=c.getIdCita()%>">

                        <div class="modal-body row g-3">

                            <div class="col-md-6">
                                <label>Mascota:</label>
                                <select name="idMascota" class="form-select">
                                    <% for(Mascota m : mascotas){ %>
                                    <option value="<%=m.getIdMascota()%>"
                                        <%= m.getIdMascota()==c.getIdMascota()?"selected":"" %>>
                                        <%=m.getNombre()%> - <%=m.getClienteNombre()%>
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Servicio:</label>
                                <select name="idServicio" class="form-select">
                                    <% for(Servicio s : servicios){ %>
                                    <option value="<%=s.getIdServicio()%>"
                                        <%= s.getIdServicio()==c.getIdServicio()?"selected":"" %>>
                                        <%=s.getNombreServicio()%>
                                    </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Fecha:</label>
                                <input type="date" class="form-control" name="fecha" value="<%=c.getFecha()%>">
                            </div>

                            <div class="col-md-6">
                                <label>Hora:</label>
                                <input type="time" class="form-control" name="hora" value="<%=c.getHora()%>">
                            </div>

                            <div class="col-md-6">
                                <label>Estado:</label>
                                <select name="estado" class="form-select">
                                    <option <%=c.getEstado().equals("Pendiente")?"selected":""%>>Pendiente</option>
                                    <option <%=c.getEstado().equals("Atendida")?"selected":""%>>Atendida</option>
                                    <option <%=c.getEstado().equals("Cancelada")?"selected":""%>>Cancelada</option>
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


        <!-- ------------------------ -->
        <!-- MODAL ELIMINAR           -->
        <!-- ------------------------ -->
        <div class="modal fade" id="modalEliminar<%=c.getIdCita()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title"><i class="fas fa-trash"></i> Eliminar Cita</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        ¿Eliminar esta cita de <b><%=c.getMascota()%></b>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a class="btn btn-danger" href="CitaController?op=eliminar&id=<%=c.getIdCita()%>">Eliminar</a>
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
                <h5 class="modal-title"><i class="fas fa-plus"></i> Registrar Cita</h5>
                <button class="btn-close"></button>
            </div>

            <form action="CitaController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-6">
                        <label>Mascota:</label>
                        <select name="idMascota" class="form-select" required>
                            <option value="">Seleccione</option>
                            <% for(Mascota m : mascotas){ %>
                            <option value="<%=m.getIdMascota()%>">
                                <%=m.getNombre()%> - <%=m.getClienteNombre()%>
                            </option>
                            <% } %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label>Servicio:</label>
                        <select name="idServicio" class="form-select" required>
                            <option value="">Seleccione</option>
                            <% for(Servicio s : servicios){ %>
                            <option value="<%=s.getIdServicio()%>"><%=s.getNombreServicio()%></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label>Fecha:</label>
                        <input type="date" name="fecha" class="form-control" required>
                    </div>

                    <div class="col-md-6">
                        <label>Hora:</label>
                        <input type="time" name="hora" class="form-control" required>
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
