package subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

import DB.DBConnectionMgr;

public class SubjectMgr {

	private DBConnectionMgr pool;
	
	public SubjectMgr() {
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
	
	public ArrayList<SubjectBean> getRegSubject(String num) {		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<SubjectBean> alist = new ArrayList<SubjectBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT s.subject_title, t.name FROM reg_subject r JOIN subject s USING(subject_id) "
					+" JOIN teacher t ON(prof_num = num) WHERE student_id ="+num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SubjectBean bean = new SubjectBean();
				bean.setSubject_title(rs.getString("subject_title"));
				bean.setName(rs.getString("name"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return alist;
	}
	
	
	/* 오늘 시간표 가져오기 */
	public ArrayList<SubjectBean> getTodaySchedule(String num) {
		Calendar cal = Calendar.getInstance();
		int today = cal.get(Calendar.DAY_OF_WEEK);
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		ArrayList<SubjectBean> alist = new ArrayList<>();
		
		try {
			con = pool.getConnection();
			sql = "SELECT c.time, c.location, c.day, s.subject_title, t.name FROM reg_subject r JOIN class_info c USING(subject_id) "
					+ "JOIN subject s USING(subject_id) "
					+ "JOIN teacher t ON(num = prof_num) "
					+ "WHERE student_id = ? ORDER BY time";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SubjectBean bean = new SubjectBean();
				String day = rs.getString("day");
				for(int i = 0; i<day.length(); i++) {
					String j = ""+day.charAt(i);
					if(today == Integer.parseInt(j)) {
						bean.setSubject_title(rs.getString("subject_title"));
						bean.setTime(rs.getString("time"));
						bean.setLocation(rs.getString("location"));
						bean.setName(rs.getString("name"));
						alist.add(bean);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		pool.freeConnection(con, pstmt, rs);
		return alist;
	}
	
}
