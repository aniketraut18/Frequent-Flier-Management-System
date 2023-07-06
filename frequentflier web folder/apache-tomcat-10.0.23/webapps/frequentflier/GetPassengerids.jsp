<%@ page import="java.sql.*" %>
<%
    try {
        String pid = request.getParameter("pid");

        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT PASSID FROM Passengers WHERE PASSID <> '"+pid+"'");

        while (rs.next()) {
            out.println(rs.getString("PASSID")+"#");
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        out.println("Exception: " + e.getMessage());
    }
%>
