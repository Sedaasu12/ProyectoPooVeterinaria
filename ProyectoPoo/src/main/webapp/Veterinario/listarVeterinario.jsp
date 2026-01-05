<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, beans.Veterinario, beans.Usuario"%>

<%
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);

if (session.getAttribute("usuario") == null) {
	response.sendRedirect(request.getContextPath() + "/LoginController");
	return;
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Gestión de Veterinarios</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-light">

	<!-- NAVBAR -->
	<jsp:include page="/components/navbar.jsp" />

	<div class="container mt-4">

		<h2 class="mb-4 text-center">
			<i class="fas fa-user-md"></i> Gestión de Veterinarios
		</h2>

		<!-- BUSCADOR -->
		<form action="VeterinarioController" method="get" class="d-flex mb-3">
			<input type="hidden" name="op" value="buscar"> <input
				type="text" name="buscar" class="form-control me-2"
				placeholder="Buscar por nombre, apellido, DNI o especialidad">
			<button class="btn btn-primary">
				<i class="fas fa-search"></i> Buscar
			</button>
		</form>

		<!-- NUEVO -->
		<%
		if (esAdmin) {
		%>
		<button class="btn btn-success mb-3" data-bs-toggle="modal"
			data-bs-target="#modalRegistrar">
			<i class="fas fa-plus-circle"></i> Nuevo Veterinario
		</button>
		<%
		}
		%>

		<!-- TABLA -->
		<table class="table table-bordered table-striped text-center">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>Nombres</th>
					<th>Apellidos</th>
					<th>DNI</th>
					<th>Especialidad</th>
					<th>Teléfono</th>
					<th>Estado</th>
					<th>Acciones</th>
				</tr>
			</thead>

			<tbody>
				<%
				List<Veterinario> lista = (List<Veterinario>) request.getAttribute("listaVeterinarios");
				if (lista != null && !lista.isEmpty()) {
					for (Veterinario v : lista) {
				%>
				<tr>
					<td><%=v.getIdVeterinario()%></td>
					<td><%=v.getNombres()%></td>
					<td><%=v.getApellidos()%></td>
					<td><%=v.getDni()%></td>
					<td><%=v.getEspecialidad()%></td>
					<td><%=v.getTelefono()%></td>
					<td><span
						class="badge <%=v.getEstado().equals("ACTIVO") ? "bg-success" : "bg-secondary"%>">
							<%=v.getEstado()%>
					</span></td>

					<td>
						<%
						if (esAdmin) {
						%> <!-- EDITAR -->
						<button class="btn btn-warning btn-sm" data-bs-toggle="modal"
							data-bs-target="#modalEditar<%=v.getIdVeterinario()%>">
							<i class="fas fa-edit"></i>
						</button> <%
 if ("ACTIVO".equals(v.getEstado())) {
 %> <!-- DESACTIVAR --> <a class="btn btn-danger btn-sm"
						href="VeterinarioController?op=desactivar&id=<%=v.getIdVeterinario()%>">
							<i class="fas fa-user-slash"></i>
					</a> <%
 } else {
 %> <!-- ACTIVAR --> <a class="btn btn-success btn-sm"
						href="VeterinarioController?op=activar&id=<%=v.getIdVeterinario()%>">
							<i class="fas fa-user-check"></i>
					</a> <%
 }
 %> <%
 } else {
 %> <span class="badge bg-secondary">Solo lectura</span> <%
 }
 %>
					</td>
				</tr>

				<!-- MODAL EDITAR -->
				<div class="modal fade" id="modalEditar<%=v.getIdVeterinario()%>"
					tabindex="-1">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header bg-warning">
								<h5 class="modal-title">
									<i class="fas fa-edit"></i> Editar Veterinario
								</h5>
								<button class="btn-close" data-bs-dismiss="modal"></button>
							</div>

							<form action="VeterinarioController" method="post">
								<input type="hidden" name="op" value="actualizar"> <input
									type="hidden" name="idVeterinario"
									value="<%=v.getIdVeterinario()%>">

								<div class="modal-body row g-3">
									<div class="col-md-6">
										<label>Nombres</label> <input type="text" name="nombres"
											class="form-control" value="<%=v.getNombres()%>" required>
									</div>

									<div class="col-md-6">
										<label>Apellidos</label> <input type="text" name="apellidos"
											class="form-control" value="<%=v.getApellidos()%>" required>
									</div>

									<div class="col-md-6">
										<label>DNI</label> <input type="text" name="dni"
											class="form-control" value="<%=v.getDni()%>" required>
									</div>

									<div class="col-md-6">
										<label>Teléfono</label> <input type="text" name="telefono"
											class="form-control" value="<%=v.getTelefono()%>">


										<div class="col-md-12">
											<label>Especialidad</label> <input type="text"
												name="especialidad" class="form-control"
												value="<%=v.getEspecialidad()%>">
										</div>
									</div>

									<div class="modal-footer">
										<button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
										<button class="btn btn-warning">Actualizar</button>
									</div>
							</form>
						</div>
					</div>
				</div>

				<%
				}
				} else {
				%>
				<tr>
					<td colspan="8" class="text-center">No hay veterinarios
						registrados</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<!-- MODAL REGISTRAR -->
	<%
	if (esAdmin) {
	%>
	<div class="modal fade" id="modalRegistrar" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<div class="modal-header bg-success text-white">
					<h5 class="modal-title">
						<i class="fas fa-plus"></i> Registrar Veterinario
					</h5>
					<button class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<form action="VeterinarioController" method="post">
					<input type="hidden" name="op" value="insertar">

					<div class="modal-body row g-3">

						<!-- SELECT USUARIO -->
						<div class="col-md-12">
							<label>Usuario</label> <select name="idUsuario"
								class="form-select" required>
								<option value="">Seleccione usuario</option>
								<%
								List<Usuario> usuarios = (List<Usuario>) request.getAttribute("listaUsuarios");
								if (usuarios != null) {
									for (Usuario u : usuarios) {
								%>
								<option value="<%=u.getIdUsuario()%>">
									<%=u.getNombreUsuario()%>
								</option>
								<%
								}
								}
								%>
							</select>
						</div>

						<div class="col-md-6">
							<label>Nombres</label> <input type="text" name="nombres"
								class="form-control" required>
						</div>

						<div class="col-md-6">
							<label>Apellidos</label> <input type="text" name="apellidos"
								class="form-control" required>
						</div>

						<div class="col-md-6">
							<label>DNI</label> <input type="text" name="dni"
								class="form-control" required>
						</div>

						<div class="col-md-6">
							<label>Teléfono</label> <input type="text" name="telefono"
								class="form-control">
						</div>

						<div class="col-md-12">
							<label>Especialidad</label> <input type="text"
								name="especialidad" class="form-control">
						</div>

					</div>

					<div class="modal-footer">
						<button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
						<button class="btn btn-success">Registrar</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
