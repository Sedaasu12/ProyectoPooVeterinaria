<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String currentUrl = request.getRequestURI();
String contextPath = request.getContextPath();
String nombreUsuario = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);

// Si no hay sesión se redirige al login
if(nombreUsuario == null){
    response.sendRedirect(contextPath + "/LoginController");
    return;
}
%>

<nav class="navbar navbar-expand-lg navbar-dark" style="background:#007aff;">
    <div class="container-fluid">

        <!-- Marca -->
        <a class="navbar-brand fw-bold" href="<%=contextPath%>/inicio.jsp">
            <i class="fas fa-paw"></i> Veterinaria
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-expanded="false">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- MENU PRINCIPAL -->
            <ul class="navbar-nav me-auto">

                <li class="nav-item">
                    <a class="nav-link <%=currentUrl.contains("inicio.jsp")?"active":""%>" 
                       href="<%=contextPath%>/inicio.jsp">
                       <i class="fas fa-home"></i> Inicio
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%=currentUrl.contains("ClienteController")?"active":""%>" 
                       href="<%=contextPath%>/ClienteController?op=listar">
                       <i class="fas fa-user"></i> Clientes
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%=currentUrl.contains("MascotaController")?"active":""%>" 
                       href="<%=contextPath%>/MascotaController?op=listar">
                       <i class="fas fa-dog"></i> Mascotas
                    </a>
                </li>

                <li class="Nav-item">
                    <a class="nav-link <%=currentUrl.contains("ServicioController")?"active":""%>" 
                       href="<%=contextPath%>/ServicioController?op=listar">
                       <i class="fas fa-stethoscope"></i> Servicios
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%=currentUrl.contains("CitaController")?"active":""%>" 
                       href="<%=contextPath%>/CitaController?op=listar">
                       <i class="fas fa-calendar-check"></i> Citas
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link <%=currentUrl.contains("AtencionController")?"active":""%>" 
                       href="<%=contextPath%>/AtencionController?op=listar">
                       <i class="fas fa-syringe"></i> Atención Clínica
                    </a>
                </li>

                <!-- ADMINISTRACIÓN -->
                <% if(esAdmin){ %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle <%=currentUrl.contains("UsuariosController")?"active":""%>"
                       data-bs-toggle="dropdown">
                       <i class="fas fa-cog"></i> Administración
                    </a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="dropdown-item" href="<%=contextPath%>/UsuariosController?op=listar">
                                <i class="fas fa-users-cog"></i> Usuarios
                            </a>
                            
                            <a class="dropdown-item" href="<%=contextPath%>/VeterinarioController?op=listar">
                                <i class="fas fa-users-cog"></i> Veterinarios
                            </a>
                        </li>
                    </ul>
                </li>
                <% } %>
            </ul>

            <!-- USUARIO -->
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="fas fa-user-circle"></i> <%=nombreUsuario%>
                        <% if(esAdmin){ %><span class="badge bg-warning text-dark">Admin</span><% } %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">

                        <li class="dropdown-header fw-bold">
                            <i class="fa fa-user"></i> <%=rol%>
                        </li>

                        <!-- 🔑 CAMBIAR CONTRASEÑA (NUEVO) -->
                        <li>
                            <a class="dropdown-item" href="<%=contextPath%>/CambiarPasswordController?op=form">
                                <i class="fas fa-key"></i> Cambiar Contraseña
                            </a>
                        </li>

                        <li><hr class="dropdown-divider"></li>

                        <!-- Cerrar sesión -->
                        <li>
                            <a class="dropdown-item text-danger" href="<%=contextPath%>/LoginController?accion=logout">
                                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                            </a>
                        </li>

                    </ul>
                </li>
            </ul>

        </div>
    </div>
</nav>

<style>
.nav-link.active{ background:rgba(255,255,255,.25);border-radius:6px;}
.navbar-brand{font-size:1.35rem;}
.nav-link:hover{background:rgba(255,255,255,.18);border-radius:6px;}
</style>
