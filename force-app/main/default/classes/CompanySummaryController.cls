public class CompanySummaryController {
    public integer selectedYear{get;set;}
    public String contracts{get;set;}
    public String commission{get;set;}
    public String sales_vol{get;set;}
    public String pending_contracts{get;set;}
    public String buyer_contracts{get;set;}
    public String seller_contracts{get;set;}
    public String referral_fee{get;set;}
    public String admin_fee{get;set;}
    public String closed_deals{get;set;}
    public String attorney{get;set;}
    public String lender{get;set;}
    public String contracts_commission{get;set;}
    public String home_warranty{get;set;}
    
    public CompanySummaryController(){ 
        
        selectedYear=System.today().year();
        //Switch the URLs betweeen Salesforce Classic and Lightning
        system.debug('---------00O1Q0000089RM5--------'+URL.getSalesforceBaseUrl());
        if(UserInfo.getUiThemeDisplayed() == 'Theme3'){ //Salesforce Classic
            contracts = '/00O1Q0000089RM9?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            contracts_commission = '/00O36000006wtS5?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            sales_vol = '/00O1Q0000089RM7?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            pending_contracts = '/00O1Q0000089RMA?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            buyer_contracts = '/00O1Q0000089RM5?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            seller_contracts = '/00O1Q0000089RM6?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            commission = '/00O1Q0000089RM3?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            referral_fee = '/00O36000006wv1m?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            admin_fee = '/00O1Q0000089RM2?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            closed_deals = '/00O36000006wtTr?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            attorney = '/00O1Q000007WPNx?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            lender = '/00O1Q000007WPO2?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
            home_warranty = '/00O1Q0000089RM8?dbw=1&colDt_s=1/1/'+selectedYear+'&colDt_e=12/31/'+selectedYear;
        }
        else if(UserInfo.getUiThemeDisplayed() == 'Theme4d'){ //Salesforce Lightning
            contracts = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=contracts&year='+selectedYear;
            contracts_commission = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=contracts_commission&year='+selectedYear;
            sales_vol = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=sales_volume&year='+selectedYear;
            pending_contracts = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=pending&year='+selectedYear;
            buyer_contracts = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=buyer_contracts&year='+selectedYear;
            seller_contracts = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=seller_contracts&year='+selectedYear;
            commission = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=commission&year='+selectedYear;
            referral_fee = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=referralfee&year='+selectedYear;
            admin_fee = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=adminfee&year='+selectedYear;
            closed_deals = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=closeddeals&year='+selectedYear;
            attorney = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=attorney&year='+selectedYear;
            lender = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=lender&year='+selectedYear;
            home_warranty = '/one/one.app#/alohaRedirect/apex/CompanySummary_Detail?db=home_warranty&year='+selectedYear;
        }
    }   
    public void getassignSelectedYear(){ 
        System.debug('---------------selectedYear------------'+selectedYear);
    }  
    @RemoteAction   
    public static list<Wrapper> FetchData(integer year){ 
        System.debug('===For Contracts=====>>'+year);
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,Contract_Date_date__c from pba__Closing__c where Closing_Status__c!=
                        'Pending Bust Out' and Closing_Status__c!='Bust Out' and calendar_year(Contract_Date_date__c)=:year];
        System.debug('---------------->>>'+closinglist);
        for(pba__Closing__c closing:closinglist){
            //Map Month Vs Record Count
            if(mapMonthVsCount.containsKey(closing.Contract_Date_date__c.month())){
                integer count=mapMonthVsCount.get(closing.Contract_Date_date__c.month());
                count=count+1;
                mapMonthVsCount.put(closing.Contract_Date_date__c.month(),count);
            }
            else
                mapMonthVsCount.put(closing.Contract_Date_date__c.month(),1);  
            //Map month to Net Transaction Sum Value
            if(mapMonthVsCommission.containsKey(closing.Contract_Date_date__c.month()) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.Contract_Date_date__c.month());
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.Contract_Date_date__c.month(),count);
            }
            else
                mapMonthVsCommission.put(closing.Contract_Date_date__c.month(),closing.Net_Transaction_Commission__c);
        }
        //Fill Wrapper List for all 12 months
        for(Integer i=1;i<=12;i++){ 
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i)));
        }
        System.debug('---------------------------'+wraplist);
        return wraplist;
    }
    //****************Closed Contracts - Commission
    @remoteaction  
    public static list<Wrapper> FetchData_2(integer year){
        
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where 
                        Closing_Status__c='closed' and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            //Month Vs Record Count
            if(mapMonthVsCount.containsKey(closing.RETHINK_Closed_Deal_Date__c.month())){
                integer count=mapMonthVsCount.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+1;
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),1);
            //Month Vs Net Transaction Sum Value
            if(mapMonthVsCommission.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Net_Transaction_Commission__c);
        }//Fill Wrapper for all 12 months
        for(Integer i=1;i<=12;i++){
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i)));
        }
        return wraplist;
    }
    //*******************For Closed COntracts (Buyer Rep)
    @remoteaction
    public static list<Wrapper> FetchData_3(integer year){
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
         map<Integer,decimal> mapMonthVsSalesprice=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,Actual_Sale_Price__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='closed' and RecordType.name='MCRE Buyer Closing' and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        system.debug('closinglist'+closinglist);
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.RETHINK_Closed_Deal_Date__c.month())){
                integer count=Integer.valueof(mapMonthVsCount.get(closing.RETHINK_Closed_Deal_Date__c.month()));
                count=count+1;
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),1);
            
            if(mapMonthVsCommission.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Net_Transaction_Commission__c);
            
            if(mapMonthVsSalesprice.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && closing.Actual_Sale_Price__c!=null){
                decimal count=mapMonthVsSalesprice.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=(count!=null?count:0)+(closing.Actual_Sale_Price__c!=null?closing.Actual_Sale_Price__c:0);
                mapMonthVsSalesprice.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsSalesprice.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Actual_Sale_Price__c);
            
        }
         system.debug('mapMonthVsSalesprice'+mapMonthVsSalesprice);
        for(Integer i=1;i<=12;i++){ 
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i),mapMonthVsSalesprice.get(i)));
        }
        system.debug('wraplist--==>'+wraplist);
        return wraplist;
    }
    //Pending Contracts per Month
    @remoteaction
    public static list<Wrapper> FetchData_4(integer year){
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='Pending' and Closing_Status__c!='Pending Bust Out' and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.RETHINK_Closed_Deal_Date__c.month())){
                integer count=mapMonthVsCount.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+1;
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),1);
            
            if(mapMonthVsCommission.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Net_Transaction_Commission__c);
        }
        
        // added by charu to show buyer percent and seller percent on the widget.
        Integer buyerCount = [select count() from pba__Closing__c where Closing_Status__c!=
                              'Pending Bust Out' and Closing_Status__c!='Bust Out' and 
                               RecordType.name='MCRE Buyer Closing' and calendar_year(Contract_Date_date__c)=:year];
        Integer sellerCount = [select count() from pba__Closing__c where Closing_Status__c!=
                              'Pending Bust Out' and Closing_Status__c!='Bust Out' and 
                               RecordType.name='MCRE Seller Closing' and calendar_year(Contract_Date_date__c)=:year];
        
        Decimal buyerPercent;
        decimal sellerPercent;
        if(buyerCount!= null && sellerCount != null){
            if(buyerCount != 0 && sellerCount != 0){
                buyerPercent = decimal.valueof(buyerCount) / decimal.valueOf((buyerCount + sellerCount)) ;
                buyerPercent = (buyerPercent *100).round();
                
                sellerPercent = decimal.valueOf(sellerCount) / decimal.valueOf((buyerCount + sellerCount)) ;
                sellerPercent = (sellerPercent * 100).round();
            }
        }
        
        for(Integer i=1;i<=12;i++){ 
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i),buyerPercent,sellerPercent));
        }
        system.debug('--------wraplist by charu---------'+wraplist);
        return wraplist;
    }
    
    //*************Closed Contracts - Sales Volume
    @remoteaction
    public static list<Wrapper> FetchData_5(integer year){
        System.debug('>>>>>>>>>>>>>>>============');
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Actual_Sale_Price__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c 
                        where Closing_Status__c='Closed' and RETHINK_Closed_Deal_Date__c!=null and 
                            calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.RETHINK_Closed_Deal_Date__c.month())){
                integer count=mapMonthVsCount.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+1;
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),1);
            
            System.debug('>>>>>$>>>>>>>>>>'+mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month()));
            if(mapMonthVsCommission.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month())!=null && closing.Actual_Sale_Price__c != null){
               System.debug('>>>>>>>>month1>>>>>>>'+closing.RETHINK_Closed_Deal_Date__c.month());
                decimal count1;
                System.debug('>>>>>***>>>>>>>>>>'+mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month()));
                count1=mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month());
                System.debug('>>>>>>???>>>>>>>>>'+mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month()));
                System.debug('---------1-------'+closing.Actual_Sale_Price__c);
                count1=count1+closing.Actual_Sale_Price__c;
                System.debug('----------2------'+count1);
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),count1);
            }
            else if(closing.Actual_Sale_Price__c != null){
            System.debug('>>>>>>>>month>>>>>>>'+closing.RETHINK_Closed_Deal_Date__c.month());
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Actual_Sale_Price__c);}
        }
        
        System.debug('????????????????????'+mapMonthVsCommission.get(12));
        for(Integer i=1;i<=12;i++){ 
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i)));
        }
        System.debug('**************************************'+wraplist);
        return wraplist;
    }
    //Closed Contracts - Seller
    @remoteaction
    public static list<Wrapper> FetchData_6(integer year){
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        map<Integer,decimal> mapMonthVsSalesprice=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,Actual_Sale_Price__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='Closed' and RecordType.name='MCRE Seller Closing' and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.RETHINK_Closed_Deal_Date__c.month())){
                integer count=mapMonthVsCount.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+1;
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCount.put(closing.RETHINK_Closed_Deal_Date__c.month(),1);
            
            if(mapMonthVsCommission.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsCommission.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Net_Transaction_Commission__c);
            
            if(mapMonthVsSalesprice.containsKey(closing.RETHINK_Closed_Deal_Date__c.month()) && closing.Actual_Sale_Price__c!=null){
                decimal count=mapMonthVsSalesprice.get(closing.RETHINK_Closed_Deal_Date__c.month());
                count=count+closing.Actual_Sale_Price__c;
                mapMonthVsSalesprice.put(closing.RETHINK_Closed_Deal_Date__c.month(),count);
            }
            else
                mapMonthVsSalesprice.put(closing.RETHINK_Closed_Deal_Date__c.month(),closing.Actual_Sale_Price__c);
        }
        for(Integer i=1;i<=12;i++){ 
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i),mapMonthVsSalesprice.get(i)));
        }
        return wraplist;
    }
    //Referral Fee
    @remoteaction
    public static list<Wrapper> FetchData_7(integer year){
        list<Wrapper> wraplist=new list<Wrapper>();
        map<String,Integer> mapMonthVsCount=new map<String,Integer>();  
        map<String,decimal> mapMonthVsCommission=new map<String,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Referral_Amount__c,Closing_Status__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c!='Bust Out' and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Closing_Status__c)){
                integer count=mapMonthVsCount.get(closing.Closing_Status__c);
                count=count+1;
                mapMonthVsCount.put(closing.Closing_Status__c,count);
            }
            else  
            mapMonthVsCount.put(closing.Closing_Status__c,1);
            //Map Month Vs Referral Amount Sum Value
            if(mapMonthVsCommission.containsKey(closing.Closing_Status__c) && closing.Referral_Amount__c!=null){
                decimal count=mapMonthVsCommission.get(closing.Closing_Status__c);
                count=count+closing.Referral_Amount__c;
                mapMonthVsCommission.put(closing.Closing_Status__c,count);
            }
            else
                mapMonthVsCommission.put(closing.Closing_Status__c,closing.Referral_Amount__c);
        }
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.Closing_Status__c)!=true){
                wraplist.add(new Wrapper(closing.Closing_Status__c,mapMonthVsCount.get(closing.Closing_Status__c),mapMonthVsCommission.get(closing.Closing_Status__c)));
                check.put(closing.Closing_Status__c,true);
            }
        }
        return wraplist;
    }
    //Closed Contracts -  Lender
    public list<PieData> getFetchData_8(){
        System.debug('------------==============');
        list<PieData> wraplist=new list<PieData>();
        map<String,Integer> mapMonthVsCount=new map<String,Integer>();  
        map<String,decimal> mapMonthVsCommission=new map<String,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Lender_Company__r.name,Net_Transaction_Commission__c,Closing_Status__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='closed' and Lender_is_Preferred_Vendor__c =true and calendar_year(RETHINK_Closed_Deal_Date__c)=:selectedYear];
        integer totalRec=closinglist.size();
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Lender_Company__r.name)){
                integer sum=mapMonthVsCount.get(closing.Lender_Company__r.name);
                sum=sum+Integer.valueof(closing.Net_Transaction_Commission__c);
                mapMonthVsCount.put(closing.Lender_Company__r.name,Integer.valueof(sum));
            }
            else  
                mapMonthVsCount.put(closing.Lender_Company__r.name,Integer.valueof(closing.Net_Transaction_Commission__c));
        System.debug('----===========--------------Piechart1'+wraplist);
    }
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.Lender_Company__r.name)!=true){
            wraplist.add(new PieData(closing.Lender_Company__r.name,mapMonthVsCount.get(closing.Lender_Company__r.name)));
            check.put(closing.Lender_Company__r.name,true);
            }
        }
        System.debug('----===========--------------Piechart1'+wraplist);
        return wraplist;
    }
    //Admin Fees Per Month - 
    @remoteaction
    public static list<Wrapper> FetchData_9(integer year){
        System.debug('-----------Admin Fees------------'+year);
        list<Wrapper> wraplist=new list<Wrapper>();
        map<Integer,Integer> mapMonthVsCount=new map<Integer,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,Contract_Date_date__c from pba__Closing__c where Admin_Fee__c=true and calendar_year(Contract_Date_date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Contract_Date_date__c.month())){
                integer count=mapMonthVsCount.get(closing.Contract_Date_date__c.month());
                count=count+1;
                mapMonthVsCount.put(closing.Contract_Date_date__c.month(),count);
            }
            else
            mapMonthVsCount.put(closing.Contract_Date_date__c.month(),1);
            
            if(mapMonthVsCommission.containsKey(closing.Contract_Date_date__c.month()) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.Contract_Date_date__c.month());
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.Contract_Date_date__c.month(),count);
            }
            else
            mapMonthVsCommission.put(closing.Contract_Date_date__c.month(),closing.Net_Transaction_Commission__c);
        }
        for(Integer i=1;i<=12;i++){ 
            wraplist.add(new Wrapper(i,mapMonthVsCount.get(i),mapMonthVsCommission.get(i)));
        }
        return wraplist;
    }
    //Closed Contracts - Home Warranty
    public list<PieData> getFetchData_10(){
         System.debug('------------==============');
        list<PieData> wraplist=new list<PieData>();
        map<String,Integer> mapMonthVsCount=new map<String,Integer>();  
        map<String,decimal> mapMonthVsCommission=new map<String,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Home_Warranty__r.name,Net_Transaction_Commission__c,Closing_Status__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='closed' and Home_Warranty_is_Preferred_Vendor__c =true and calendar_year(RETHINK_Closed_Deal_Date__c)=:selectedYear];
        integer totalRec=closinglist.size();
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Home_Warranty__r.name)){
                integer sum=mapMonthVsCount.get(closing.Home_Warranty__r.name);
                sum=sum+Integer.valueof(closing.Net_Transaction_Commission__c);
                mapMonthVsCount.put(closing.Home_Warranty__r.name,Integer.valueof(sum));
            }  
            else   
                mapMonthVsCount.put(closing.Home_Warranty__r.name,Integer.valueof(closing.Net_Transaction_Commission__c));
        System.debug('----===========--------------Piechart1'+wraplist);
    }
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.Home_Warranty__r.name)!=true){
            wraplist.add(new PieData(closing.Home_Warranty__r.name,mapMonthVsCount.get(closing.Home_Warranty__r.name)));
            check.put(closing.Home_Warranty__r.name,true);
            }
        }
        return wraplist;
    }
    
    //Closed Contracts -  Inspector
    @remoteaction
    public static list<Wrapper> FetchData_11(integer year){
        list<Wrapper> wraplist=new list<Wrapper>();
        map<String,Integer> mapMonthVsCount=new map<String,Integer>();    
        map<Integer,decimal> mapMonthVsCommission=new map<Integer,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Home_Inspector_Company__r.name,Net_Transaction_Commission__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='Closed' and Home_Inspector_is_Preferred_Vendor__c=true and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Home_Inspector_Company__r.name)){
                integer sum=mapMonthVsCount.get(closing.Home_Inspector_Company__r.name);
                sum=sum+Integer.valueof(closing.Net_Transaction_Commission__c);
                mapMonthVsCount.put(closing.Home_Inspector_Company__r.name,Integer.valueof(sum));
            }  
            else   
                mapMonthVsCount.put(closing.Home_Inspector_Company__r.name,Integer.valueof(closing.Net_Transaction_Commission__c));
        System.debug('----===========--------------Piechart1'+wraplist);
    }
        
        return wraplist;  
    }   
    
    //Closed Deals by City
    public list<PieData> getOrderData(){
        System.debug('************************************'+selectedYear);
        list<PieData> data = new list<PieData>();
        map<String,decimal> mapMonthVsCount=new map<String,decimal>();  
        map<String,Integer> mapMonthVsCommission=new map<String,Integer>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,Closing_Status__c,RETHINK_Closed_Deal_Date__c,City__c from pba__Closing__c where City__c!=null and Closing_Status__c='Closed' and calendar_year(RETHINK_Closed_Deal_Date__c)=:selectedYear];
        System.debug('------closing---------->>>'+closinglist);
        decimal totalRec;
        
        if(!closinglist.isEmpty())
        totalRec=closinglist.size();
        else
        totalRec=0;
        System.debug('-------totalRec--------->>>'+totalRec);
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.City__c)){
                decimal sum=mapMonthVsCount.get(closing.City__c);
                sum=sum+closing.Net_Transaction_Commission__c;
                mapMonthVsCount.put(closing.City__c,sum);
            }  
            else    
                mapMonthVsCount.put(closing.City__c,Integer.valueof(closing.Net_Transaction_Commission__c));
    }
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.City__c)!=true){
                data.add(new PieData(closing.City__c,mapMonthVsCount.get(closing.City__c).setScale(2)));
                check.put(closing.City__c,true);
            }
        }   
        System.debug('----===========--------------Piechart2'+data);
        System.debug('---------------------------'+data);
        return data;
    }
    
    public list<PieData> getOrderData1(){
        System.debug('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+selectedyear);
        list<PieData> data = new list<PieData>();
        map<String,decimal> mapMonthVsCount=new map<String,decimal>();  
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,RecordType.name from pba__Closing__c where Closing_Status__c='Closed' and calendar_year(Contract_Date_date__c)=:selectedYear];
        System.debug('---------------->>>'+closinglist);
        decimal totalRec=0;
        totalRec=[select count() from RecordType where sobjecttype = 'pba__Closing__c'];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.RecordType.name)){
                System.debug('-------closing.City__c--------->>>'+closing.RecordType.name);
                decimal count=mapMonthVsCount.get(closing.RecordType.name);
                System.debug('-------count--------->>>'+count);
                count=count+((1*100)/totalRec);  
                System.debug('-------count--------->>>'+count);
                mapMonthVsCount.put(closing.RecordType.name,count);
            }  
            else  
            mapMonthVsCount.put(closing.RecordType.name,(1*100/totalRec));
            System.debug('-------else--------->>>'+(1*100/totalRec));
        }
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.RecordType.name)!=true){
                data.add(new PieData(closing.RecordType.name,mapMonthVsCount.get(closing.RecordType.name).setScale(2)));
                check.put(closing.RecordType.name,true);
            }
        }   
        System.debug('--------------piechart3-------------'+data);
        return data;
    }
    //Commission
    @remoteaction
    public static list<Wrapper> FetchData_13(integer year){
        System.debug('----------13--==============');
        list<Wrapper> wraplist=new list<Wrapper>();
        map<String,Integer> mapMonthVsCount=new map<String,Integer>();  
        map<String,decimal> mapMonthVsCommission=new map<String,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Net_Transaction_Commission__c,Closing_Status__c,RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c!='Bust Out' and calendar_year(RETHINK_Closed_Deal_Date__c)=:year];
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Closing_Status__c)){
                integer count=mapMonthVsCount.get(closing.Closing_Status__c);
                count=count+1;
                mapMonthVsCount.put(closing.Closing_Status__c,count);
            }
            else  
            mapMonthVsCount.put(closing.Closing_Status__c,1);
            if(mapMonthVsCommission.containsKey(closing.Closing_Status__c) && closing.Net_Transaction_Commission__c!=null){
                decimal count=mapMonthVsCommission.get(closing.Closing_Status__c);
                count=count+closing.Net_Transaction_Commission__c;
                mapMonthVsCommission.put(closing.Closing_Status__c,count);
            }
            else  
            mapMonthVsCommission.put(closing.Closing_Status__c,closing.Net_Transaction_Commission__c);
        }
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.Closing_Status__c)!=true){
                wraplist.add(new Wrapper(closing.Closing_Status__c,mapMonthVsCount.get(closing.Closing_Status__c),mapMonthVsCommission.get(closing.Closing_Status__c)));
                check.put(closing.Closing_Status__c,true);
            }
        }
        System.debug('----------------commissions-------'+wraplist);
        return wraplist;
    }
    //Attorney
    public list<PieData> getFetchData_14(){
        System.debug('------------==============');
        list<PieData> wraplist=new list<PieData>();
        map<String,Integer> mapMonthVsCount=new map<String,Integer>();  
        map<String,decimal> mapMonthVsCommission=new map<String,decimal>();
        list<pba__Closing__c> closinglist=new list<pba__Closing__c>();
        closinglist=[select id,Attorney_Company__r.name,Net_Transaction_Commission__c,Closing_Status__c,
                        RETHINK_Closed_Deal_Date__c from pba__Closing__c where Closing_Status__c='closed'
                         and Attorney_is_Preferred_Vendor__c =true and calendar_year(RETHINK_Closed_Deal_Date__c)=:selectedYear];
        integer totalRec=closinglist.size();
        for(pba__Closing__c closing:closinglist){
            if(mapMonthVsCount.containsKey(closing.Attorney_Company__r.name)){
                integer sum=mapMonthVsCount.get(closing.Attorney_Company__r.name);
                sum=sum+Integer.valueof(closing.Net_Transaction_Commission__c);
                mapMonthVsCount.put(closing.Attorney_Company__r.name,Integer.valueof(sum));
            }  
            else  
                mapMonthVsCount.put(closing.Attorney_Company__r.name,Integer.valueof(closing.Net_Transaction_Commission__c));
        System.debug('----===========--------------Piechart1'+wraplist);
    }
       
        map<String,boolean> check=new map<String,boolean>();
        for(pba__Closing__c closing:closinglist){ 
            if(check.get(closing.Attorney_Company__r.name)!=true){
            wraplist.add(new PieData(closing.Attorney_Company__r.name,mapMonthVsCount.get(closing.Attorney_Company__r.name)));
            check.put(closing.Attorney_Company__r.name,true);
            }
        }
        
            System.debug('----===========--------------Piechart4'+wraplist);
        return wraplist;
    }   
   public class PieData {
        public String name { get; set; }
        public Decimal data { get; set; }
        public PieData(String namevalue, Decimal datavalue) {
           name = namevalue;
           data = datavalue;
        }
    } 
    public class Wrapper{
        Integer month;
        integer count1;  
        decimal commission;
        String status;
        decimal salesprice;
        decimal buyerPercent;
        decimal sellerPercent;
      //  decimal tempSum = 0;
      //  decimal finalTotal;
        public Wrapper(Integer month,Integer count1,decimal commission){
        //  temSum = tempSum + commission;
            this.commission=commission; 
            System.debug('^^^^^^^^^^3^^^^^^^^^^^^^^^^'+commission);
            this.month=month;
            this.count1=count1;  
            
        //    this.finalTotal = temSum;
        }
        
        public Wrapper(String status,Integer count1,decimal commission){
            this.commission=commission;
            this.status=status;
            this.count1=count1;
        }
       public Wrapper(Integer month,Integer count1,decimal commission,decimal salesprice){
            this.commission=commission;
            this.month=month;
            this.count1=count1;  
            this.salesprice=salesprice;
        }
        // added by charu
        public Wrapper(Integer month,Integer count1,decimal commission,decimal buyerPercent, decimal sellerPercent){
            this.commission=commission; 
            this.month=month;
            this.count1=count1;
            this.buyerPercent = buyerPercent;
            this.sellerPercent = sellerPercent;
        }
    }
}