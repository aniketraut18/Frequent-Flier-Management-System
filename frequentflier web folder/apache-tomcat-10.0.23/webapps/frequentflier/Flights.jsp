<%@ page import="java.sql.*" %>
<%
    try {
        String pid = request.getParameter("pid");

        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        Statement stmt = conn.createStatement();
//        ResultSet rs = stmt.executeQuery("SELECT P.pname, PA.total_points FROM Passengers P INNER JOIN Point_Accounts PA ON P.passid = PA.passid WHERE P.passid = '"+pid+"'");
        ResultSet rs = stmt.executeQuery("select flight_id, flight_miles, destination from flights where passid='"+pid+"'");
        ResultSetMetaData rsmd = rs.getMetaData();
        String output = "";
        
        
        
//        if (rs.next() == false) {
//            out.println("No data found");
//        } else {
//            do {
//                String flight_id = rs.getString("flight_id");
//                int flight_miles = rs.getInt("flight_miles");
//                String destination = rs.getString("destination");
//            
//                out.println("Flight ID : " + flight_id + "<br>");
//                out.println("Flight Miles : " + flight_miles + "<br>");
//                out.println("Destination: " + destination);
//            } while (rs.next());
//        }

        if (rs.next() == false) {
            out.println("No data found");
        } else {
//            out.println("data found");
            do {
                 String[] list = new String[rsmd.getColumnCount()];
                        for(int i=0;i<rsmd.getColumnCount();i++)
                        {
//                            out.print((rs.getObject(i+1).toString()));
                            output += rs.getObject(i+1).toString();
//                            out.print(",");
                            output += ",";
                        }
                        output = output.substring(0, output.length() - 1);
//                        out.print("#"); 
                        output += "#";
            } while (rs.next());
            out.println(output);
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        out.println("Exception: " + e.getMessage());
    }
%>
