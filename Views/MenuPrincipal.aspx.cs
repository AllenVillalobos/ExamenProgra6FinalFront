using ExamenProgra6FinalFront.Models;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ExamenProgra6FinalFront.Views
{
    public partial class MenuPrincipal : System.Web.UI.Page
    {
        // Cliente HTTP para comunicarse con el API
        private readonly HttpClient httpClinet = new HttpClient();
        public void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                OptenerEstudiantes();
            }
        }
        /// <summary>
        /// Método que obtiene los estudiantes desde el API y los carga en el GridView.
        /// </summary>
        public async void OptenerEstudiantes()
        {
            try
            {
                List<Estudiante> estudiantes = await ListarEstudiantes();
                if (estudiantes != null)
                {
                    //Cargar los estudiantes en el GridView
                    gvEstudiantes.DataSource = estudiantes;
                    gvEstudiantes.DataBind();
                }
                else
                {
                    lblMensaje.Text = "No se encontraron estudiantes.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al listar estudiantes: " + ex.Message;
            }
        }


        /// <summary>
        /// Llama al API para traer la lista de estudiantes.
        /// Devuelve una lista o null si hubo error.
        /// </summary>
        public async Task<List<Estudiante>> ListarEstudiantes()
        {
            try
            {
                string url = ConfigurationManager.AppSettings["ListarEstudiantes"];
                var resultado = await httpClinet.GetAsync(url);
                if (resultado.IsSuccessStatusCode)
                {
                    var json = await resultado.Content.ReadAsStringAsync();
                    List<Estudiante> estudiantes = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Estudiante>>(json);
                    return estudiantes;
                }
                else
                {
                    lblMensaje.Text = "No se encontraron estudiantes.";
                    return null;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al listar estudiantes: " + ex.Message;
                return null;
            }
        }

        /// <summary>
        /// Refresca la lista de estudiantes y limpia el mensaje.
        /// </summary>
        public void btnRefrescar_Click(object sender, EventArgs e)
        {
            OptenerEstudiantes();
            lblMensaje.Text = "";
        }

        /// <summary>
        /// Busca un estudiante por ID y muestra sus datos.
        /// </summary>
        public async void btnBuscar_Click(object sender, EventArgs e)
        {
            // Se activan y desactivan validaciones según la acción
            rfvBuscar.Enabled = true;
            cvBuscar.Enabled = true;
            rfvID.Enabled = false;
            cvID.Enabled = false;
            rfvIdentificacion.Enabled = false;
            rfvPrimerNombre.Enabled = false;
            rfvPrimerApellido.Enabled = false;
            rfvDireccion.Enabled = false;
            cvIdentificacion.Enabled = false;

            // Verifica si los datos ingresados cumplen las validaciones
            Page.Validate();
            if (!Page.IsValid)
            {

                // Mensaje cuando falta algún dato obligatorio
                lblMensaje.Text = "Por favor ingrese un ID válido para buscar.";
                return;
            }
            try
            {

                // Se arma la URL remplazando {id}
                string urlTemplate = ConfigurationManager.AppSettings["BuscarEstudiantes"];
                string url = urlTemplate.Replace("{id}", txtBuscar.Text.Trim());

                var resultado = await httpClinet.GetAsync(url);
                if (resultado.IsSuccessStatusCode)
                {
                    // Se convierte la respuesta a objeto estudiante
                    var json = await resultado.Content.ReadAsStringAsync();
                    Estudiante estudiante = Newtonsoft.Json.JsonConvert.DeserializeObject<Estudiante>(json);
                    List<Estudiante> estudiantes = new List<Estudiante>();
                    estudiantes.Add(estudiante);

                    // Se llenan los campos con los datos del estudiante
                    txtID.Text = estudiante.EstudianteID.ToString();
                    txtIdentificacion.Text = estudiante.Identificacion;
                    txtPrimerNombre.Text = estudiante.PrimerNombre;
                    txtSegundoNombre.Text = estudiante.SegundoNombre;
                    txtPrimerApellido.Text = estudiante.PrimerApellido;
                    txtSegundoApellido.Text = estudiante.SegundoApellido;
                    cFechaNecimiento.SelectedDate = Convert.ToDateTime(estudiante.FechaNacimiento);
                    txtDireccion.Text = estudiante.Direccion;

                    // Se llena la tabla solo con este estudiante
                    gvEstudiantes.DataSource = estudiantes;
                    gvEstudiantes.DataBind();
                    lblMensaje.Text = "Estudiante encontrado";
                    btnActualizar.Enabled = true;
                    btnEliminar.Enabled = true;
                }
                else
                {
                    // Si no existe, se redirige a crear
                    Response.Redirect("~/Views/CrearEstudiante.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al buscar estudiante: " + ex.Message;

            }
        }

        /// <summary>
        /// Carga en los campos la fila seleccionada del GridView.
        /// </summary>
        public void gvEstudiantes_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Fila seleccionada
            int selectedIndex = gvEstudiantes.SelectedIndex;
            GridViewRow selectedRow = gvEstudiantes.Rows[selectedIndex];

            // Se obtienen los valores de las celdas
            txtID.Text = Server.HtmlDecode(selectedRow.Cells[0].Text);
            txtIdentificacion.Text = Server.HtmlDecode(selectedRow.Cells[1].Text);
            txtPrimerNombre.Text = Server.HtmlDecode(selectedRow.Cells[2].Text);
            txtSegundoNombre.Text = Server.HtmlDecode(selectedRow.Cells[3].Text);
            txtPrimerApellido.Text = Server.HtmlDecode(selectedRow.Cells[4].Text);
            txtSegundoApellido.Text = Server.HtmlDecode(selectedRow.Cells[5].Text);
            cFechaNecimiento.SelectedDate = Convert.ToDateTime(Server.HtmlDecode(selectedRow.Cells[6].Text));
            txtDireccion.Text = selectedRow.Cells[7].Text;
            btnActualizar.Enabled = true;
            btnEliminar.Enabled = true;
        }

        /// <summary>
        /// Genera un archivo PDF con los datos de los estudiantes.
        /// </summary>
        public async void btnPDF_Click(object sender, EventArgs e)
        {
            try
            {
                string ruta = Server.MapPath("~/Reportes/ListaEstudiantes.pdf");
                List<Estudiante> estudiantes = await ListarEstudiantes();
                using (var writter = new PdfWriter(ruta))
                {
                    using (var pdf = new PdfDocument(writter))
                    {
                        var documento = new Document(pdf);
                        documento.Add(new Paragraph("Lista de Estudiantes"));
                        documento.Add(new Paragraph("-----------------------------------------------------------------"));

                        // Se agregan los datos
                        foreach (Estudiante estudiante in estudiantes)
                        {
                            documento.Add(new Paragraph("Estudiante ID: " + estudiante.EstudianteID));
                            documento.Add(new Paragraph(""));
                            documento.Add(new Paragraph("Identificación: " + estudiante.Identificacion));
                            documento.Add(new Paragraph(""));
                            documento.Add(new Paragraph("Nombre Completo: " + estudiante.PrimerNombre + " " + estudiante.SegundoNombre + " " + estudiante.PrimerApellido + " " + estudiante.SegundoApellido));
                            documento.Add(new Paragraph(""));
                            documento.Add(new Paragraph("Fecha De Nacimiento: " + Convert.ToDateTime(estudiante.FechaNacimiento).ToString("dd/MM/yyyy")));
                            documento.Add(new Paragraph(""));
                            documento.Add(new Paragraph("Edad: " + estudiante.Edad));
                            documento.Add(new Paragraph(""));
                            documento.Add(new Paragraph("Dirección: " + estudiante.Direccion));
                            documento.Add(new Paragraph("-----------------------------------------------------------------"));
                            documento.Add(new Paragraph("-----------------------------------------------------------------"));
                        }
                        documento.Close();
                    }
                }
                // Se envía el PDF generado al usuario
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=ListaEstudiantes.pdf");
                Response.TransmitFile(ruta);
                Response.End();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al generar el archivo PDF: " + ex.Message;
            }
        }

        /// <summary>
        /// Genera un archivo Excel con los estudiantes.
        /// </summary>
        public async void btnExcel_Click(object sender, EventArgs e)
        {
            try
            {
                List<Estudiante> estudiantes = await ListarEstudiantes();
                using (ExcelPackage excelPackage = new ExcelPackage())
                {

                    //Agregar hoja
                    var hoja = excelPackage.Workbook.Worksheets.Add("Lista de Estudiantes");

                    // Encabezados del archivo
                    hoja.Cells[1, 1].Value = "Estudiante ID";
                    hoja.Cells[1, 2].Value = "Identificación";
                    hoja.Cells[1, 3].Value = "Nombre Completo";
                    hoja.Cells[1, 4].Value = "Fecha De Nacimiento";
                    hoja.Cells[1, 5].Value = "Edad";
                    hoja.Cells[1, 6].Value = "Dirección";

                    // Se agregan los datos
                    for (int i = 0; i < estudiantes.Count; i++)
                    {
                        hoja.Cells[i + 2, 1].Value = estudiantes[i].EstudianteID;
                        hoja.Cells[i + 2, 2].Value = estudiantes[i].Identificacion;
                        hoja.Cells[i + 2, 3].Value = estudiantes[i].PrimerNombre + " " + estudiantes[i].SegundoNombre + " " + estudiantes[i].PrimerApellido + " " + estudiantes[i].SegundoApellido;
                        hoja.Cells[i + 2, 4].Value = Convert.ToDateTime(estudiantes[i].FechaNacimiento).ToString("dd/MM/yyyy");
                        hoja.Cells[i + 2, 5].Value = estudiantes[i].Edad;
                        hoja.Cells[i + 2, 6].Value = estudiantes[i].Direccion;

                    }

                    // Se envía el archivo al usuario
                    Response.Clear();
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment; filename=ListaEstudiantes.xlsx");

                    using (var memoryStream = new MemoryStream())
                    {
                        excelPackage.SaveAs(memoryStream);
                        memoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al generar el archivo Excel: " + ex.Message;
            }
        }

        /// <summary>
        /// Actualiza un estudiante usando los datos del formulario.
        /// </summary>
        public async void btnActualizar_Click(object sender, EventArgs e)
        {
            // Se activan las validaciones necesarias para actualizar
            rfvBuscar.Enabled = false;
            cvBuscar.Enabled = false;
            rfvID.Enabled = true;
            cvID.Enabled = true;
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

                // Se arma la URL reemplazando el ID
                string urlTemplate = ConfigurationManager.AppSettings["ModificarEstudiante"];
                string url = urlTemplate.Replace("{id}", txtID.Text);

                // Se crea el objeto estudiante con los datos del formulario
                Estudiante estudiante = new Estudiante
                {
                    EstudianteID = Convert.ToInt32(txtID.Text),
                    Identificacion = txtIdentificacion.Text,
                    PrimerNombre = txtPrimerNombre.Text,
                    PrimerApellido = txtPrimerApellido.Text,
                    FechaNacimiento = cFechaNecimiento.SelectedDate,
                    Direccion = txtDireccion.Text
                };

                // Campos opcionales. Se asignan valores vacíos si no se ingresó nada
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


                var jsonContent = Newtonsoft.Json.JsonConvert.SerializeObject(estudiante);
                var content = new StringContent(jsonContent, System.Text.Encoding.UTF8, "application/json");

                // Se envía la actualización al API
                var resultado = await httpClinet.PutAsync(url, content);
                if (resultado.IsSuccessStatusCode)
                {
                    // Se refresca la lista
                    OptenerEstudiantes();
                    lblMensaje.Text = "Se actualizo con exito al estudiante";
                }
                else
                {
                    lblMensaje.Text = "No se pudo actualizar el estudiante";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al actualizar estudiante: " + ex.Message;
            }
            finally
            {
                // Se limpian los campos y se deshabilitan botones
                btnActualizar.Enabled = false;
                btnEliminar.Enabled = false;
                txtID.Text = "";
                txtIdentificacion.Text = "";
                txtPrimerNombre.Text = "";
                txtSegundoNombre.Text = "";
                txtPrimerApellido.Text = "";
                txtSegundoApellido.Text = "";
                cFechaNecimiento.SelectedDate = DateTime.Now;
                txtDireccion.Text = "";

            }
        }

        /// <summary>
        /// Elimina un estudiante usando su ID.
        /// </summary>
        public async void btnEliminar_Click(object sender, EventArgs e)
        {
            // Se activan las validaciones necesarias para eliminar
            rfvBuscar.Enabled = false;
            cvBuscar.Enabled = false;
            rfvID.Enabled = true;
            cvID.Enabled = true;
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
                // Se arma la URL reemplazando {id}
                string urlTemplate = ConfigurationManager.AppSettings["EliminarEstudiante"];
                string url = urlTemplate.Replace("{id}", txtID.Text);

                // Se envía la solicitud de eliminación al API
                var resultado = await httpClinet.DeleteAsync(url);
                if (resultado.IsSuccessStatusCode)
                {
                    // Se refresca la lista
                    lblMensaje.Text = "Se Elimino con exito al estudiante";
                    OptenerEstudiantes();

                }
                else
                {
                    lblMensaje.Text = "No se pudo eliminar el estudiante";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al eliminar estudiante: " + ex.Message;
            }
            finally
            {
                // Se limpian los campos y se deshabilitan botones
                btnActualizar.Enabled = false;
                btnEliminar.Enabled = false;
                txtID.Text = "";
                txtIdentificacion.Text = "";
                txtPrimerNombre.Text = "";
                txtSegundoNombre.Text = "";
                txtPrimerApellido.Text = "";
                txtSegundoApellido.Text = "";
                cFechaNecimiento.SelectedDate = DateTime.Now;
                txtDireccion.Text = "";

            }
        }

        /// <summary>
        /// Limpia todos los campos visuales del formulario.
        /// </summary>
        public void btnLimpiar_Click(object sender, EventArgs e)
        {
            // Limpieza general del formulario
            txtBuscar.Text = "";
            txtID.Text = "";
            txtIdentificacion.Text = "";
            txtPrimerNombre.Text = "";
            txtSegundoNombre.Text = "";
            txtPrimerApellido.Text = "";
            txtSegundoApellido.Text = "";
            cFechaNecimiento.SelectedDate = DateTime.Now;
            txtDireccion.Text = "";
            lblMensaje.Text = "";

            // Recarga los estudiantes en el Grid
            OptenerEstudiantes();
        }


        /// <summary>
        /// Redirige a la vista de crear estudiante
        /// </summary>
        public void btnCrear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/CrearEstudiante.aspx");
        }
    }
}