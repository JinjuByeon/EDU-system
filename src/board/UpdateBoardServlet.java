package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/board_global/boardUpdate")
public class UpdateBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		BoardMgr bMgr = new BoardMgr();
		// 기존에 들어있는 값
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String nowPage = request.getParameter("nowPage");
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		
		// 사용자로 부터 새롭게 받은 값을 bean에 넣기
		BoardBean upBean = new BoardBean();
		upBean.setBnum(bnum);
		upBean.setTitle(request.getParameter("title"));
		upBean.setContent(request.getParameter("content"));
		
		bMgr.updateBoard(upBean);
		response.sendRedirect("read.jsp?nowPage="+ nowPage + "&bnum="+ bean.getBnum());
	}

}
