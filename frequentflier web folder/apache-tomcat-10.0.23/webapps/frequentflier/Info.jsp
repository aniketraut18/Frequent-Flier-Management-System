<%@ page import="java.sql.*" %>
<%
    try {
        String pid = request.getParameter("pid");

        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT P.pname, PA.total_points FROM Passengers P INNER JOIN Point_Accounts PA ON P.passid = PA.passid WHERE P.passid = '"+pid+"'");

        if (rs.next() == false) {
            out.println("No data found");
        } else {
            String pname = rs.getString("pname");
            int total_points = rs.getInt("total_points");
//            out.println("Passenger Name: " + pname + "<br>");
//            out.println("Total Points: " + total_points);
            out.println(pname+","+total_points);
            
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        out.println("Exception: " + e.getMessage());
    }
%>
