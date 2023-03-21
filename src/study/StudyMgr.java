package study;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DB.DBConnectionMgr;
import board.UtilMgr;

	public class StudyMgr {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "D:\\JSPWork\\EduSystem\\WebContent\\study\\fileUpload";
	private static final String ENCTYPE = "UTF-8";
	private static final int MAXSIZE = 5*1024*1024;
	
	public StudyMgr() {
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
	
	public void insertStudy(HttpServletRequest request) {		
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
			sql = "INSERT INTO studygroup VALUES(seq_study.NEXTVAL,?,?,?,?,SYSDATE,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("gname"));
			pstmt.setString(2, multi.getParameter("content"));
			pstmt.setString(3, multi.getParameter("name"));
			pstmt.setInt(4, Integer.parseInt(multi.getParameter("person")));
			pstmt.setString(5, multi.getParameter("edate"));
			pstmt.setString(6, fileName);
			pstmt.setInt(7, fileSize);
			pstmt.setString(8, multi.getParameter("title"));
			pstmt.setString(9, multi.getParameter("student_id"));
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
	}
	
	
	public ArrayList<StudyBean> getStudyList(String keyField, String keyWord, int start, int end) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<StudyBean> alist = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			if(keyWord == null || keyWord.equals("")) {
				sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY a.num DESC) row_num, a.* FROM studygroup a) b WHERE b.row_num >= ? AND b.row_num <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER(ORDER BY a.num DESC) row_num, a.* FROM studygroup a WHERE "+ keyField +" LIKE ?) b WHERE b.row_num >= ? AND b.row_num <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudyBean bean = new StudyBean();
				bean.setNum(rs.getInt("num"));
				bean.setGname(rs.getString("gname"));
				bean.setContent(rs.getString("content"));
				bean.setName(rs.getString("name"));
				bean.setPerson(rs.getInt("person"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setEdate(rs.getString("edate"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setTitle(rs.getString("title"));
				bean.setStudent_id(rs.getString("student_id"));
				alist.add(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return alist;
	}
	
	
	
	public StudyBean getStudy(int num) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		StudyBean bean = new StudyBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM studygroup WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setGname(rs.getString("gname"));
				bean.setContent(rs.getString("content"));
				bean.setName(rs.getString("name"));
				bean.setPerson(rs.getInt("person"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setEdate(rs.getString("edate"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setTitle(rs.getString("title"));
				bean.setStudent_id(rs.getString("student_id"));
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
				sql = "SELECT COUNT(*) FROM studygroup";
				pstmt = con.prepareStatement(sql);				
			}else {
				sql = "SELECT COUNT(*) FROM studygroup WHERE "+keyField+" LIKE ?";
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
	
	
	public int regStudyInsert(RegStudyBean bean) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int result = 0;
		
		try {
			con = pool.getConnection();
			sql = "INSERT INTO reg_study VALUES(?,?,sysdate,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getStudent_id());
			pstmt.setString(3, bean.getTel());
			pstmt.setString(4, bean.getName());
			pstmt.setString(5, bean.getContent());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
		return result;
	}
	
	
	public ArrayList<RegStudyBean> getRegList(int num) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<RegStudyBean> alist = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM reg_study WHERE num =" + num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				RegStudyBean bean = new RegStudyBean();
				bean.setNum(num);
				bean.setName(rs.getString("name"));
				bean.setTel(rs.getString("tel"));
				bean.setContent(rs.getString("content"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return alist;
	}
	
	/* 스터디 현재신청인원 가져오기 */
	public int getRegCnt(int num) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int result = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM reg_study WHERE num =" + num;
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
	
	
	public void updateStudy(StudyBean bean) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "UPDATE studygroup SET gname=?, person=?, regdate=sysdate, edate=?, title=?, content=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getGname());
			pstmt.setInt(2,bean.getPerson());
			pstmt.setString(3, bean.getEdate());
			pstmt.setString(4, bean.getTitle());
			pstmt.setString(5, bean.getContent());
			pstmt.setInt(6, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
	}
	
	
	
	public boolean deleteStudy(int num) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) FROM studygroup WHERE num="+num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int result = rs.getInt(1);
				if(result == 1) {
					sql = "SELECT filename studygroup WHERE num ="+num;
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next() && rs.getString(1) != null) {
						File file = new File(SAVEFOLDER + "/" + rs.getString(1));
						if(file.exists()) {
							UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
						}
					}
					sql = "DELETE FROM studygroup WHERE num="+num;
					pstmt = con.prepareStatement(sql);					
					if(pstmt.executeUpdate() > 0) {						
						flag = true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		
		return flag;
	}
	
	
}
