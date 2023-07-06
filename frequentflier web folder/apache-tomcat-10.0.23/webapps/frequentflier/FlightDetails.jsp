
<%@ page import="java.sql.*" %>
<%
    try {
        String flight_id = request.getParameter("flightid");

        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        Connection conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        Statement stmt = conn.createStatement();
//        ResultSet rs = stmt.executeQuery("select flight_id, flight_miles, destination from flights where passid='"+pid+"'");
//        ResultSet rs = stmt.executeQuery("SELECT f.DEPT_DATETIME, f.ARRIVAL_DATETIME, f.FLIGHT_MILES, t.TRIP_ID, t.TRIP_MILES  FROM flights_trips ft JOIN flights f ON ft.FLIGHT_ID = f.FLIGHT_ID JOIN trips t ON ft.TRIP_ID = t.TRIP_ID WHERE f.FLIGHT_ID = '"+flight_id+"'");
        ResultSet rs = stmt.executeQuery("SELECT DEPT_DATETIME, ARRIVAL_DATETIME, FLIGHT_MILES FROM flights WHERE FLIGHT_ID = '"+flight_id+"'");
//        ResultSetMetaData rsmd = rs.getMetaData();
        String output = "";
        
        while (rs.next()) {
            out.println("Departure datetime: " + rs.getString("DEPT_DATETIME") + ",");
            out.println("Arrival datetime: " + rs.getString("ARRIVAL_DATETIME") + ",");
            out.println("Flight miles: " + rs.getInt("FLIGHT_MILES") + "#");
        }
        
//        if (rs.next() == false) {
//            out.println("No data found");
//        } else {
//            String dept_datetime = rs.getString("DEPT_DATETIME");
//            String arrival_datetime = rs.getString("ARRIVAL_DATETIME");
//            int flight_miles = rs.getInt("FLIGHT_MILES");
//            String trip_id = rs.getString("TRIP_ID");
//            int trip_miles = rs.getInt("TRIP_MILES");
//            
//            out.println("Flight Departure Datetime : " + dept_datetime + "<br>");
//            out.println("Flight Arrival Datetime : " + arrival_datetime + "<br>");
//            out.println("Flight Miles : " + flight_miles + "<br>");
//            out.println("Trip ID :  " + trip_id + "<br>");
//            out.println("Trip Miles :  " + trip_miles);
//        }

        rs = stmt.executeQuery("SELECT t.TRIP_ID, t.TRIP_MILES FROM Flights_trips ft JOIN trips t ON ft.TRIP_ID = t.TRIP_ID WHERE ft.FLIGHT_ID = '"+flight_id+"'");
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
