<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect(request.getContextPath() + "/LoginController");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Cambiar Contraseña</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
.input-group-text {
    cursor: pointer;
}
</style>

</head>

<body class="bg-light">

<jsp:include page="/components/navbar.jsp" />

<div class="container mt-4">

    <h2 class="text-center fw-bold mb-4">
        🔐 Cambiar Contraseña
    </h2>

    <!-- Mensajes -->
    <% if(request.getAttribute("error") != null){ %>
        <div class="alert alert-danger"><%=request.getAttribute("error")%></div>
    <% } %>

    <% if(request.getAttribute("success") != null){ %>
        <div class="alert alert-success"><%=request.getAttribute("success")%></div>
    <% } %>

    <div class="card shadow-sm">
        <div class="card-body">

            <form action="CambiarPasswordController" method="POST">
                <input type="hidden" name="op" value="cambiar">

                <!-- CONTRASEÑA ACTUAL -->
                <div class="mb-3">
                    <label class="form-label">Contraseña Actual</label>
                    <div class="input-group">
                        <input type="password" id="passActual" class="form-control" name="passwordActual" required>
                        <span class="input-group-text" onclick="togglePass('passActual', this)">
                            <i class="fa-solid fa-eye"></i>
                        </span>
                    </div>
                </div>

                <!-- NUEVA CONTRASEÑA -->
                <div class="mb-3">
                    <label class="form-label">Nueva Contraseña</label>
                    <div class="input-group">
                        <input type="password" id="passNueva" class="form-control" name="passwordNueva" required>
                        <span class="input-group-text" onclick="togglePass('passNueva', this)">
                            <i class="fa-solid fa-eye"></i>
                        </span>
                    </div>
                </div>

                <!-- REPETIR -->
                <div class="mb-3">
                    <label class="form-label">Repetir Nueva Contraseña</label>
                    <div class="input-group">
                        <input type="password" id="passRepetir" class="form-control" name="passwordRepetir" required>
                        <span class="input-group-text" onclick="togglePass('passRepetir', this)">
                            <i class="fa-solid fa-eye"></i>
                        </span>
                    </div>
                </div>

                <button class="btn btn-primary">Actualizar Contraseña</button>
            </form>

        </div>
    </div>

</div>

<script>
// 👁️ Función para mostrar/ocultar contraseña
function togglePass(inputId, iconSpan){
    const input = document.getElementById(inputId);
    const icon = iconSpan.querySelector("i");

    if(input.type === "password"){
        input.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
    } else {
        input.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
    }
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
