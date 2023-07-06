<%@ page import="java.sql.*" %>
<%
    try {
        String pid = request.getParameter("pid");

        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT DISTINCT AWARD_ID FROM REDEMPTION_HISTORY WHERE PASSID = '"+pid+"'");
        ResultSetMetaData rsmd = rs.getMetaData();
        String output = "";
        
//        if (rs.next() == false) {
//            out.println("No data found");
//        } else {
//            out.println("Distinct Award IDs for Passenger ID " + pid + ":");
////            out.println("<ul>");
//            do {
//                String awardId = rs.getString("AWARD_ID");
//                out.println(awardId);
//            } while (rs.next());
////            out.println("</ul>");
//        }
//        output = ""

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
