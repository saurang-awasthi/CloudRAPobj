@EndUserText.label: 'Projection view for Booking managed'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true
define view entity ZAB_I_BOOK_AW02_M_PROJ as projection on ZAB_I_BOOK_AW02_M

{
    key BookingId,
    key TravelID,
    Booking_Id,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    FlightPrice,
    CurrencyCode,
    Createdby,
    Lastchangedby,
    Lastchangedat,
    
    /* Associations */
    _Booksupp ,
    _Carrier,
    _Connection,
    _Currency,
    _Customer,
    _Flight,
    _Travel : redirected to parent ZAB_I_TRAV_AW02_M_Proj
}
