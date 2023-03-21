package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/board_global/likes.do")
public class AjaxLikesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int cnum = Integer.parseInt(request.getParameter("cnum"));
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String user_id = request.getParameter("user_id");
		
		LikesBean lbean = new LikesBean();
		lbean.setBnum(bnum);
		lbean.setCnum(cnum);
		lbean.setUser_id(user_id);
		
		int result = new CommentMgr().likesInsert(lbean);
		if(result >= 1) {
			new CommentMgr().likesUp(bnum);
			int liksCnt = new BoardMgr().getBoard(bnum).getLikes();
			response.getWriter().print(liksCnt);
		}else {
			response.getWriter().print(0);
		}
	}

}
