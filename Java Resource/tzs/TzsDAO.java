package tzs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
		
		
		// 게시글 리스트 반환 함수
		public ArrayList<Tzs> getList(int pageNumber){
			String SQL = "SELECT * FROM TZS where tzsID < ? and tzsAvailable = 1 ORDER BY tzsID DESC LIMIT 10";
			ArrayList<Tzs> list = new ArrayList<>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); 
				// 위에서 만든 getNext()(다음으로 작성될 글의 번호를 부여하는 함수)
				// 에다가 
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Tzs tzs = new Tzs();
					tzs.setTzsID(rs.getInt(1));
					tzs.setTzsTitle(rs.getString(2));
					tzs.setUserID(rs.getString(3));
					tzs.setTzsDate(rs.getString(4));
					tzs.setTzsContent(rs.getString(5));
					tzs.setTzsAvailable(rs.getInt(6));
					list.add(tzs); // 뽑아온 데이터가 담긴 tzs를 list에 넣는다.
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
		
		
		// 페이징 처리 함수 
		// 글을 10개까지 보여준다고 했을때 11번째 글이 없다면 
		// 다음 페이지 버튼이 없어야하기때문에 그 체크를 이 함수가 해준다. 
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM TZS where tzsID < ? and tzsAvailable = 1";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); 
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return false;
		}
		
		
		// 글을 가져와 보여주는 페이지
		public Tzs getTzs(int tzsID) {
			String SQL = "SELECT * FROM TZS where tzsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, tzsID); 
				rs = pstmt.executeQuery();
				if(rs.next()) {
					Tzs tzs = new Tzs();
					tzs.setTzsID(rs.getInt(1));
					tzs.setTzsTitle(rs.getString(2));
					tzs.setUserID(rs.getString(3));
					tzs.setTzsDate(rs.getString(4));
					tzs.setTzsContent(rs.getString(5));
					tzs.setTzsAvailable(rs.getInt(6));
					return tzs;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
		// 수정항목 DB통신 성공한다면 0이상의 값을 반환함
		public int update(int tzsID, String tzsTitle, String tzsContent) {
			String SQL = "UPDATE TZS SET tzsTitle = ?, tzsContent = ? WHERE tzsID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, tzsTitle);
				pstmt.setString(2, tzsContent);
				pstmt.setInt(3, tzsID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
}

