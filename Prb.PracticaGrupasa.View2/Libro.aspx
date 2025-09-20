<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Libro.aspx.cs" Inherits="Prb.PracticaGrupasa.View2.Libro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    
    <title>Libros</title>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
      <h1>Libros</h1>

    <div>
        <h3>Crear / Editar Libro</h3>
        <input type="hidden" id="libroId" />
        <label>Título: </label><input type="text" id="titulo" /><br/>
        <label>Autor: </label><input type="text" id="autor" /><br/>
        <button onclick="guardarLibro()">Guardar</button>
    </div>

    <hr/>

    <div id="librosContainer"></div>
    <script type="text/javascript">
        // Cargar todos los libros
        function cargarLibros() {
            $.ajax({
                type: "POST",
                url: "Libro.aspx/GetLibros",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var libros = response.d;
                    var html = "<table border='1'><tr><th>Título</th><th>Autor</th><th>Acciones</th></tr>";
                    for (var i = 0; i < libros.length; i++) {
                        html += "<tr>";
                        html += "<td>" + libros[i].Titulo + "</td>";
                        html += "<td>" + libros[i].Autor + "</td>";
                        html += "<td>" +
                            "<button onclick='editarLibro(\"" + libros[i].id + "\")'>Editar</button> " +
                            "<button onclick='eliminarLibro(\"" + libros[i].id + "\")'>Eliminar</button>" +
                            "</td>";
                        html += "</tr>";
                    }
                    html += "</table>";
                    $("#librosContainer").html(html);
                }
            });
        }

        // Guardar libro (crear o editar)
        function guardarLibro() {
            var libro = {
                id: $("#libroId").val(),
                Titulo: $("#titulo").val(),
                Autor: $("#autor").val()
            };

            var url = libro.id ? "Libro.aspx/PutLibro" : "Libro.aspx/PostLibro";
            
            $.ajax({
                type: "POST",
                url: url,
                data: JSON.stringify({ libroDto: libro }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    $("#libroId").val("");
                    $("#titulo").val("");
                    $("#autor").val("");
                    cargarLibros();
                }
            });
        }

        // Editar libro (cargar datos en el formulario)
        function editarLibro(id) {
            $.ajax({
                type: "POST",
                url: "Libro.aspx/GetidLibro",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (libro) {
                    $("#libroId").val(libro.d.id);
                    $("#titulo").val(libro.d.Titulo);
                    $("#autor").val(libro.d.Autor);
                }
            });
        }

        // Eliminar libro (lógico)
        function eliminarLibro(id) {
            $.ajax({
                type: "POST",
                url: "Libro.aspx/DeleteLibro",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    cargarLibros();
                }
            });
        }

        $(document).ready(function () {
            cargarLibros();
        });
    </script>
</body>
</html>
