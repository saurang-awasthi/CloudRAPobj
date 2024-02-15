@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Booking BO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAB_I_BOOK_AW02_M 
              as select from /dmo/booking_m as Booking 
  association to parent  ZAB_I_TRAV_AW02_M as _Travel  on $projection.TravelID = _Travel.TravelId
  composition[0..*] of  ZAB_I_BOOkSUPP_M    as _Booksupp   
  association [1..1] to /DMO/I_Carrier     as _Carrier   on $projection.CarrierId = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection  as _Connection on $projection.ConnectionId = _Connection.ConnectionID
  association [1..1] to /DMO/I_Flight           as _Flight on $projection.FlightDate = _Flight.FlightDate     
  association [1..1] to /DMO/I_Customer     as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency          as _Currency on $projection.CurrencyCode = _Currency.Currency                
{
    key booking_id as BookingId,
   key travel_id as TravelID,
    Booking.booking_id as Booking_Id,
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true
    _Travel.Createdby as Createdby,
    @Semantics.user.lastChangedBy: true    
    _Travel.Lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true   
    _Travel.local_Lastchangedat as Lastchangedat,
    
    _Travel,
    _Carrier,
    _Connection,
    _Flight,
    _Customer,
    _Booksupp, 
    _Currency    
}
