<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="beans.Cita, beans.Mascota, beans.Servicio"%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Citas</title>

<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body class="bg-light">

<div class="container mt-4">

    <h2 class="text-center mb-4">Gestión de Citas</h2>

    <!-- ================== BUSCADOR ================== -->
    <form action="CitaController" method="get" class="d-flex mb-3">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por mascota, cliente, servicio o fecha...">
        <button class="btn btn-primary">Buscar</button>
    </form>

    <!-- BOTÓN MODAL REGISTRAR -->
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        Registrar Cita
    </button>

    <!-- ============ TABLA DE CITAS ============ -->
    <table class="table table-striped table-bordered text-center">
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
            <td><%= c.getIdCita() %></td>
            <td><%= c.getMascota() %></td>
            <td><%= c.getCliente() %></td>
            <td><%= c.getServicio() %></td>
            <td><%= c.getFecha() %></td>
            <td><%= c.getHora() %></td>

            <td>
                <% if(c.getEstado().equals("Pendiente")){ %>
                    <span class="badge bg-warning text-dark">Pendiente</span>
                <% } else if(c.getEstado().equals("Atendida")){ %>
                    <span class="badge bg-success">Atendida</span>
                <% } else { %>
                    <span class="badge bg-secondary"><%= c.getEstado() %></span>
                <% } %>
            </td>

            <td>
                <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditar<%=c.getIdCita()%>">Editar</button>
                <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#modalEliminar<%=c.getIdCita()%>">Eliminar</button>
            </td>
        </tr>

        <!-- ================= MODAL EDITAR ================= -->
        <div class="modal fade" id="modalEditar<%=c.getIdCita()%>" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Editar Cita</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <form action="CitaController" method="post">
                        <input type="hidden" name="op" value="actualizar">
                        <input type="hidden" name="idCita" value="<%=c.getIdCita()%>">
                        
                        <div class="modal-body row g-3">
                            
                            <div class="col-md-6">
                                <label>Mascota:</label>
                                <select name="idMascota" class="form-select" required>
                                    <% for(Mascota m : mascotas){ %>
                                        <option value="<%=m.getIdMascota()%>" <%=m.getIdMascota()==c.getIdMascota()?"selected":""%>>
                                            <%=m.getNombre()%> - <%=m.getClienteNombre()%>
                                        </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Servicio:</label>
                                <select name="idServicio" class="form-select" required>
                                    <% for(Servicio s : servicios){ %>
                                        <option value="<%=s.getIdServicio()%>" <%=s.getIdServicio()==c.getIdServicio()?"selected":""%>>
                                            <%=s.getNombreServicio()%>
                                        </option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Fecha:</label>
                                <input type="date" name="fecha" class="form-control" value="<%=c.getFecha()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Hora:</label>
                                <input type="time" name="hora" class="form-control" value="<%=c.getHora()%>" required>
                            </div>

                            <div class="col-md-6">
                                <label>Estado:</label>
                                <select name="estado" class="form-select">
                                    <option value="Pendiente" <%=c.getEstado().equals("Pendiente")?"selected":""%>>Pendiente</option>
                                    <option value="Atendida" <%=c.getEstado().equals("Atendida")?"selected":""%>>Atendida</option>
                                    <option value="Cancelada" <%=c.getEstado().equals("Cancelada")?"selected":""%>>Cancelada</option>
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

        <!-- ================= MODAL ELIMINAR ================= -->
        <div class="modal fade" id="modalEliminar<%=c.getIdCita()%>" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">

                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title">Eliminar Cita</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        ¿Deseas eliminar la cita de <b><%=c.getMascota()%></b>?
                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <a class="btn btn-danger" href="CitaController?op=eliminar&id=<%=c.getIdCita()%>">Eliminar</a>
                    </div>

                </div>
            </div>
        </div>

        <%  } } %>
        </tbody>
    </table>
</div>

<!-- ================= MODAL REGISTRAR ================= -->
<div class="modal fade" id="modalRegistrar" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header bg-success text-white">
                <h5 class="modal-title">Registrar Cita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="CitaController" method="post">
                <input type="hidden" name="op" value="insertar">

                <div class="modal-body row g-3">

                    <div class="col-md-6">
                        <label>Mascota:</label>
                        <select name="idMascota" class="form-select" required>
                            <option value="">Seleccione una mascota</option>
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
                            <option value="">Seleccione un servicio</option>
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

                    <div class="col-md-6">
                        <label>Estado:</label>
                        <select name="estado" class="form-select">
                            <option value="Pendiente">Pendiente</option>
                            <option value="Atendida">Atendida</option>
                            <option value="Cancelada">Cancelada</option>
                        </select>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-success">Registrar</button>
                </div>

            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
