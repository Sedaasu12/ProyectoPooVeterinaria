<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String context = request.getContextPath() + "/";
String nombreCompleto = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<title>Inicio - Veterinaria</title>

<style>
.hero {
    background: linear-gradient(135deg,#00aaff,#0071e3);
    color:white;padding:60px 0;margin-bottom:45px;
}
.card-module{
    border:none;border-radius:15px;padding:25px;text-align:center;
    box-shadow:0 4px 10px rgba(0,0,0,.1);transition:.3s;height:100%;
}
.card-module:hover{transform:translateY(-6px);box-shadow:0 10px 18px rgba(0,0,0,.2);}
.card-module i{font-size:3rem;margin-bottom:15px;}
.module-clientes{color:#00c853;}
.module-mascotas{color:#ff9800;}
.module-servicios{color:#2962ff;}
.module-citas{color:#d500f9;}
.module-atencion{color:#00acc1;}
.module-usuarios{color:#ff1744;}
</style>
</head>
<body>

<!-- NAVBAR -->
<jsp:include page="/components/navbar.jsp"/>

<!-- HERO -->
<section class="hero">
<div class="container">
    <div class="row align-items-center">
        <div class="col-md-8">
            <h1 class="display-5 fw-bold">
                <i class="fas fa-paw"></i> Bienvenido <%=nombreCompleto%> 🐶🐱
            </h1>
            <p class="lead mt-2">Sistema de Gestión Veterinaria — Administración completa de clientes, mascotas, citas y servicios.</p>
        </div>
        <div class="col-md-4 text-end">
            <i class="fas fa-dog" style="font-size:8rem;opacity:.25;"></i>
        </div>
    </div>
</div>
</section>

<!-- MÓDULOS -->
<div class="container">

<h2 class="mb-4"><i class="fas fa-th-large"></i> Módulos del Sistema</h2>

<div class="row g-4">

    <!-- CLIENTES -->
    <div class="col-md-6 col-lg-4">
        <a href="<%=context%>ClienteController?op=listar" class="text-decoration-none text-dark">
            <div class="card-module">
                <i class="fas fa-user module-clientes"></i>
                <h4>Clientes</h4>
                <p class="text-muted">Administración de propietarios</p>
            </div>
        </a>
    </div>

    <!-- MASCOTAS -->
    <div class="col-md-6 col-lg-4">
        <a href="<%=context%>MascotaController?op=listar" class="text-decoration-none text-dark">
            <div class="card-module">
                <i class="fas fa-cat module-mascotas"></i>
                <h4>Mascotas</h4>
                <p class="text-muted">Registro y control de mascotas</p>
            </div>
        </a>
    </div>

    <!-- SERVICIOS -->
    <div class="col-md-6 col-lg-4">
        <a href="<%=context%>ServicioController?op=listar" class="text-decoration-none text-dark">
            <div class="card-module">
                <i class="fas fa-stethoscope module-servicios"></i>
                <h4>Servicios</h4>
                <p class="text-muted">Vacunas, cirugías, consultas</p>
            </div>
        </a>
    </div>

    <!-- CITAS -->
    <div class="col-md-6 col-lg-4">
        <a href="<%=context%>CitaController?op=listar" class="text-decoration-none text-dark">
            <div class="card-module">
                <i class="fas fa-calendar-check module-citas"></i>
                <h4>Citas Programadas</h4>
                <p class="text-muted">Agenda clínica y atención</p>
            </div>
        </a>
    </div>

    <!-- ATENCIÓN CLÍNICA -->
    <div class="col-md-6 col-lg-4">
        <a href="<%=context%>AtencionController?op=listar" class="text-decoration-none text-dark">
            <div class="card-module">
                <i class="fas fa-syringe module-atencion"></i>
                <h4>Atención Clínica</h4>
                <p class="text-muted">Historial médico del paciente</p>
            </div>
        </a>
    </div>

    <% if("ADMIN".equals(rol)){ %>
    <!-- USUARIOS (solo admin) -->
    <div class="col-md-6 col-lg-4">
        <a href="<%=context%>UsuariosController?op=listar" class="text-decoration-none text-dark">
            <div class="card-module">
                <i class="fas fa-user-shield module-usuarios"></i>
                <h4>Usuarios</h4>
                <p class="text-muted">Control de accesos y roles</p>
            </div>
        </a>
    </div>
    <% } %>

</div>
</div>

<!-- FOOTER -->
<footer class="py-4 mt-5 text-center bg-light">
    <p class="mb-0 text-muted">
        <i class="fas fa-paw"></i> Sistema Veterinaria © 2025 — Todos los derechos reservados
    </p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
