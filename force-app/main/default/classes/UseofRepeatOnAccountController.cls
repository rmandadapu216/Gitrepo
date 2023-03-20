public class UseofRepeatOnAccountController {
    public List<Purchase_Contracts__c> PurchasecontractList{get;set;}
   
    public UseofRepeatOnAccountController(ApexPages.standardController stdController) {
      PurchasecontractList = new List<Purchase_Contracts__c>();
        PurchasecontractList = [SELECT Contract_Id__c, Name, (SELECT Id, Name, Quantiy__c, Unit_Price__c From Contract_materials__r)From Purchase_Contracts__c ] ;


    }
}