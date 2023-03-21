package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DB.DBConnectionMgr;

public class MemberMgr {
	
	private DBConnectionMgr pool;
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean sample() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "";
			pstmt = con.prepareStatement(sql);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return flag;
	}
	
	/* 회원가입정보 학생테이블에 insert */
	public boolean insertStudent(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			if(bean.getPart().equals("1")) {
				sql = "INSERT INTO student VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getNum());
				pstmt.setString(2, bean.getUser_id());
				pstmt.setString(3, bean.getName());
				pstmt.setString(4, bean.getMajor());
				pstmt.setString(5, bean.getGender());
				pstmt.setString(6, bean.getEmail());
				pstmt.setString(7, bean.getTel());
				pstmt.setString(8, bean.getBirthday());
				pstmt.setString(9, bean.getPassword());
				pstmt.setString(10, bean.getAddr());
				pstmt.setString(11, "s");
			}else {
				sql = "INSERT INTO teacher VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getNum());
				pstmt.setString(2, bean.getUser_id());
				pstmt.setString(3, bean.getName());
				pstmt.setString(4, bean.getMajor());
				pstmt.setString(5, bean.getGender());
				pstmt.setString(6, bean.getEmail());
				pstmt.setString(7, bean.getTel());
				pstmt.setString(8, bean.getBirthday());
				pstmt.setString(9, bean.getPassword());
				pstmt.setString(10, bean.getAddr());
				pstmt.setString(11, "t");
			}
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt);
		return flag;
	}
	
	
	/* 아이디 중복체크 */
	public boolean idCheck(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM student WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
			sql = "SELECT * FROM teacher WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return flag;
	}
	
	
	/* 로그인 아이디 확인하는 메소드*/
	public boolean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM student WHERE user_id = ? AND password = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}else {
				sql = "SELECT * FROM teacher WHERE user_id = ? AND password = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					flag = true;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return flag;
	}
	
	
	/* 회원정보 가져오는 메서드 */
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM student WHERE user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getString("num"));
				bean.setUser_id(rs.getString("user_id"));
				bean.setName(rs.getString("name"));
				bean.setMajor(rs.getString("major"));
				bean.setGender(rs.getString("gender"));
				bean.setEmail(rs.getString("email"));
				bean.setTel(rs.getString("tel"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setAddr(rs.getString("addr"));
				bean.setPart(rs.getString("part"));
			}else {
				sql = "SELECT * FROM teacher WHERE user_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setNum(rs.getString("num"));
					bean.setUser_id(rs.getString("user_id"));
					bean.setName(rs.getString("name"));
					bean.setMajor(rs.getString("major"));
					bean.setGender(rs.getString("gender"));
					bean.setEmail(rs.getString("email"));
					bean.setTel(rs.getString("tel"));
					bean.setBirthday(rs.getString("birthday"));
					bean.setAddr(rs.getString("addr"));
					bean.setPart(rs.getString("part"));
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return bean;
	}
	
}
