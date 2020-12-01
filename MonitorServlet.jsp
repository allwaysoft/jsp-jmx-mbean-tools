<%@page import="java.io.PrintWriter"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.util.Set"%>
<%@page import="javax.management.MBeanAttributeInfo"%>
<%@page import="javax.management.MBeanInfo"%>
<%@page import="javax.management.MBeanServer"%>
<%@page import="javax.management.ObjectName"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<body>");
        out.println("<p><h1>Tomcat Pool</h1></p><p>");
        try {
            MBeanServer server = ManagementFactory.getPlatformMBeanServer();
            Set<ObjectName> objectNames = server.queryNames(null, null);
            for (ObjectName name : objectNames) {
                MBeanInfo info = server.getMBeanInfo(name);
                if (info.getClassName().equals(
                        "org.apache.tomcat.jdbc.pool.jmx.ConnectionPool")) {
                    for (MBeanAttributeInfo mf : info.getAttributes()) {
                        Object attributeValue = server.getAttribute(name,
                                mf.getName());
                        if (attributeValue != null) {
                            out.println("" + mf.getName() + " : "
                                    + attributeValue.toString() + "<br/>");

                        }
                    }
                    break;
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        out.println("</p></body>");
        out.println("</html>");

%>