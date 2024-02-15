@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for Booking BO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAB_I_RAP_BOOK_AW02 
              as select from zrap_abook_aw02 as Booking 
  association to parent  ZAB_I_RAP_TRAV_AW02 as _Travel  on $projection.Travel_UUID = _Travel.Travel_UUID
  
  association [1..1] to /DMO/I_Carrier     as _Carrier   on $projection.CarrierId = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection  as _Connection on $projection.ConnectionId = _Connection.ConnectionID
  association [1..1] to /DMO/I_Flight           as _Flight on $projection.FlightDate = _Flight.FlightDate     
  association [1..1] to /DMO/I_Customer     as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency          as _Currency on $projection.CurrencyCode = _Currency.Currency                
{
    key booking_uuid as BookingUUId,
    travel_uuid as Travel_UUID,
    booking_id as BookingId,
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.user.lastChangedBy: true    
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true   
    local_lastchangedat as Lastchangedat,
    
    _Travel,
    _Carrier,
    _Connection,
    _Flight,
    _Customer,
    _Currency    
}
