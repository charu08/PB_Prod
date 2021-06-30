@isTest
public class CompanySummaryController_Test {
    
    public CompanySummaryController_Test(){}
    
    static testMethod void unitTest(){
        Account acc=new Account();
        acc.Name='test';
        acc.Preferred_Vendor__c=true;
        insert acc;
        
        pba__Closing__c closing=new pba__Closing__c();
        closing.Closing_Status__c='closed';
        closing.Contract_Date_date__c=Date.today();
        closing.RETHINK_Closed_Deal_Date__c=Date.today();
        closing.Actual_Sale_Price__c=2500;
        closing.Transaction_Commission_Flat_Fee__c=25;
        closing.Admin_Fee__c=true;
        closing.Home_Inspector_Company__c=acc.id;
        closing.Attorney_Company__c=acc.id;
        closing.Lender_Company__c=acc.id;
        closing.Home_Warranty__c=acc.id;
        closing.City__c='Delhi';
        closing.Referral_Fee_Flat_Fee__c=2500;
        insert closing;
        
        Id devRecordTypeId = Schema.SObjectType.pba__Closing__c.getRecordTypeInfosByName().get('MCRE Buyer Closing').getRecordTypeId();
        pba__Closing__c closing2=new pba__Closing__c();
        closing2.Closing_Status__c='closed';
        closing2.Contract_Date_date__c=Date.today();
        closing2.RETHINK_Closed_Deal_Date__c=Date.today();
        closing2.Actual_Sale_Price__c=2500;
        closing2.RecordTypeId=devRecordTypeId;
        closing2.Transaction_Commission_Flat_Fee__c=25;
        closing2.Admin_Fee__c=true;
        closing2.Home_Inspector_Company__c=acc.id;
        closing2.Attorney_Company__c=acc.id;
        closing2.Lender_Company__c=acc.id;
        closing2.Home_Warranty__c=acc.id;
        closing2.City__c='Delhi';
        closing2.Referral_Fee_Flat_Fee__c=2500;
        insert closing2;
        
        pba__Closing__c closing1=new pba__Closing__c();
        closing1.Closing_Status__c='pending';
        closing1.Contract_Date_date__c=Date.today();
        closing1.RETHINK_Closed_Deal_Date__c=Date.today();
        closing1.Actual_Sale_Price__c=2500;
        closing1.Transaction_Commission_Flat_Fee__c=25;
        closing1.Admin_Fee__c=true;
        closing1.Home_Warranty__c=acc.id;
        insert closing1;
        
        pba__Closing__c closing4=new pba__Closing__c();
        closing4.Closing_Status__c='pending';
        closing4.Contract_Date_date__c=Date.today();
        closing4.RETHINK_Closed_Deal_Date__c=Date.today();
        closing4.Actual_Sale_Price__c=2500;
        closing4.Transaction_Commission_Flat_Fee__c=25;
        closing4.Admin_Fee__c=true;
        closing4.Home_Warranty__c=acc.id;
        insert closing4;
        
      
        
        CompanySummaryController com=new CompanySummaryController();
        
        CompanySummaryController.FetchData(2021);
        CompanySummaryController.FetchData_2(2021);
        CompanySummaryController.FetchData_3(2021);
        CompanySummaryController.FetchData_4(2021);
        CompanySummaryController.FetchData_5(2021);
        CompanySummaryController.FetchData_6(2021);
        CompanySummaryController.FetchData_7(2021);
        CompanySummaryController.FetchData_9(2021);
        CompanySummaryController.FetchData_11(2021);
        CompanySummaryController.FetchData_13(2021);
        com.getFetchData_14();
        com.getOrderData();
        com.getOrderData1();
        com.getassignSelectedYear();
        com.getFetchData_8();
        com.getFetchData_10();
        CompanySummaryController.Wrapper wrap=new CompanySummaryController.Wrapper(9,4,2.5);
        CompanySummaryController.Wrapper wrap1=new CompanySummaryController.Wrapper('test',4,2.5);
        CompanySummaryController.Wrapper wrap2=new CompanySummaryController.Wrapper(9,4,2.5,3.5);
        CompanySummaryController.Wrapper wrap3=new CompanySummaryController.Wrapper(9,4,2.5,3.5,4.5);

    }
     
}