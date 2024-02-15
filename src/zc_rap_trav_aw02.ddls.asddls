@EndUserText.label: 'Consumption view for travel view'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZC_RAP_TRAV_AW02
  provider contract transactional_query
  as projection on ZI_RAP_TRAV_AW02 as Travel
{
    key Travel_UUID,
    @Search.defaultSearchElement: true    
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Travel_U',element: 'TravelID' } }]  
    TravelId,
    
    @Search.defaultSearchElement: true
    @ObjectModel.text.element: [ 'AgencyName' ]
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency',element: 'AgencyID' } }]    
    AgencyId,
    
    _Agency.Name as AgencyName,
    @Search.defaultSearchElement: true
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer',element: 'CustomerID' } }]    
    CustomerId,
    
    _Customer.LastName as CustomerName,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'    
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'    
    TotalPrice,
    @Consumption.valueHelpDefinition: [{ entity : {name: 'I_Currency',element: 'Currency' } }]       
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    local_Lastchangedat,
    
    /* Associations */
    _Agency,
    _Booking: redirected to composition child ZC_RAP_BOOK_AW02,
    _Currency,
    _Customer
}
