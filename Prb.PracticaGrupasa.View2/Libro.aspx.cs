using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Prb.PracticaGrupasa.View2
{
    public partial class Libro : System.Web.UI.Page
    {
        private static readonly HttpClient httpClient = new HttpClient();
        private static readonly string apiUrl = ConfigurationManager.AppSettings["ApiBaseUrl"];
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<LibroDto> GetLibros()
        {
            var response = httpClient.GetAsync(apiUrl).Result;
            response.EnsureSuccessStatusCode();
            return response.Content.ReadAsAsync<List<LibroDto>>().Result;
        }
        [WebMethod]
        public static LibroDto GetidLibro(Guid id)
        {
            var response = httpClient.GetAsync($"{apiUrl}/{id}").Result;
            response.EnsureSuccessStatusCode();
            return response.Content.ReadAsAsync<LibroDto>().Result;
        }
        [WebMethod]
        public static void PostLibro(LibroDto libroDto)
        {
            libroDto.id = Guid.Empty;
            var response = httpClient.PostAsJsonAsync(apiUrl, libroDto).Result;
            response.EnsureSuccessStatusCode();
        }
        [WebMethod]
        public static void PutLibro(LibroDto libroDto)
        {
            var response = httpClient.PutAsJsonAsync($"{apiUrl}/{libroDto.id}", libroDto).Result;
            response.EnsureSuccessStatusCode();
        }
        [WebMethod]
        public static void DeleteLibro(Guid id)
        {
            var response = httpClient.DeleteAsync($"{apiUrl}/{id}").Result;
            response.EnsureSuccessStatusCode();
        }
    }
    public class LibroDto
    {
        public Guid id { get; set; }
        public string Titulo { get; set; }
        public string Autor { get; set; }   
    }
}