package tzs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TzsDAO {
		private Connection conn; 
		private ResultSet rs; 
		
		
		public TzsDAO() {
			try {
				String dbURL = "jdbc:mysql://localhost:3306/TZS";
				String dbID = "root";
				String dbPassword = "178432123";
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		// 날짜 가져오기
		public String getDate() {
			String SQL = "SELECT NOW()";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "";
		}
		
		
		// 글번호 가져오기
		public int getNext() {
			String SQL = "SELECT tzsID FROM TZS ORDER BY tzsID DESC";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // DB오류
		}
		
		// 글제목 작성자 글내용 넣기
		public int write(String tzsTitle, String userID, String tzsContent) {
			String SQL = "INSERT INTO TZS VALUES(?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, tzsTitle);
				pstmt.setString(3, userID);
				pstmt.setString(4, getDate());
				pstmt.setString(5, tzsContent);
				pstmt.setInt(6, 1);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
}

