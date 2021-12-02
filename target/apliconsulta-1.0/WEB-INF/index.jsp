<%-- 
    Document   : index
    Created on : 02/12/2021, 05:45:14 AM
    Author     : USUARIO
--%><%@page import="java.net.ProtocolException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.net.MalformedURLException"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%

            URL url;
            String resultado = "";
            try {
                String ruc = "10750830370";
                url = new URL("https://api.migo.pe/api/v1/ruc");
                HttpURLConnection http = (HttpURLConnection) url.openConnection();
                http.setRequestMethod("POST");
                http.setDoOutput(true);
                http.setRequestProperty("Content-Type", "application/json");
                String data = "{\"token\":\"v7qlKfKTTkmQrkcKRdnXXMqmNynZ7VaRvUxZdOBelV2DdLH0vmot1Eml2RnR\", \"ruc\":\"";
                data = data + ruc + "\"}";
                byte[] outq = data.getBytes(StandardCharsets.UTF_8);
                OutputStream stream = http.getOutputStream();
                stream.write(outq);
                BufferedReader rd = new BufferedReader(new InputStreamReader(http.getInputStream()));
                String linea;
                // Mientras el BufferedReader se pueda leer, agregar contenido a resultado
                while ((linea = rd.readLine()) != null) {
                    resultado = linea;
                }
                if (http.getResponseMessage().equals("OK")) {
                    String[] partes = resultado.split(",");
                    String nombre = partes[2].split(":")[1].replace("\"", "");
                    String condicion = partes[3].split(":")[1].replace("\"", "");
                    String estado = partes[4].split(":")[1].replace("\"", "");
                    System.out.println(http.getResponseCode() + " " + http.getResponseMessage());

                    out.println(nombre);
                    out.println(condicion);
                    out.println(estado);
                }

                http.disconnect();

            } catch (MalformedURLException | ProtocolException ex) {

            } catch (IOException ex) {

            }


        %>



    </body>
</html>
