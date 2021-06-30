public class CompanySummaryDetail_360DC {
	public list<Wrapper_HyperlinkData> datalist{get;set;} 
	list<pba__Closing__c> closinglist;
	Integer year;
	public map<String,Integer> modulecountMap{get;set;}
	public map<Integer,String> mapMonthToName=new map<Integer,String>();
    public CompanySummaryDetail_360DC(){
    	datalist = new list<Wrapper_HyperlinkData>();
    	closinglist = new list<pba__Closing__c>();
    	modulecountMap = new map<String,Integer>();
    	mapMonthToName.put(1,'January');
    	mapMonthToName.put(2,'February');
    	mapMonthToName.put(3,'March');	
    	mapMonthToName.put(4,'April');
    	mapMonthToName.put(5,'May');
    	mapMonthToName.put(6,'June');
    	mapMonthToName.put(7,'July');
    	mapMonthToName.put(8,'August');
    	mapMonthToName.put(9,'September');
    	mapMonthToName.put(10,'October');
    	mapMonthToName.put(11,'November');
    	mapMonthToName.put(12,'December');
    	checkDashCalled();
    }
    public void checkDashCalled(){
        if(ApexPages.currentPage().getParameters().get('db')!=null && ApexPages.currentPage().getParameters().get('year')!=null){
            String db = ApexPages.currentPage().getParameters().get('db');
            year = Integer.valueof(ApexPages.currentPage().getParameters().get('year'));
            switch on db {
                when 'contracts' {
                    getContracts(year);
                }   
                when 'contracts_commission' {     // when block 2
                    getContracts_commission(year);
                }
                when 'sales_volume' {       // when block 3
                    getSales_volume(year);
                }
                when 'pending' {       // default block, optional
                    getPending(year);
                }
                when 'buyer_contracts' {       // default block, optional 
                    getBuyer_contracts(year);
                }
                when 'seller_contracts' {       // default block, optional
                    getSeller_contracts(year);
                }
                when 'commission' {       // default block, optional
                   getCommission(year);
                }
                when 'referralfee' {       // default block, optional
                    getReferralfee(year);
                }
                when 'adminfee' {       // default block, optional
                    getAdminfee(year);
                }
                when 'closeddeals' {       // default block, optional
                    getClosedDeals();
                }
                when 'attorney' {       // default block, optional
                   getAttorney();
                }
                when 'lender' {       // default block, optional
                    getLender();
                }
                when 'home_warranty' {       // default block, optional
                    getHome_warranty();
                }
            } 
        }
    }
    public void getContracts(Integer year){
        closinglist=[select id,name,RecordType.Name,Net_Transaction_Commission__c,Actual_Sale_Price__c,Contract_Date_date__c from pba__Closing__c where Closing_Status__c!='Pending Bust Out'
        				and Closing_Status__c!='Bust Out' and calendar_year(Contract_Date_date__c)=:year];
        if(!closinglist.isEmpty()){
	        for(pba__Closing__c closing:closinglist){
	        	if(closing!=null & closing.Contract_Date_date__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        		datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.Contract_Date_date__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
	        }
        }    
        System.debug('------Contracts-----------'+datalist);
    }
    public void getContracts_commission(Integer year){
    	closinglist=[select id,name,Net_Transaction_Commission__c,Actual_Sale_Price__c,ClosingDate__c from pba__Closing__c where 
                        Closing_Status__c='closed' and calendar_year(ClosingDate__c)=:year];
        if(!closinglist.isEmpty()){
	        for(pba__Closing__c closing:closinglist){
	        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
		        	datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.ClosingDate__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
	        	/*if(modulecountMap.containsKey(String.valueof(closing.ClosingDate__c.month()))){
	        		Integer count = modulecountMap.get(String.valueof(closing.ClosingDate__c.month()));
	        		count++;
	        		modulecountMap.put(String.valueof(closing.ClosingDate__c.month()),count);
	        	}
	        	else
	        		modulecountMap.put(String.valueof(closing.ClosingDate__c.month()),1);*/
	        }
        }  
        System.debug('-----------------'+datalist);
    }
    public void getSales_volume(Integer year){
    	closinglist=[select id,name,Net_Transaction_Commission__c,Actual_Sale_Price__c,ClosingDate__c from pba__Closing__c 
                        where Closing_Status__c='Closed' and ClosingDate__c!=null and 
                            calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.ClosingDate__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getPending(Integer year){
    	closinglist=[select id,name,Net_Transaction_Commission__c,ClosingDate__c,Actual_Sale_Price__c from pba__Closing__c where Closing_Status__c='Pending' and Closing_Status__c!='Pending Bust Out' and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        		datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.ClosingDate__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getBuyer_contracts(Integer year){
    	closinglist=[select id,name,Net_Transaction_Commission__c,Actual_Sale_Price__c,ClosingDate__c from pba__Closing__c where Closing_Status__c='closed' and RecordType.name='Buyer Rep' and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.ClosingDate__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getSeller_contracts(Integer year){
    	closinglist=[select id,name,Net_Transaction_Commission__c,Actual_Sale_Price__c,ClosingDate__c from pba__Closing__c where Closing_Status__c='Closed' and RecordType.name='Seller Rep' and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.ClosingDate__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getCommission(Integer year){
    	closinglist=[select id,name,Actual_Sale_Price__c,Net_Transaction_Commission__c,Closing_Status__c,ClosingDate__c from pba__Closing__c where Closing_Status__c!='Bust Out' and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.Closing_Status__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,String.valueof(closing.Closing_Status__c),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getReferralfee(Integer year){
    	closinglist=[select id,name,Referral_Amount__c,Net_Transaction_Commission__c,Closing_Status__c,ClosingDate__c,Actual_Sale_Price__c from pba__Closing__c where Closing_Status__c!='Bust Out' and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,String.valueof(closing.Closing_Status__c),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getAdminfee(Integer year){
    	closinglist=[select id,name	,Net_Transaction_Commission__c,Contract_Date_date__c,Actual_Sale_Price__c from pba__Closing__c where Admin_Fee__c=true and calendar_year(Contract_Date_date__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.Contract_Date_date__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,mapMonthToName.get(closing.Contract_Date_date__c.month()),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getClosedDeals(){
    	closinglist=[select id,name,Net_Transaction_Commission__c,Closing_Status__c,ClosingDate__c,City__c,Actual_Sale_Price__c from pba__Closing__c where City__c!=null and Closing_Status__c='Closed' and calendar_year(ClosingDate__c)=:year];
    	for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.City__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,String.valueof(closing.City__c),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
    	}
    	System.debug('-----------------'+datalist);
    }
    public void getAttorney(){
    	closinglist=[select id,name,Attorney_Company__r.name,Net_Transaction_Commission__c,Closing_Status__c,
                        ClosingDate__c,Actual_Sale_Price__c from pba__Closing__c where Closing_Status__c='closed'
                         and Attorney_is_Preferred_Vendor__c =true and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.Attorney_Company__r.name!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,String.valueof(closing.Attorney_Company__r.name),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getLender(){
    	closinglist=[select id,name,Lender_Company__r.name,Net_Transaction_Commission__c,Closing_Status__c,ClosingDate__c,Actual_Sale_Price__c from pba__Closing__c where Closing_Status__c='closed' and Lender_is_Preferred_Vendor__c =true and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.ClosingDate__c!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,String.valueof(closing.Lender_Company__r.name),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public void getHome_warranty(){
    	closinglist=[select id,name,Home_Warranty__r.name,Net_Transaction_Commission__c,Closing_Status__c,Actual_Sale_Price__c,ClosingDate__c from pba__Closing__c where Closing_Status__c='closed' and Home_Warranty_is_Preferred_Vendor__c =true and calendar_year(ClosingDate__c)=:year];
        for(pba__Closing__c closing:closinglist){
        	if(closing!=null & closing.Home_Warranty__r.name!=null && closing.Net_Transaction_Commission__c!=null && closing.Actual_Sale_Price__c!=null)
	        	datalist.add(new Wrapper_HyperlinkData(closing.name,String.valueof(closing.Home_Warranty__r.name),String.valueOf(closing.Net_Transaction_Commission__c),String.valueof(closing.Actual_Sale_Price__c),closing.Id));
        }
        System.debug('-----------------'+datalist);
    }
    public class Wrapper_HyperlinkData{
    	public String param1{get;set;}
        public String param2{get;set;}
        public String param3{get;set;}
        public String param4{get;set;} 
        public String param5{get;set;}
    	public Wrapper_HyperlinkData(String param1,String param2,String param3,String param4,String param5){
        	this.param1 = param1;
            this.param2 = param2;
            this.param3 = param3;
            this.param4 = param4;
            this.param5 = param5;
        }
    }
}