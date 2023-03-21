package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DB.DBConnectionMgr;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:\\JSPWork\\EduSystem\\WebContent\\board_global\\fileUpload";
	private static final String ENCTYPE = "UTF-8";
	private static final int MAXSIZE = 5*1024*1024;
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public void sample() {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
	}
	
	/* 게시글 정보 insert하는 메소드 */
	public void insertBoard(HttpServletRequest request) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		MultipartRequest multi = null;
		int fileSize = 0;
		String fileName = null;
		
		try {
			con = pool.getConnection();
			File file = new File(SAVEFOLDER);
			if(!file.exists()) {
				file.mkdir();
			}
			multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			if(multi.getFilesystemName("filename") != null) {
				fileName = multi.getFilesystemName("filename");
				fileSize = (int)multi.getFile("filename").length();
			}
			sql = "INSERT INTO board_global VALUES(seq_board.NEXTVAL,?,?,?,?,SYSDATE,0,0,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("num"));
			pstmt.setString(2, multi.getParameter("name"));
			pstmt.setString(3, multi.getParameter("title"));
			pstmt.setString(4, multi.getParameter("content"));
			pstmt.setString(5, fileName);
			pstmt.setInt(6, fileSize);
			pstmt.setInt(7, Integer.parseInt(multi.getParameter("anon")));
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
	}
	
	/* 게시글 목록 가져오기 */
	public ArrayList<BoardBean> getBoardList(String keyField, String keyWord, int start, int end) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<BoardBean> alist = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			if(keyWord == null || keyWord.equals("")) {
				sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY a.bnum DESC) row_num, a.* FROM board_global a) b WHERE b.row_num >= ? AND b.row_num <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY a.bnum DESC) row_num, a.* FROM board_global a WHERE "+keyField+" LIKE ?) b WHERE b.row_num >= ? AND b.row_num <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBnum(rs.getInt("bnum"));
				bean.setNum(rs.getString("num"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setLikes(rs.getInt("likes"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setAnon(rs.getInt("anon"));
				alist.add(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return alist;
	
	}
	
	/* 조회수를 업데이트 하는 메소드 */
	public void upCount(int bnum) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "UPDATE board_global SET count = count+1 WHERE bnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
	}
	
	/* bnum에 해당하는 게시글 하나를 가져오는 메소드 */
	public BoardBean getBoard(int bnum) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		BoardBean bean = new BoardBean();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM board_global WHERE bnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setBnum(rs.getInt("bnum"));
				bean.setNum(rs.getString("num"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setLikes(rs.getInt("likes"));
				bean.setContent(rs.getString("content"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setAnon(rs.getInt("anon"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return bean;
	}
	
	/* 총 게시글의 개수를 가져오는 메소드 */
	public int getTotalCount(String keyField, String keyWord) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int totalCount = 0;
		
		try {
			con = pool.getConnection();
			if(keyWord == null || keyWord.equals("")) {
				sql = "SELECT COUNT(*) FROM board_global";
				pstmt = con.prepareStatement(sql);				
			}else {
				sql = "SELECT COUNT(*) FROM board_global WHERE "+keyField+" LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return totalCount;
	}
	
	
	/* 인기 게시글 가져오기 */
	public ArrayList<BoardBean> getPopBoard() {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<BoardBean> alist = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM (SELECT * FROM board_global ORDER BY likes DESC, count DESC) WHERE rownum <= 5";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setBnum(rs.getInt("bnum"));
				bean.setName(rs.getString("name"));
				bean.setTitle(rs.getString("title"));
				bean.setLikes(rs.getInt("likes"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setAnon(rs.getInt("anon"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return alist;
	}
	
	
	/* 게시글 삭제하기 */
	public boolean deleteBoard(int bnum) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM board_global WHERE bnum="+bnum;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int result = rs.getInt(1);
				if(result == 1) {
					flag = true;
					sql = "SELECT filename FROM board_global WHERE bnum ="+bnum;
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next() && rs.getString(1) != null) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if(file.exists()) {
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
						}
					}
					sql = "DELETE FROM board_global WHERE bnum="+bnum;
					pstmt = con.prepareStatement(sql);
					pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return flag;
	}
	
	/* 수정하기 */
	public void updateBoard(BoardBean bean) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			con = pool.getConnection();
			sql = "UPDATE board_global SET title=?, content=?, regdate=sysdate WHERE bnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getTitle());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getBnum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
	}
	
}
