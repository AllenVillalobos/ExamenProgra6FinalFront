using ExamenProgra6FinalFront.Models;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Util;

namespace ExamenProgra6FinalFront.Views
{
    public partial class MenuPrincipal : System.Web.UI.Page
    {
        private readonly HttpClient httpClinet = new HttpClient();
        public void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                OptenerEstudiantes();
            }
        }
        public async void OptenerEstudiantes()
        {
            try
            {
                List<Estudiante> estudiantes = await ListarEstudiantes();
                if (estudiantes != null)
                {
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
        public void btnRefrescar_Click(object sender, EventArgs e)
        {
            OptenerEstudiantes();
            lblMensaje.Text = "";
        }
        public async void btnBuscar_Click(object sender, EventArgs e)
        {
            rfvBuscar.Enabled = true;
            cvBuscar.Enabled = true;
            rfvID.Enabled = false;
            cvID.Enabled = false;
            rfvIdentificacion.Enabled = false;
            rfvPrimerNombre.Enabled = false;
            rfvPrimerApellido.Enabled = false;
            rfvDireccion.Enabled = false;
            cvIdentificacion.Enabled = false;
            Page.Validate();
            if (!Page.IsValid)
            {
                lblMensaje.Text = "Por favor ingrese un ID válido para buscar.";
                return;
            }
            try
            {
                string urlTemplate = ConfigurationManager.AppSettings["BuscarEstudiantes"];
                string url = urlTemplate.Replace("{id}", txtBuscar.Text.Trim());
                var resultado = await httpClinet.GetAsync(url);
                if (resultado.IsSuccessStatusCode)
                {
                    var json = await resultado.Content.ReadAsStringAsync();
                    Estudiante estudiante = Newtonsoft.Json.JsonConvert.DeserializeObject<Estudiante>(json);
                    List<Estudiante> estudiantes = new List<Estudiante>();
                    estudiantes.Add(estudiante);
                    txtID.Text = estudiante.EstudianteID.ToString();
                    txtIdentificacion.Text = estudiante.Identificacion;
                    txtPrimerNombre.Text = estudiante.PrimerNombre;
                    txtSegundoNombre.Text = estudiante.SegundoNombre;
                    txtPrimerApellido.Text = estudiante.PrimerApellido;
                    txtSegundoApellido.Text = estudiante.SegundoApellido;
                    cFechaNecimiento.SelectedDate = Convert.ToDateTime(estudiante.FechaNacimiento);
                    txtDireccion.Text = estudiante.Direccion;

                    gvEstudiantes.DataSource = estudiantes;
                    gvEstudiantes.DataBind();
                    lblMensaje.Text = "Estudiante encontrado";
                    btnActualizar.Enabled = true;
                    btnEliminar.Enabled = true;
                }
                else
                {
                    Response.Redirect("~/Views/CrearEstudiante.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al buscar estudiante: " + ex.Message;

            }
        }
        public void gvEstudiantes_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedIndex = gvEstudiantes.SelectedIndex;
            GridViewRow selectedRow = gvEstudiantes.Rows[selectedIndex];
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


        public async void btnExcel_Click(object sender, EventArgs e)
        {
            try
            {
                List<Estudiante> estudiantes = await ListarEstudiantes();
                using (ExcelPackage excelPackage = new ExcelPackage())
                {
                    //Agregar hoja
                    var hoja = excelPackage.Workbook.Worksheets.Add("Lista de Estudiantes");
                    hoja.Cells[1, 1].Value = "Estudiante ID";
                    hoja.Cells[1, 2].Value = "Identificación";
                    hoja.Cells[1, 3].Value = "Nombre Completo";
                    hoja.Cells[1, 4].Value = "Fecha De Nacimiento";
                    hoja.Cells[1, 5].Value = "Edad";
                    hoja.Cells[1, 6].Value = "Dirección";
                    for (int i = 0; i < estudiantes.Count; i++)
                    {
                        hoja.Cells[i + 2, 1].Value = estudiantes[i].EstudianteID;
                        hoja.Cells[i + 2, 2].Value = estudiantes[i].Identificacion;
                        hoja.Cells[i + 2, 3].Value = estudiantes[i].PrimerNombre + " " + estudiantes[i].SegundoNombre + " " + estudiantes[i].PrimerApellido + " " + estudiantes[i].SegundoApellido;
                        hoja.Cells[i + 2, 4].Value = Convert.ToDateTime(estudiantes[i].FechaNacimiento).ToString("dd/MM/yyyy");
                        hoja.Cells[i + 2, 5].Value = estudiantes[i].Edad;
                        hoja.Cells[i + 2, 6].Value = estudiantes[i].Direccion;

                    }
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
        public async void btnActualizar_Click(object sender, EventArgs e)
        {
            rfvBuscar.Enabled = false;
            cvBuscar.Enabled = false;
            rfvID.Enabled = true;
            cvID.Enabled = true;
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
                string urlTemplate = ConfigurationManager.AppSettings["ModificarEstudiante"];
                string url = urlTemplate.Replace("{id}", txtID.Text);
                Estudiante estudiante = new Estudiante
                {
                    EstudianteID = Convert.ToInt32(txtID.Text),
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
                var jsonContent = Newtonsoft.Json.JsonConvert.SerializeObject(estudiante);
                var content = new StringContent(jsonContent, System.Text.Encoding.UTF8, "application/json");
                var resultado = await httpClinet.PutAsync(url, content);
                if (resultado.IsSuccessStatusCode)
                {
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

        public async void btnEliminar_Click(object sender, EventArgs e)
        {
            rfvBuscar.Enabled = false;
            cvBuscar.Enabled = false;
            rfvID.Enabled = true;
            cvID.Enabled = true;
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
                string urlTemplate = ConfigurationManager.AppSettings["EliminarEstudiante"];
                string url = urlTemplate.Replace("{id}", txtID.Text);
                var resultado = await httpClinet.DeleteAsync(url);
                if (resultado.IsSuccessStatusCode)
                {
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
    }
}