@EndUserText.label: 'Projection view for Travel managed'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity ZAB_I_TRAV_AW02_M_Proj as projection on ZAB_I_TRAV_AW02_M
{
   @Search.defaultSearchElement: true    
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Travel_U',element: 'TravelID' } }]  
    key TravelId,
    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
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
    _Booking : redirected to composition child ZAB_I_BOOK_AW02_M_PROJ ,
    _Booksupp    ,
    _Currency,
    _Customer
}
