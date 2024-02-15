@EndUserText.label: 'Projection view for Booking supply managed'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZAB_C_BOOKSUPP_M as projection on ZAB_I_BOOkSUPP_M
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    Price,
    CurrencyCode,
    LastChangedAt,
    /* Associations */

//    _Booking: redirected to parent ZAB_I_BOOK_AW02_M_PROJ,
    _Travel 
}
