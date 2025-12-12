using ExamenProgra6FinalFront.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenProgra6FinalFront.Views
{
    public partial class CrearEstudiante : System.Web.UI.Page
    {
        // HttpClient para enviar solicitudes al API
        private readonly HttpClient httpClient = new HttpClient();
        public void Page_Load(object sender, EventArgs e)
        {
        }

        /// <summary>
        /// Función para crear un nuevo estudiante
        /// Valida los campos obligatorios y envia una solicitud POST al API
        /// </summary>
        public async void btnCrear_Click(object sender, EventArgs e)
        {
            // Se activan las validaciones necesarias para crear un estudiante
            rfvIdentificacion.Enabled = true;
            rfvPrimerNombre.Enabled = true;
            rfvPrimerApellido.Enabled = true;
            rfvDireccion.Enabled = true;
            cvIdentificacion.Enabled = true;

            // Verifica si los datos ingresados cumplen las validaciones
            Page.Validate();

            if (!Page.IsValid)
            {
                // Mensaje cuando falta algún dato obligatorio
                lblMensaje.Text = "Por favor complete todos los campos obligatorios correctamente";
                return;
            }
            try
            {
                // Obtiene la URL del API desde el archivo de configuración
                string url = ConfigurationManager.AppSettings["CrearEstudiante"];

                // Se crea un nuevo objeto Estudiante con los datos del formulario
                Estudiante estudiante = new Estudiante
                {
                    Identificacion = txtIdentificacion.Text,
                    PrimerNombre = txtPrimerNombre.Text,
                    PrimerApellido = txtPrimerApellido.Text,
                    FechaNacimiento = cFechaNecimiento.SelectedDate,
                    Direccion = txtDireccion.Text
                };

                // Campos opcionales: se guardan vacíos si no se escribieron
                if (string.IsNullOrWhiteSpace(txtSegundoApellido.Text))
                {
                    estudiante.SegundoApellido = "";
                }
                else
                {
                    estudiante.SegundoApellido = txtSegundoApellido.Text;
                }
                if (string.IsNullOrWhiteSpace(txtSegundoNombre.Text))
                {
                    estudiante.SegundoNombre = "";
                }
                else
                {
                    estudiante.SegundoNombre = txtSegundoNombre.Text;
                }

                // Convierte el estudiante en JSON para enviarlo al API
                var json = Newtonsoft.Json.JsonConvert.SerializeObject(estudiante);
                var content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");

                // Envío de la solicitud POST al API
                var response = await httpClient.PostAsync(url, content);

                // Si el API responde correctamente
                if (response.IsSuccessStatusCode)
                {
                    lblMensaje.Text = "Estudiante creado exitosamente";

                    txtIdentificacion.Text = "";
                    txtPrimerNombre.Text = "";
                    txtSegundoNombre.Text = "";
                    txtPrimerApellido.Text = "";
                    txtSegundoApellido.Text = "";
                    cFechaNecimiento.SelectedDate = DateTime.Now;
                    txtDireccion.Text = "";
                }
                else
                {
                    // Si el API respondió pero con error
                    lblMensaje.Text = "Error al crear el estudiante";
                }
            }
            catch (Exception ex)
            {
                // Cualquier error inesperado se muestra aquí
                lblMensaje.Text = "Excepción: " + ex.Message;
            }
            finally
            {
                // Se desactivan las validaciones otra vez para evitar errores visuales
                rfvIdentificacion.Enabled = false;
                rfvPrimerNombre.Enabled = false;
                rfvPrimerApellido.Enabled = false;
                rfvDireccion.Enabled = false;
                cvIdentificacion.Enabled = false;
            }
        }

        /// <summary>
        /// Botón para volver al menú principal.
        /// Redirige a la página MenuPrincipal.aspx.
        /// </summary>
        public void btnVolver_Click(object sender, EventArgs e)
        {
            // Redirección a la página principal del sistema
            Response.Redirect("~/Views/MenuPrincipal.aspx");
        }
    }
}