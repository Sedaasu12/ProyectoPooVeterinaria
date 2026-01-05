package beans;

public class Atencion {
	private int idAtencion;
    private int idCita;
    private String fechaAtencion; // yyyy-MM-dd HH:mm:ss
    private String diagnostico;
    private String tratamiento;
    private String receta;

    // Campos para mostrar en listas (JOIN)
    private int idMascota;
    private String mascota;
    private String cliente;
    private String servicio;
    
    private int idVeterinario;
    private String veterinario;
    private String estado;
	
    public Atencion() {
		super();
	}

	

	public Atencion(int idAtencion, int idCita, String fechaAtencion, String diagnostico, String tratamiento,
			String receta, int idMascota, String mascota, String cliente, String servicio, int idVeterinario,
			String veterinario, String estado) {
		super();
		this.idAtencion = idAtencion;
		this.idCita = idCita;
		this.fechaAtencion = fechaAtencion;
		this.diagnostico = diagnostico;
		this.tratamiento = tratamiento;
		this.receta = receta;
		this.idMascota = idMascota;
		this.mascota = mascota;
		this.cliente = cliente;
		this.servicio = servicio;
		this.idVeterinario = idVeterinario;
		this.veterinario = veterinario;
		this.estado = estado;
	}



	public int getIdVeterinario() {
		return idVeterinario;
	}



	public void setIdVeterinario(int idVeterinario) {
		this.idVeterinario = idVeterinario;
	}



	public String getVeterinario() {
		return veterinario;
	}



	public void setVeterinario(String veterinario) {
		this.veterinario = veterinario;
	}



	public String getEstado() {
		return estado;
	}



	public void setEstado(String estado) {
		this.estado = estado;
	}



	public int getIdAtencion() {
		return idAtencion;
	}

	public void setIdAtencion(int idAtencion) {
		this.idAtencion = idAtencion;
	}

	public int getIdCita() {
		return idCita;
	}

	public void setIdCita(int idCita) {
		this.idCita = idCita;
	}

	public String getFechaAtencion() {
		return fechaAtencion;
	}

	public void setFechaAtencion(String fechaAtencion) {
		this.fechaAtencion = fechaAtencion;
	}

	public String getDiagnostico() {
		return diagnostico;
	}

	public void setDiagnostico(String diagnostico) {
		this.diagnostico = diagnostico;
	}

	public String getTratamiento() {
		return tratamiento;
	}

	public void setTratamiento(String tratamiento) {
		this.tratamiento = tratamiento;
	}

	public String getReceta() {
		return receta;
	}

	public void setReceta(String receta) {
		this.receta = receta;
	}

	public int getIdMascota() {
		return idMascota;
	}

	public void setIdMascota(int idMascota) {
		this.idMascota = idMascota;
	}

	public String getMascota() {
		return mascota;
	}

	public void setMascota(String mascota) {
		this.mascota = mascota;
	}

	public String getCliente() {
		return cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public String getServicio() {
		return servicio;
	}

	public void setServicio(String servicio) {
		this.servicio = servicio;
	}
    
    
	

}
