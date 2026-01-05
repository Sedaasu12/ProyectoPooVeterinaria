package beans;

import java.sql.Timestamp;

public class Veterinario {
	 private int idVeterinario;
	    private int idUsuario;
	    private String nombres;
	    private String apellidos;
	    private String dni;
	    private String telefono;
	    private String email;
	    private String especialidad;
	    private String estado;
	    private Timestamp fechaRegistro;
		
	    public Veterinario() {
			super();
		}

		

		public Veterinario(int idVeterinario, int idUsuario, String nombres, String apellidos, String dni,
				String telefono, String email, String especialidad, String estado, Timestamp fechaRegistro) {
			super();
			this.idVeterinario = idVeterinario;
			this.idUsuario = idUsuario;
			this.nombres = nombres;
			this.apellidos = apellidos;
			this.dni = dni;
			this.telefono = telefono;
			this.email = email;
			this.especialidad = especialidad;
			this.estado = estado;
			this.fechaRegistro = fechaRegistro;
		}



		public int getIdVeterinario() {
			return idVeterinario;
		}

		public void setIdVeterinario(int idVeterinario) {
			this.idVeterinario = idVeterinario;
		}

		public int getIdUsuario() {
			return idUsuario;
		}

		public void setIdUsuario(int idUsuario) {
			this.idUsuario = idUsuario;
		}

		public String getNombres() {
			return nombres;
		}

		public void setNombres(String nombres) {
			this.nombres = nombres;
		}

		public String getApellidos() {
			return apellidos;
		}

		public void setApellidos(String apellidos) {
			this.apellidos = apellidos;
		}

		public String getDni() {
			return dni;
		}

		public void setDni(String dni) {
			this.dni = dni;
		}

		public String getTelefono() {
			return telefono;
		}

		public void setTelefono(String telefono) {
			this.telefono = telefono;
		}

		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getEspecialidad() {
			return especialidad;
		}

		public void setEspecialidad(String especialidad) {
			this.especialidad = especialidad;
		}

		public String getEstado() {
			return estado;
		}

		public void setEstado(String estado) {
			this.estado = estado;
		}

		public Timestamp getFechaRegistro() {
			return fechaRegistro;
		}

		public void setFechaRegistro(Timestamp fechaRegistro) {
			this.fechaRegistro = fechaRegistro;
		}
	    
	    

}
