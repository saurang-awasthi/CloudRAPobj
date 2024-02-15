@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for Travel BO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZAB_I_TRAV_AW02_M 
              as select from /dmo/travel_m as Travel
    
//   association [0..*] to ZI_RAP_BOOK_AW02    as _Booking  on $projection.TravelID = _Booking.travel_uuid    
  composition[1..*] of  ZAB_I_BOOK_AW02_M    as _Booking        
  association [0..1] to /DMO/I_Agency     as _Agency   on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer     as _Customer on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency          as _Currency on $projection.CurrencyCode = _Currency.Currency  
  association [1..*] to  ZAB_I_BOOkSUPP_M     as _Booksupp   on $projection.TravelId = _Booksupp.TravelId            
{      

//    key travel_uuid as Travel_UUID,
   key travel_id as TravelId,
    agency_id as AgencyId,
    customer_id as CustomerId,
    begin_date as BeginDate,
    end_date as EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    booking_fee as BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    total_price as TotalPrice,
    currency_code as CurrencyCode,
    description as Description,
    overall_status as Status,
        @Semantics.user.createdBy: true
    created_by as Createdby,
        @Semantics.systemDateTime.createdAt: true
    created_at as Createdat,
    @Semantics.user.lastChangedBy: true
    last_changed_by as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as Lastchangedat,
    last_changed_at as local_Lastchangedat,
    _Booking,
    _Agency,
    _Customer,
    _Currency,
    _Booksupp
}
