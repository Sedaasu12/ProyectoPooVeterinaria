package beans;

public class Servicio {
	private int idServicio;
    private String nombreServicio;
    private String descripcion;
    private double precio;
	
    public Servicio() {
		super();
	}

	public Servicio(int idServicio, String nombreServicio, String descripcion, double precio) {
		super();
		this.idServicio = idServicio;
		this.nombreServicio = nombreServicio;
		this.descripcion = descripcion;
		this.precio = precio;
	}

	public int getIdServicio() {
		return idServicio;
	}

	public void setIdServicio(int idServicio) {
		this.idServicio = idServicio;
	}

	public String getNombreServicio() {
		return nombreServicio;
	}

	public void setNombreServicio(String nombreServicio) {
		this.nombreServicio = nombreServicio;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public double getPrecio() {
		return precio;
	}

	public void setPrecio(double precio) {
		this.precio = precio;
	}
    
    

}
