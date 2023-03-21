package study;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/study/studyUpdate")
public class StudyUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		StudyMgr sMgr = new StudyMgr();
		
		StudyBean bean = (StudyBean)session.getAttribute("sBean");
		String nowPage = request.getParameter("nowPage");
		int num = Integer.parseInt(request.getParameter("num"));
		
		
		StudyBean upBean = new StudyBean();
		upBean.setNum(num);
		upBean.setGname(request.getParameter("gname"));
		upBean.setTitle(request.getParameter("title"));
		upBean.setContent(request.getParameter("content"));
		upBean.setEdate(request.getParameter("edate"));
		upBean.setPerson(Integer.parseInt(request.getParameter("person")));
		
		sMgr.updateStudy(upBean);
		response.sendRedirect("studyRead.jsp?nowPage="+ nowPage + "&num="+ bean.getNum());
	}

}
