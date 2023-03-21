package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/board_global/insert.do")
public class AjaxCommentInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		int nowPage = Integer.parseInt(request.getParameter("nowPage"));
		
		int bnum = Integer.parseInt(request.getParameter("bnum"));
		String name = request.getParameter("name");
		String content = request.getParameter("content");
		int anon = Integer.parseInt(request.getParameter("anon"));
		
		CommentBean cBean = new CommentBean();
		cBean.setBnum(bnum);
		cBean.setName(name);
		cBean.setContent(content);
		cBean.setAnon(anon);
		
		int result = new CommentMgr().commentInsert(cBean);
		response.getWriter().print(result);
	}

}
