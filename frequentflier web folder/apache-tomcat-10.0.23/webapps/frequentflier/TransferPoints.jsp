<%@ page import="java.sql.*" %>
<%

    String src_id = request.getParameter("spid");
    String dest_id = request.getParameter("dpid");
    String numPoints = request.getParameter("npoints");
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("oracle.jdbc.OracleDriver");
        String url = "jdbc:oracle:thin:@artemis.vsnet.gmu.edu:1521/vse18c.vsnet.gmu.edu";
        conn = DriverManager.getConnection(url, "skasar", "eedsupsu");
        conn.setAutoCommit(false);
        
        // Deduct the specified number of points from the source passenger's point account
        String updateSql1 = "UPDATE point_accounts SET total_points = total_points - ? WHERE passid = ?";
        pstmt = conn.prepareStatement(updateSql1);
        pstmt.setInt(1, Integer.parseInt(numPoints));
        pstmt.setString(2, src_id);
        pstmt.executeUpdate();
        pstmt.close();

        // Add the specified number of points to the destination passenger's point account
        String updateSql2 = "UPDATE point_accounts SET total_points = total_points + ? WHERE passid = ?";
        pstmt = conn.prepareStatement(updateSql2);
        pstmt.setInt(1, Integer.parseInt(numPoints));
        pstmt.setString(2, dest_id);
        pstmt.executeUpdate();
        pstmt.close();
        
        conn.commit();
        out.println("Points transferred successfully!");

    } catch (Exception e) {
        e.printStackTrace();
        if (conn != null) {
            conn.rollback();
        }
        out.println("Error transferring points: "+e.getMessage());
    }
%>
