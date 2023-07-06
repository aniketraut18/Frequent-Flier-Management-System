
<%@ page import="java.sql.*" %>
<%
    try {
        String pid = request.getParameter("pid");
        String awardid = request.getParameter("awardid");

        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        Statement stmt = conn.createStatement();
//        ResultSet rs = stmt.executeQuery("SELECT a.A_DESCRIPTION, a.POINTS_REQUIRED, r.REDEMPTION_DATE, e.CENTER_NAME FROM Awards a INNER JOIN Redemption_history r ON a.AWARD_ID = r.AWARD_ID INNER JOIN exchgcenters e ON r.CENTER_ID = e.CENTER_ID WHERE r.PASSID = '"+pid+"' AND r.AWARD_ID = '"+awardid+"'");
        ResultSet rs = stmt.executeQuery("SELECT A_DESCRIPTION, POINTS_REQUIRED FROM Awards WHERE AWARD_ID = '"+awardid+"'");
        String output = "";
        
        if (rs.next() == false) {
            out.println("No data found");
        } else {
            String a_description = rs.getString("A_DESCRIPTION");
            int points_required = rs.getInt("POINTS_REQUIRED");
//            String redemption_date = rs.getString("REDEMPTION_DATE");
//            String center_name = rs.getString("CENTER_NAME");
            
            out.println("Award Description: " + a_description + ",");
            out.println("\nPoints Required: " + points_required + "#");
//            out.println("Redemption Date: : " + redemption_date + "<br>");
//            out.println("Exchange Center Name :  " + center_name + "<br>");
        }
        
        rs = stmt.executeQuery("SELECT RH.REDEMPTION_DATE, EC.CENTER_NAME FROM Redemption_history RH JOIN exchgcenters EC ON RH.CENTER_ID = EC.CENTER_ID WHERE RH.PASSID = '"+pid+"' AND RH.AWARD_ID = '"+awardid+"'");
        ResultSetMetaData rsmd = rs.getMetaData();
        
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

