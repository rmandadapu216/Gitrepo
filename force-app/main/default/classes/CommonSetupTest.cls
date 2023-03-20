@isTest
private class CommonSetupTest {

@testSetup static void setup() {
	Account acc = new Account();
	acc.name = 'MyTestVendor';
	acc.Record_Type__c = 'Vendor Account';
	acc.Vendor_Status2__c = 'Active';
	insert acc;

   	Purchase_Contracts__c pc = new Purchase_Contracts__c();
	pc.name = 'MyTestPC_100';
	pc.Vendor_Name__c = acc.id;
	pc.Contract_type__c = 'Other';     
	pc.Stages__c = 'Initiation';
	pc.Contract_Term__c = 1;
    pc.Delivery_Schedule__c = 'Weekly';
	insert pc;

    Contract_Material__c cm = new Contract_Material__c();
	cm.Name = 'MyTestCM_100';
	cm.Unit_Price__c = 100;
	cm.Quantiy__c = 1;
	cm.Unit_Of_Measurement__c = 'Each';
	cm.Purchase_Contract__c = pc.id; 
	insert cm;
    
	}
    
    @isTest static void testMethod1() {
     try{
    	// Get the first test account by using a SOQL query
        Account acct = [SELECT Id FROM Account WHERE Name='MyTestVendor' LIMIT 1];
        Purchase_Contracts__c mypc = [SELECT Id FROM Purchase_Contracts__c WHERE name='MyTestPC_100' LIMIT 1];
        mypc.Stages__c = 'Generation';    
        
        // Perform some testing
        System.assertEquals(acct.Name, 'MyTestVendor', 'Vendor matched');
       	System.assertEquals(mypc.name, 'MyTestPC_100', 'Purchase Contract matched');	
             
    	} 
        Catch (DMLException e) {
       		System.debug(e.getMessage());
        	System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, e.getDmlType(0));
   		}
    }
    
 }