@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for booking suppl object'
define view entity ZAB_I_BOOkSUPP_M as select from /dmo/booksuppl_m as BookSuppl
association to parent ZAB_I_BOOK_AW02_M  as _Booking
    on $projection.TravelId = _Booking.TravelID and 
    $projection.BookingId = _Booking.BookingId 
  association [1..1] to ZAB_I_TRAV_AW02_M   as _Travel   on $projection.TravelId = _Travel.TravelId     
{
    key BookSuppl.travel_id as TravelId,
    key BookSuppl.booking_id as BookingId,
    key BookSuppl.booking_supplement_id as BookingSupplementId,
    BookSuppl.supplement_id as SupplementId,
    BookSuppl.price as Price,
    BookSuppl.currency_code as CurrencyCode,
    BookSuppl.last_changed_at as LastChangedAt,
    
     _Booking ,
     _Travel
}
