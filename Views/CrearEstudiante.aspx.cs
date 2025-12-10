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
        private readonly HttpClient httpClient = new HttpClient();
        public void Page_Load(object sender, EventArgs e)
        {
        }
        public async void btnCrear_Click(object sender, EventArgs e)
        {
            rfvIdentificacion.Enabled = true;
            rfvPrimerNombre.Enabled = true;
            rfvPrimerApellido.Enabled = true;
            rfvDireccion.Enabled = true;
            cvIdentificacion.Enabled = true;

            Page.Validate();

            if (!Page.IsValid)
            {
                lblMensaje.Text = "Por favor complete todos los campos obligatorios correctamente";
                return;
            }
            try
            {
                string url = ConfigurationManager.AppSettings["CrearEstudiante"];
                Estudiante estudiante = new Estudiante
                {
                    Identificacion = txtIdentificacion.Text,
                    PrimerNombre = txtPrimerNombre.Text,
                    PrimerApellido = txtPrimerApellido.Text,
                    FechaNacimiento = cFechaNecimiento.SelectedDate,
                    Direccion = txtDireccion.Text
                };

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


                var json = Newtonsoft.Json.JsonConvert.SerializeObject(estudiante);
                var content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");
                var response = await httpClient.PostAsync(url, content);
                if (response.IsSuccessStatusCode)
                {
                    lblMensaje.Text = "Estudiante creado exitosamente";
                }
                else
                {
                    lblMensaje.Text = "Error al crear el estudiante";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Excepción: " + ex.Message;
            }
            finally
            {
                rfvIdentificacion.Enabled = false;
                rfvPrimerNombre.Enabled = false;
                rfvPrimerApellido.Enabled = false;
                rfvDireccion.Enabled = false;
                cvIdentificacion.Enabled = false;
            }
        }
        public void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/MenuPrincipal.aspx");
        }

    }
}