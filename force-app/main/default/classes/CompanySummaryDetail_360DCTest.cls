@isTest
public class CompanySummaryDetail_360DCTest {
	@isTest
    public static void unitTest1(){
        Test.startTest();
        Integer year = System.today().year();
        Account acc=new Account();
        acc.Name='test';
        acc.Preferred_Vendor__c=true;
        insert acc;
        
        Id devRecordTypeId1 = Schema.SObjectType.pba__Closing__c.getRecordTypeInfosByName().get('MCRE Seller Closing').getRecordTypeId();
        pba__Closing__c closing=new pba__Closing__c();
        closing.Closing_Status__c='closed';
        closing.Contract_Date_date__c=Date.today();
        closing.ClosingDate__c=Date.today();
        closing.Actual_Sale_Price__c=2500;
        closing.Transaction_Commission_Flat_Fee__c=25;
        closing.Admin_Fee__c=true;
        closing.City__c='Delhi';
        closing.Referral_Fee_Flat_Fee__c=2500;
        closing.RecordTypeId = devRecordTypeId1;
        closing.Attorney_Company__c=acc.id;
        closing.Lender_Company__c=acc.id;
        closing.Home_Warranty__c=acc.id;
        insert closing;
        
        Id devRecordTypeId = Schema.SObjectType.pba__Closing__c.getRecordTypeInfosByName().get('MCRE Buyer Closing').getRecordTypeId();
        pba__Closing__c closing1=new pba__Closing__c();
        closing1.Closing_Status__c='pending';
        closing1.Contract_Date_date__c=Date.today();
        closing1.ClosingDate__c=Date.today();
        closing1.Actual_Sale_Price__c=2500;
        closing1.Transaction_Commission_Flat_Fee__c=25;
        closing1.Admin_Fee__c=true;
        closing1.Home_Warranty__c=acc.id;
        closing1.RecordTypeId = devRecordTypeId;
        insert closing1;
        ApexPages.currentPage().getParameters().put('db','contracts');
        ApexPages.currentPage().getParameters().put('year',String.valueof(year));
        
        CompanySummaryDetail_360DC compobj = new CompanySummaryDetail_360DC();
        compobj.getContracts_commission(year);
        compobj.getSales_volume(year);
        compobj.getBuyer_contracts(year);
        compobj.getCommission(year);
        compobj.getReferralfee(year);
        compobj.getAdminfee(year);
        compobj.getClosedDeals();
        compobj.getAttorney();
        compobj.getHome_warranty();
        compobj.getLender();
        compobj.getPending(year);
        compobj.getSeller_contracts(year);
        Test.stopTest();
    }
    @isTest
    public static void unitTest2(){
        Test.startTest();
        Integer year = System.today().year();
        Account acc=new Account();
        acc.Name='test';
        acc.Preferred_Vendor__c=true;
        insert acc;
        
        Id devRecordTypeId1 = Schema.SObjectType.pba__Closing__c.getRecordTypeInfosByName().get('MCRE Seller Closing').getRecordTypeId();
        pba__Closing__c closing=new pba__Closing__c();
        closing.Closing_Status__c='closed';
        closing.Contract_Date_date__c=Date.today();
        closing.ClosingDate__c=Date.today();
        closing.Actual_Sale_Price__c=2500;
        closing.Transaction_Commission_Flat_Fee__c=25;
        closing.Admin_Fee__c=true;
        closing.City__c='Delhi';
        closing.Referral_Fee_Flat_Fee__c=2500;
        closing.RecordTypeId = devRecordTypeId1;
        closing.Attorney_Company__c=acc.id;
        closing.Lender_Company__c=acc.id;
        closing.Home_Warranty__c=acc.id;
        insert closing;
        
        Id devRecordTypeId = Schema.SObjectType.pba__Closing__c.getRecordTypeInfosByName().get('MCRE Buyer Closing').getRecordTypeId();
        pba__Closing__c closing1=new pba__Closing__c();
        closing1.Closing_Status__c='pending';
        closing1.Contract_Date_date__c=Date.today();
        closing1.ClosingDate__c=Date.today();
        closing1.Actual_Sale_Price__c=2500;
        closing1.Transaction_Commission_Flat_Fee__c=25;
        closing1.Admin_Fee__c=true;
        closing1.Home_Warranty__c=acc.id;
        closing1.RecordTypeId = devRecordTypeId;
        insert closing1;
        ApexPages.currentPage().getParameters().put('db','contracts_commission');
        ApexPages.currentPage().getParameters().put('year',String.valueof(year));
        
        CompanySummaryDetail_360DC compobj = new CompanySummaryDetail_360DC();
        compobj.getContracts_commission(year);
        compobj.getSales_volume(year);
        compobj.getBuyer_contracts(year);
        compobj.getCommission(year);
        compobj.getReferralfee(year);
        compobj.getAdminfee(year);
        compobj.getClosedDeals();
        compobj.getAttorney();
        compobj.getHome_warranty();
        compobj.getLender();
        compobj.getPending(year);
        compobj.getSeller_contracts(year);
        Test.stopTest();
    }
}