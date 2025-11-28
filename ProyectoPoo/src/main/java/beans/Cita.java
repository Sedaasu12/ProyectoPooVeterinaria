package beans;

public class Cita {
	private int idCita;
    private String fecha;
    private String hora;
    private String estado;

    private int idMascota;
    private int idServicio;

    // Datos enlazados
    private String mascota;
    private String cliente;
    private String servicio;
	
    public Cita() {
		super();
	}

	public Cita(int idCita, String fecha, String hora, String estado, int idMascota, int idServicio, String mascota,
			String cliente, String servicio) {
		super();
		this.idCita = idCita;
		this.fecha = fecha;
		this.hora = hora;
		this.estado = estado;
		this.idMascota = idMascota;
		this.idServicio = idServicio;
		this.mascota = mascota;
		this.cliente = cliente;
		this.servicio = servicio;
	}

	public int getIdCita() {
		return idCita;
	}

	public void setIdCita(int idCita) {
		this.idCita = idCita;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getIdMascota() {
		return idMascota;
	}

	public void setIdMascota(int idMascota) {
		this.idMascota = idMascota;
	}

	public int getIdServicio() {
		return idServicio;
	}

	public void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
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
