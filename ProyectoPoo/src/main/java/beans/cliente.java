package beans;

public class cliente {
	private int idCliente;
    private String clienteDni;
    private String clienteNombre;
    private String clienteApellido;
    private String clienteTelefono;
    private String clienteEmail;
    private String clienteDireccion;
	
    public cliente() {
		super();
	}

	public cliente(int idCliente, String clienteDni, String clienteNombre, String clienteApellido,
			String clienteTelefono, String clienteEmail, String clienteDireccion) {
		super();
		this.idCliente = idCliente;
		this.clienteDni = clienteDni;
		this.clienteNombre = clienteNombre;
		this.clienteApellido = clienteApellido;
		this.clienteTelefono = clienteTelefono;
		this.clienteEmail = clienteEmail;
		this.clienteDireccion = clienteDireccion;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}

	public String getClienteDni() {
		return clienteDni;
	}

	public void setClienteDni(String clienteDni) {
		this.clienteDni = clienteDni;
	}

	public String getClienteNombre() {
		return clienteNombre;
	}

	public void setClienteNombre(String clienteNombre) {
		this.clienteNombre = clienteNombre;
	}

	public String getClienteApellido() {
		return clienteApellido;
	}

	public void setClienteApellido(String clienteApellido) {
		this.clienteApellido = clienteApellido;
	}

	public String getClienteTelefono() {
		return clienteTelefono;
	}

	public void setClienteTelefono(String clienteTelefono) {
		this.clienteTelefono = clienteTelefono;
	}

	public String getClienteEmail() {
		return clienteEmail;
	}

	public void setClienteEmail(String clienteEmail) {
		this.clienteEmail = clienteEmail;
	}

	public String getClienteDireccion() {
		return clienteDireccion;
	}

	public void setClienteDireccion(String clienteDireccion) {
		this.clienteDireccion = clienteDireccion;
	}
	

    

	
}
