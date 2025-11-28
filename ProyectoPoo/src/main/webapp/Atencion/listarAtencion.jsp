<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, beans.Atencion, beans.Mascota, beans.Servicio"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Atenciones</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-4">
  <h2>Registro de Atenciones</h2>

  <form action="AtencionController" method="get" class="d-flex mb-3">
      <input type="hidden" name="op" value="buscar">
      <input type="text" name="buscar" class="form-control me-2" placeholder="Buscar por mascota, cliente, servicio, fecha o diagnóstico...">
      <button class="btn btn-primary">Buscar</button>
  </form>

  <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#modalRegistrar">Nueva Atención</button>

  <table class="table table-striped table-bordered text-center">
    <thead class="table-dark">
      <tr>
        <th>ID</th><th>Mascota</th><th>Cliente</th><th>Servicio</th><th>Fecha atención</th><th>Diagnóstico</th><th>Acciones</th>
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
        <td><%= a.getIdAtencion() %></td>
        <td><%= a.getMascota() %></td>
        <td><%= a.getCliente() %></td>
        <td><%= a.getServicio() %></td>
        <td><%= a.getFechaAtencion() %></td>
        <td><%= a.getDiagnostico()!=null? a.getDiagnostico().substring(0, Math.min(40, a.getDiagnostico().length())) + (a.getDiagnostico().length()>40?"...":"") : "" %></td>
        <td>
          <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#modalEditar<%=a.getIdAtencion()%>">Editar</button>
          <button class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#modalEliminar<%=a.getIdAtencion()%>">Eliminar</button>
        </td>
      </tr>

      <!-- Modal Editar -->
      <div class="modal fade" id="modalEditar<%=a.getIdAtencion()%>" tabindex="-1">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">
            <form action="AtencionController" method="post">
              <input type="hidden" name="op" value="actualizar">
              <input type="hidden" name="idAtencion" value="<%=a.getIdAtencion()%>">

              <div class="modal-body row g-3">
                <div class="col-md-6">
                  <label>Mascota (Cita):</label>
                  <select name="idCita" class="form-select" required>
                    <%-- Si prefieres seleccionar por mascota, lista debes traer las citas disponibles con id y mascota --%>
                    <% for(Mascota m: mascotas){ %>
                      <option value="<%=m.getIdMascota()%>" <%= m.getIdMascota()==a.getIdMascota()?"selected":"" %>><%=m.getNombre()%></option>
                    <% } %>
                  </select>
                </div>

                <div class="col-md-6">
                  <label>Servicio:</label>
                  <select name="idServicio" class="form-select">
                    <% for(Servicio s: servicios){ %>
                      <option value="<%=s.getIdServicio()%>" <%= s.getNombreServicio().equals(a.getServicio())?"selected":"" %>><%=s.getNombreServicio()%></option>
                    <% } %>
                  </select>
                </div>

                <div class="col-md-12">
                  <label>Diagnóstico:</label>
                  <textarea name="diagnostico" class="form-control"><%= a.getDiagnostico() %></textarea>
                </div>

                <div class="col-md-12">
                  <label>Tratamiento:</label>
                  <textarea name="tratamiento" class="form-control"><%= a.getTratamiento() %></textarea>
                </div>

                <div class="col-md-12">
                  <label>Receta:</label>
                  <textarea name="receta" class="form-control"><%= a.getReceta() %></textarea>
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

      <!-- Modal Eliminar -->
      <div class="modal fade" id="modalEliminar<%=a.getIdAtencion()%>" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header bg-danger text-white"><h5>Eliminar Atención</h5><button class="btn-close" data-bs-dismiss="modal"></button></div>
            <div class="modal-body">¿Eliminar la atención de <b><%=a.getMascota()%></b>?</div>
            <div class="modal-footer">
              <a class="btn btn-danger" href="AtencionController?op=eliminar&id=<%=a.getIdAtencion()%>">Eliminar</a>
              <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            </div>
          </div>
        </div>
      </div>

      <%   }
        }
      %>
    </tbody>
  </table>
</div>

<!-- Modal Registrar -->
<div class="modal fade" id="modalRegistrar" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <form action="AtencionController" method="post">
        <input type="hidden" name="op" value="insertar">
        <div class="modal-body row g-3">
          <div class="col-md-6">
            <label>Cita (Mascota):</label>
            <%-- ideal traer lista de CITAS pendientes/confirmadas para asociar la atención --%>
            <select name="idCita" class="form-select" required>
              <option value="">Seleccione una cita</option>
              <%-- si no tienes lista de citas, puedes listar mascotas y luego elegir la cita por id --%>
              <% for(Mascota m: mascotas){ %>
                <option value="<%=m.getIdMascota()%>"><%=m.getNombre()%> - <%=m.getClienteNombre()%></option>
              <% } %>
            </select>
          </div>

          <div class="col-md-6">
            <label>Servicio:</label>
            <select name="idServicio" class="form-select" required>
              <option value="">Seleccione servicio</option>
              <% for(Servicio s: servicios){ %>
                <option value="<%=s.getIdServicio()%>"><%=s.getNombreServicio()%></option>
              <% } %>
            </select>
          </div>

          <div class="col-md-12">
            <label>Diagnóstico:</label>
            <textarea name="diagnostico" class="form-control" required></textarea>
          </div>

          <div class="col-md-12">
            <label>Tratamiento:</label>
            <textarea name="tratamiento" class="form-control"></textarea>
          </div>

          <div class="col-md-12">
            <label>Receta:</label>
            <textarea name="receta" class="form-control"></textarea>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
