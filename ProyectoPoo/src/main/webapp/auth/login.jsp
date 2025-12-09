<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
      rel="stylesheet">
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Iniciar Sesión - Veterinaria</title>

<style>
    body {
        background: linear-gradient(135deg,#5ac8fa,#007aff); /* tonos veterinaria*/
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .login-container { max-width: 450px;width:100%; }
    .login-card { background:white;border-radius:15px;box-shadow:0 10px 25px rgba(0,0,0,.2);overflow:hidden; }

    .login-header {
        background: linear-gradient(135deg,#5ac8fa,#007aff);
        color:white;text-align:center;padding:25px;
    }
    .login-header i { font-size:3.2rem;margin-bottom:5px; }

    .login-body { padding:40px; }
    .btn-login { background:#007aff;border:none;padding:12px;font-weight:600;transition:.2s; }
    .btn-login:hover { transform:scale(1.03); }

    .input-group-text{ background-color:#eef3ff;border-right:none;font-size:1.2rem; }
    .form-control{ border-left:none; }
</style>
</head>
<body>

<div class="login-container">
    <div class="login-card">

        <div class="login-header">
            <i class="fas fa-paw"></i>
            <h3 class="mb-0 fw-bold">Centro Veterinario Canino & Felino</h3>
            <p class="mt-1 text-light">Gestión administrativa</p>
        </div>

        <div class="login-body">

            <!-- MENSAJE ERROR -->
            <%
            String error = (String) request.getAttribute("error");
            if(error != null){
            %>
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fa fa-exclamation-circle"></i> <%=error%>
                <button class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% } %>

            <!-- FORMULARIO -->
            <form action="<%=url%>LoginController" method="POST" id="formLogin">
                <input type="hidden" name="accion" value="login">

                <label class="form-label fw-semibold">Usuario</label>
                <div class="input-group mb-3">
                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                    <input type="text" name="usuario" class="form-control" placeholder="Ingrese usuario" required>
                </div>

                <label class="form-label fw-semibold">Contraseña</label>
                <div class="input-group mb-4">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    <input type="password" name="password" id="password" class="form-control" placeholder="Ingrese contraseña" required>
                    <button type="button" class="btn btn-outline-secondary" id="togglePassword"><i class="fa fa-eye"></i></button>
                </div>

                <button type="submit" class="btn btn-login text-white w-100">
                    <i class="fa fa-sign-in-alt"></i> Iniciar Sesión
                </button>
            </form>

            <div class="mt-4 text-center text-muted">
                <small><i class="fa fa-info-circle"></i> Demo → usuario: <b>admin</b> | clave: <b>admin123</b></small>
            </div>
        </div>
    </div>

    <div class="text-center mt-3 text-white">
        <small>🐾 Veterinaria 2025 — Sistema de Gestión</small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Ver contraseña
document.getElementById("togglePassword").onclick = function(){
    const p = document.getElementById("password");
    const icon = this.querySelector("i");
    p.type = p.type === "password" ? "text" : "password";
    icon.classList.toggle("fa-eye-slash");
};
</script>
</body>
</html>
