import java . sql .*;

public class JDBClab_207 {
public static void main ( String [] args ) {
    try {
        //SQL query to fetch required data from the TRANSACTIONS table
        String sqlQuery1 = "SELECT A_ID, AMOUNT, TYPE FROM TRANSACTIONS";

        //SQL query to count the total number of accounts in the ACCOUNT table
        String sql2 = "SELECT 'Total Number of Accounts : ' || COUNT(*) AS TotalAccounts FROM ACCOUNT";
        
        //storing total balance of each account 
        int [] balance = new int [1000]; 
        
        //storing total transaction amount of each account 
        int [] total = new int [1000];  

        //to keep track of max account number
        int count=0; 
        
        //to count CIP, VIP, OP, and uncategorized accounts
        int cipCount = 0;
        int vipCount = 0;
        int opCount = 0;
        int uncategorized = 0;

        // 1) load the driver class
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // 2) create the connection object
        String url="jdbc:oracle:thin:@localhost:1521/XE";
        String username="nusrat";
        String password="nus207";
        Connection con = DriverManager.getConnection (url,username,password);
        System.out.println("Connection to database successful");

        // 3) Create the Statement object
        Statement statement = con.createStatement ();

        // 4) Execute the query
        ResultSet result=statement.executeQuery (sqlQuery1);

        while(result.next ()) {
            int account = result.getInt ("a_id"); // Could also be written as result . getInt (1) ;
            int amount = result.getInt ("amount"); // Could also be written as result . getInt (2) ;
            String type = result.getString ("type"); // Could also be written as result . getInt (3) ;
            System.out.println ( account + " " + amount + " " + type );
            
            balance[account] += (type.equals("0")) ? amount : -amount;
            //type 0 -> credit, type 1 ->debit
            //so +amount if credited, -amount if debited to get the total balance of one account

            total[account] += (type.equals("0") || type.equals("1")) ? amount : 0;
            //summing amount regardless of it being type 0 or 1

            count = Math.max(count, account);
        }
       
        //Execute the query to count the total number of accounts
        result = statement.executeQuery(sql2);
        while (result.next()) {
            String accCount = result.getString("TotalAccounts");
            System.out.println(accCount);
        }
        
        //counting cip,vip,op from the stored values 
        for (int i = 1; i <= count; i++){  
            if (balance[i] > 1000000 && total[i] > 5000000) 
                cipCount++;
            else if (balance[i] > 500000 && balance[i] < 900000 && total[i]  > 2500000 && total[i]  < 4500000) 
                vipCount++;
            else if (balance[i] < 100000 && total[i]  < 1000000) 
                opCount++;
            else 
                uncategorized++;
        }
        
        System.out.println("CIP Count: " + cipCount);
        System.out.println("VIP Count: " + vipCount);
        System.out.println("OP Count: " + opCount);
        System.out.println("uncategorized Count: " + uncategorized);
 

        //task2
        // Prepared statement to insert new transactions into the TRANSACTIONS table
        PreparedStatement pStmt = con.prepareStatement (" insert into TRANSACTIONS values (? ,TO_DATE(?, 'Month dd, yyyy') ,? ,?,?)") ;

        pStmt.setInt(1,10001);
        pStmt.setString(2,"February 12, 2022");
        pStmt.setInt(3,2);
        pStmt.setInt(4,5000);
        pStmt.setInt(5,1);
        pStmt.executeUpdate();
        System.out.println("Transaction 1 inserted successfully");

        pStmt.setInt(1,10005);
        pStmt.setString(2,"October 15, 2022");
        pStmt.setInt(3,4);
        pStmt.setInt(4,10000);
        pStmt.setInt(5,0);
        pStmt.executeUpdate();
        System.out.println("Transaction 2 inserted successfully"); 
 
        //task3
        //execute query to retrieve metadata for ACCOUNT table
        result = statement.executeQuery("select * from Account");
        ResultSetMetaData rsmd = result.getMetaData () ;

        System.out.println("Number of columns of ACCOUNT: " + rsmd.getColumnCount()) ;
        for(int i = 1; i <= rsmd.getColumnCount (); i++) {
             System.out.println("Column name: " + rsmd.getColumnName (i) + ", Data type: " + rsmd.getColumnTypeName (i) ) ;
        }

        //execute query to retrieve metadata for TRANSACTIONS table
        result = statement.executeQuery("select * from transactions");
        rsmd = result.getMetaData () ;

        System.out.println("Number of columns of TRANSACTIONS: " + rsmd.getColumnCount()) ;
        for( int i = 1; i <= rsmd.getColumnCount (); i++){
            System.out.println("Column name: " + rsmd.getColumnName (i) + ", Data type: " + rsmd.getColumnTypeName (i) ) ;
        } 
        
        // 5) Close the connection object
        con.close ();
        statement.close ();
        result.close ();
    } catch ( SQLException e) {
        System.out.println (" Error while connecting to database . Exception code : " + e);
    } catch ( ClassNotFoundException e) {
        System.out.println (" Failed to register driver . Exception code : " + e);
    }
        System.out.println (" Thank You !");
}
}
