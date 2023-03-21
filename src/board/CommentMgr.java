package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import DB.DBConnectionMgr;

public class CommentMgr {
	
	private DBConnectionMgr pool;
	
	public CommentMgr() {
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
	
	/* 댓글 등록하기 */
	public int commentInsert(CommentBean cbean) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int result = 0;
		
		try {
			con = pool.getConnection();
			sql = "INSERT INTO comment_global VALUES(seq_comment.NEXTVAL, ?, ?, 0, ?, SYSDATE, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cbean.getBnum());
			pstmt.setString(2, cbean.getName());
			pstmt.setString(3, cbean.getContent());
			pstmt.setInt(4, cbean.getAnon());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
		
		return result;
		
	}
	
	
	/* 댓글 가져오기 */
	public ArrayList<CommentBean> getAllyComment(int bnum) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<CommentBean> alist = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM comment_global WHERE bnum = ? ORDER BY cnum DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bnum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentBean bean = new CommentBean();
				bean.setBnum(rs.getInt("bnum"));
				bean.setCnum(rs.getInt("cnum"));
				bean.setName(rs.getString("name"));
				bean.setLikes(rs.getInt("likes"));
				bean.setContent(rs.getString("content"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setAnon(rs.getInt("anon"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return alist;
	}
	
	/* 공감 등록하기 */
	public int likesInsert(LikesBean bean) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int result = 0;
		
		try {
			con = pool.getConnection();
			sql = "INSERT INTO likes VALUES(?, ?, ?, seq_likes.NEXTVAL)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setInt(2, bean.getBnum());
			pstmt.setInt(3, bean.getCnum());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
		
		return result;
	}
	
	/* 공감수 올리기 */
	public int likesUp(int bnum) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		int result = 0;
		try {
			con = pool.getConnection();
			sql = "UPDATE board_global SET likes = likes+1 WHERE bnum = "+bnum;
			pstmt = con.prepareStatement(sql);
			result = pstmt.executeUpdate();

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return result;
	}
	
	
	/* 게시글당 댓글 수 가져오기 */
	public int getComment(int bnum) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM comment_global WHERE bnum = " + bnum;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return result;
	}
	
	
}
