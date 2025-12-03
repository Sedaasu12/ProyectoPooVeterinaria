<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, beans.Cita, beans.Mascota, beans.Servicio" %>

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
<title>Citas - Veterinaria</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
.badge{font-size:.75rem}
.table td{vertical-align:middle}
</style>
</head>

<body class="bg-light">

<!-- 🔷 NAVBAR -->
<jsp:include page="/components/navbar.jsp" />

<div class="container py-4">

<h2 class="text-center fw-bold mb-4">
    <i class="fas fa-calendar-check"></i> Gestión de Citas
</h2>

<!-- 🔍 BUSCADOR -->
<form action="CitaController" method="GET" class="d-flex mb-3">
    <input type="hidden" name="op" value="buscar">
    <input name="buscar" class="form-control me-2" placeholder="Buscar por mascota / cliente / servicio...">
    <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
</form>

<!-- Botón registrar solo ADMIN -->
<% if(esAdmin){ %>
<button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
    <i class="fas fa-plus-circle"></i> Nueva Cita
</button>
<% } %>

<!-- ================= TABLA ================= -->
<div class="table-responsive shadow-sm">
<table class="table table-bordered table-hover text-center">
<thead class="table-dark">
<tr>
    <th>ID</th>
    <th>Mascota</th>
    <th>Cliente</th>
    <th>Servicio</th>
    <th>Fecha</th>
    <th>Hora</th>
    <th>Estado</th>
    <th>Opciones</th>
</tr>
</thead>

<tbody>

<%
List<Cita> citas = (List<Cita>) request.getAttribute("listaCitas");
List<Mascota> mascotas = (List<Mascota>) request.getAttribute("listaMascotas");
List<Servicio> servicios = (List<Servicio>) request.getAttribute("listaServicios");

if(citas != null && !citas.isEmpty()){
    for(Cita c : citas){
%>

<tr>
    <td><%=c.getIdCita()%></td>
    <td><%=c.getMascota()%></td>
    <td><%=c.getCliente()%></td>
    <td><%=c.getServicio()%></td>
    <td><%=c.getFecha()%></td>
    <td><%=c.getHora()%></td>

    <td>
        <% if(c.getEstado().equals("Pendiente")){ %>
            <span class="badge bg-warning text-dark">Pendiente</span>
        <% } else if(c.getEstado().equals("Atendida")){ %>
            <span class="badge bg-success">Atendida</span>
        <% } else { %>
            <span class="badge bg-secondary"><%=c.getEstado()%></span>
        <% } %>
    </td>

    <td>
    <% if(esAdmin){ %>
        <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditar<%=c.getIdCita()%>">
            ✏ Editar
        </button>

        <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#modalEliminar<%=c.getIdCita()%>">
            🗑 Eliminar
        </button>
    <% } else { %>
        <span class="badge bg-secondary">Solo lectura</span>
    <% } %>
    </td>
</tr>


<!-- ================= MODAL EDITAR ================= -->
<div class="modal fade" id="modalEditar<%=c.getIdCita()%>">
<div class="modal-dialog modal-lg">
<form class="modal-content" action="CitaController" method="POST">

    <input type="hidden" name="op" value="actualizar">
    <input type="hidden" name="idCita" value="<%=c.getIdCita()%>">

    <div class="modal-header bg-warning">
        <h5 class="modal-title">Editar Cita</h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
    </div>

    <div class="modal-body row g-3">

        <div class="col-md-6">
            <label><b>Mascota</b></label>
            <select name="idMascota" class="form-select">
                <% for(Mascota m : mascotas){ %>
                    <option value="<%=m.getIdMascota()%>" <%=m.getIdMascota()==c.getIdMascota()?"selected":""%> >
                        <%=m.getNombre()%> - <%=m.getClienteNombre()%>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="col-md-6">
            <label><b>Servicio</b></label>
            <select name="idServicio" class="form-select">
                <% for(Servicio s : servicios){ %>
                    <option value="<%=s.getIdServicio()%>" <%=s.getIdServicio()==c.getIdServicio()?"selected":""%> >
                        <%=s.getNombreServicio()%>
                    </option>
                <% } %>
            </select>
        </div>

        <div class="col-md-6">
            <label><b>Fecha</b></label>
            <input type="date" name="fecha" class="form-control" value="<%=c.getFecha()%>">
        </div>

        <div class="col-md-6">
            <label><b>Hora</b></label>
            <input type="time" name="hora" class="form-control" value="<%=c.getHora()%>">
        </div>

        <div class="col-md-6">
            <label><b>Estado</b></label>
            <select name="estado" class="form-select">
                <option <%=c.getEstado().equals("Pendiente")?"selected":""%>>Pendiente</option>
                <option <%=c.getEstado().equals("Atendida")?"selected":""%>>Atendida</option>
                <option <%=c.getEstado().equals("Cancelada")?"selected":""%>>Cancelada</option>
            </select>
        </div>
    </div>

    <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
        <button class="btn btn-warning">Actualizar</button>
    </div>

</form>
</div>
</div>


<!-- ================= MODAL ELIMINAR ================= -->
<div class="modal fade" id="modalEliminar<%=c.getIdCita()%>">
<div class="modal-dialog modal-sm">
<div class="modal-content">

    <div class="modal-header bg-danger text-white">
        <h5 class="modal-title">Eliminar</h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
    </div>

    <div class="modal-body text-center">
        ¿Eliminar cita de <b><%=c.getMascota()%></b>?
    </div>

    <div class="modal-footer">
        <a class="btn btn-danger" href="CitaController?op=eliminar&id=<%=c.getIdCita()%>">Eliminar</a>
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
    </div>

</div>
</div>
</div>

<% } } else { %>
<tr><td colspan="8" class="text-muted">No hay registros disponibles</td></tr>
<% } %>

</tbody>
</table>
</div>
</div>


<!-- ================= MODAL REGISTRAR ================= -->
<% if(esAdmin){ %>
<div class="modal fade" id="modalRegistrar">
<div class="modal-dialog modal-lg">
<form class="modal-content" action="CitaController" method="POST">

    <input type="hidden" name="op" value="insertar">

    <div class="modal-header bg-success text-white">
        <h5 class="modal-title">Registrar Cita</h5>
        <button class="btn-close" data-bs-dismiss="modal"></button>
    </div>

    <div class="modal-body row g-3">

        <div class="col-md-6">
            <label><b>Mascota</b></label>
            <select name="idMascota" class="form-select" required>
                <option value="">Seleccione</option>
                <% for(Mascota m : mascotas){ %>
                <option value="<%=m.getIdMascota()%>"><%=m.getNombre()%> - <%=m.getClienteNombre()%></option>
                <% } %>
            </select>
        </div>

        <div class="col-md-6">
            <label><b>Servicio</b></label>
            <select name="idServicio" class="form-select" required>
                <option value="">Seleccione</option>
                <% for(Servicio s : servicios){ %>
                <option value="<%=s.getIdServicio()%>"><%=s.getNombreServicio()%></option>
                <% } %>
            </select>
        </div>

        <div class="col-md-6">
            <label><b>Fecha</b></label>
            <input type="date" name="fecha" class="form-control" required>
        </div>

        <div class="col-md-6">
            <label><b>Hora</b></label>
            <input type="time" name="hora" class="form-control" required>
        </div>

        <div class="col-md-6">
            <label><b>Estado</b></label>
            <select name="estado" class="form-select">
                <option>Pendiente</option>
                <option>Atendida</option>
                <option>Cancelada</option>
            </select>
        </div>

    </div>

    <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
        <button class="btn btn-success">Registrar</button>
    </div>

</form>
</div>
</div>
<% } %>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
