package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// JSP에서 회원 테이블에 접근 할 수 있도록 해주는 녀석
	// Dao(Data access object)
	private Connection conn; // DB에 접근하게 해주는 객체
	private PreparedStatement pstmt; // SQL인젝션을 이용한 해킹 기법을 방어하는 수단
	private ResultSet rs; // 정보를 담을 수 있는 객체
	
	
	// 실제로 mysql 접속을 담당하는 부분
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TZS";
			String dbID = "root";
			String dbPassword = "178432123";
			Class.forName("com.mysql.jdbc.Driver"); // mysql에 접속할 수 있도록 매개체 역할을 해주는 하나의 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// conn 객체 안에 접속된 정보가 담긴다.
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	// login 시도를 하는 함수
	// 실제로 이 함수를 사용해서 결과를 사용자에게 보여주는 페이지가 loginAction.jsp이다.
	public int login(String userID, String userPassword) {
		// 로그인 하려는 ID를 쿼리의 ?로 넘겨 조회된 패스워드와
		// 사용자가 웹단에서 입력한(함수로 받은 Password) 값에 따라 결과를 반환.
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			// pstmt에 정해진 SQL문을 DB에 삽입하는 형식으로 인스턴스를 가져온다.
			// conn에 있는 prepareStatement 함수가 pstmt 형식에 맞게 변환을 해주는 거 같다.
			
			pstmt.setString(1, userID); 
			// SQL인젝션을 이용한 해킹 기법을 방어하는 수단으로 pstmt를 사용하는데 위 쿼리문에 ?에 userID를 넣겠다는 뜻.
			// 앞의 int는 변수가 들어갈 위치를 지정해 준다.
			
			rs = pstmt.executeQuery(); // pstmt를 거친 데이터를 결과 객체에 넘겨줌. -> DB에서 넘어온 데이터임.
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) { // rs에 담겨있는 인자가 userPassword와 같다면 1을 반환한다. -> login 성
					return 1; // 로그인 성공
				}else {
					return 0; // 비밀번호 불일치
				}
			}
			return -1; // DB에 해당 아이디가 없을 때 오류.  
		} catch (Exception e) {
			e.printStackTrace();

		}
		return -2; // 여기서 -2는 DB의 오류를 의미한다.
	}
	
	// 회원가입 수행 함수 
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate(); // 업데이트 쿼리 성공적이라면 -1 이상의 값이 반환됨.
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류
	}
}
