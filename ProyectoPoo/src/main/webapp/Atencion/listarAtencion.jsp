<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, beans.Atencion, beans.Mascota, beans.Servicio" %>

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
    <title>Atenciones - Veterinaria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
</head>

<body class="bg-light">

<!-- 🔵 NAVBAR -->
<jsp:include page="/components/navbar.jsp"/>

<div class="container py-4">

    <h2 class="text-center mb-4">
        <i class="fas fa-stethoscope"></i> Gestión de Atenciones
    </h2>

    <!-- 🔍 BUSCADOR -->
    <form class="d-flex mb-3" action="AtencionController" method="GET">
        <input type="hidden" name="op" value="buscar">
        <input type="text" name="buscar" class="form-control me-2 shadow-sm" placeholder="Buscar mascota / cliente / servicio / diagnóstico...">
        <button class="btn btn-primary"><i class="fas fa-search"></i> Buscar</button>
    </form>

    <!-- SOLO ADMIN PUEDE REGISTRAR -->
    <% if(esAdmin){ %>
    <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">
        <i class="fas fa-plus-circle"></i> Nueva Atención
    </button>
    <% } %>

    <!-- 📄 TABLA -->
    <div class="table-responsive shadow-sm">
        <table class="table table-striped table-bordered text-center align-middle">
            <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Mascota</th>
                <th>Cliente</th>
                <th>Servicio</th>
                <th>Fecha Atención</th>
                <th>Diagnóstico</th>
                <th>Opciones</th>
            </tr>
            </thead>
            <tbody>

            <%
                List<Atencion> lista = (List<Atencion>) request.getAttribute("listaAtenciones");
                List<Mascota> mascotas = (List<Mascota>) request.getAttribute("listaMascotas");
                List<Servicio> servicios = (List<Servicio>) request.getAttribute("listaServicios");

                if(lista!=null){
                    for(Atencion a: lista){
            %>

            <tr>
                <td><%=a.getIdAtencion()%></td>
                <td><%=a.getMascota()%></td>
                <td><%=a.getCliente()%></td>
                <td><%=a.getServicio()%></td>
                <td><%=a.getFechaAtencion()%></td>
                <td><%= (a.getDiagnostico()!=null) ? a.getDiagnostico().substring(0, Math.min(40,a.getDiagnostico().length())) + (a.getDiagnostico().length()>40?"...":"") : "" %></td>

                <td>

                <% if(esAdmin){ %>
                    <button class="btn btn-warning btn-sm"
                        data-bs-toggle="modal" data-bs-target="#modalEditar<%=a.getIdAtencion()%>">
                        ✏ Editar
                    </button>

                    <button class="btn btn-danger btn-sm"
                        data-bs-toggle="modal" data-bs-target="#modalEliminar<%=a.getIdAtencion()%>">
                        🗑 Eliminar
                    </button>
                <% } else { %>
                    <span class="badge bg-secondary">Solo lectura</span>
                <% } %>
                </td>
            </tr>

            <!-- MODAL EDITAR -->
            <div class="modal fade" id="modalEditar<%=a.getIdAtencion()%>">
                <div class="modal-dialog modal-lg">
                <form class="modal-content" action="AtencionController" method="POST">

                    <input type="hidden" name="op" value="actualizar">
                    <input type="hidden" name="idAtencion" value="<%=a.getIdAtencion()%>">

                    <div class="modal-header bg-warning">
                        <h5 class="modal-title">Editar Atención</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body row g-3">

                        <div class="col-md-6">
                            <label><b>Mascota:</b></label>
                            <select class="form-select" name="idMascota">
                                <% for(Mascota m: mascotas){ %>
                                    <option value="<%=m.getIdMascota()%>" <%=m.getIdMascota()==a.getIdMascota()?"selected":""%> >
                                        <%=m.getNombre()%> | <%=m.getClienteNombre()%>
                                    </option>
                                <% } %>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label><b>Servicio:</b></label>
                            <select class="form-select" name="idServicio">
                                <% for(Servicio s : servicios){ %>
                                    <option value="<%=s.getIdServicio()%>" <%=s.getNombreServicio().equals(a.getServicio())?"selected":""%>>
                                        <%=s.getNombreServicio()%>
                                    </option>
                                <% } %>
                            </select>
                        </div>

                        <div class="col-12">
                            <label>Diagnóstico:</label>
                            <textarea class="form-control" name="diagnostico"><%=a.getDiagnostico()%></textarea>
                        </div>

                        <div class="col-12">
                            <label>Tratamiento:</label>
                            <textarea class="form-control" name="tratamiento"><%=a.getTratamiento()%></textarea>
                        </div>

                        <div class="col-12">
                            <label>Receta:</label>
                            <textarea class="form-control" name="receta"><%=a.getReceta()%></textarea>
                        </div>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button class="btn btn-warning">Actualizar</button>
                    </div>

                </form>
                </div>
            </div>


            <!-- MODAL ELIMINAR -->
            <div class="modal fade" id="modalEliminar<%=a.getIdAtencion()%>">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">

                        <div class="modal-header bg-danger text-white">
                            <h5>Confirmar Eliminación</h5>
                        </div>

                        <div class="modal-body">
                            ¿Eliminar atención de <b><%=a.getMascota()%></b>?
                        </div>

                        <div class="modal-footer">
                            <a class="btn btn-danger" href="AtencionController?op=eliminar&id=<%=a.getIdAtencion()%>">Eliminar</a>
                            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>

                    </div>
                </div>
            </div>

            <% }} %>

            </tbody>
        </table>
    </div>
</div>


<!-- MODAL REGISTRAR -->
<% if(esAdmin){ %>
<div class="modal fade" id="modalRegistrar">
    <div class="modal-dialog modal-lg">
    <form class="modal-content" action="AtencionController" method="POST">

        <input type="hidden" name="op" value="insertar">

        <div class="modal-header bg-success text-white">
            <h5>Registrar Atención</h5>
            <button class="btn-close" data-bs-dismiss="modal"></button>
        </div>

        <div class="modal-body row g-3">

            <div class="col-md-6">
                <label><b>Mascota:</b></label>
                <select name="idMascota" class="form-select" required>
                    <% for(Mascota m: mascotas){ %>
                        <option value="<%=m.getIdMascota()%>"><%=m.getNombre()%> | <%=m.getClienteNombre()%></option>
                    <% } %>
                </select>
            </div>

            <div class="col-md-6">
                <label><b>Servicio:</b></label>
                <select name="idServicio" class="form-select" required>
                    <% for(Servicio s: servicios){ %>
                        <option value="<%=s.getIdServicio()%>"><%=s.getNombreServicio()%></option>
                    <% } %>
                </select>
            </div>

            <div class="col-12">
                <label>Diagnóstico:</label>
                <textarea class="form-control" name="diagnostico" required></textarea>
            </div>

            <div class="col-12">
                <label>Tratamiento:</label>
                <textarea class="form-control" name="tratamiento"></textarea>
            </div>

            <div class="col-12">
                <label>Receta:</label>
                <textarea class="form-control" name="receta"></textarea>
            </div>

        </div>

        <div class="modal-footer">
            <button class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            <button class="btn btn-success">Registrar</button>
        </div>

    </form>
    </div>
</div>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
