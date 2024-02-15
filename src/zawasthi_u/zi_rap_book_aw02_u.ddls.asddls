@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Booking BO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_RAP_BOOK_AW02_U as select from /dmo/booking
 association to parent  ZI_RAP_TRAV_AW02_U as _Travel  on $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Carrier     as _Carrier   on $projection.CarrierId = _Carrier.AirlineID
  association [1..1] to /DMO/I_Connection  as _Connection on $projection.ConnectionId = _Connection.ConnectionID
  association [1..1] to /DMO/I_Flight           as _Flight on $projection.FlightDate = _Flight.FlightDate     
  association [1..1] to /DMO/I_Customer     as _Customer on $projection.CustomerId = _Customer.CustomerID
{
//    key travel_id as TravelId,
//    key booking_id as BookingId,
//    booking_date as BookingDate,
//    customer_id as CustomerId,
//    carrier_id as CarrierId,
//    connection_id as ConnectionId,
//    flight_date as FlightDate,
//    flight_price as FlightPrice,
//    currency_code as CurrencyCode


key travel_id as TravelId,
 key   booking_id as BookingId,
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    
    _Travel,
    _Carrier,
    _Connection,
    _Flight,
    _Customer



}
