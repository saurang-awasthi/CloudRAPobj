@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Booking Unmanaged'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_RAP_BOOK_AW02_U as projection on ZI_RAP_BOOK_AW02_U as Booking
{
    key TravelId,
    key BookingId,
    BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      @Consumption.valueHelpDefinition: [{entity.name: '/DMO/I_Customer', entity.element: 'CustomerId',
                   additionalBinding: [{ localElement: 'CarrierID',    element: 'AirlineID' },
                                                               { localElement: 'FlightDate',   element: 'FlightDate',   usage: #RESULT},
                                                               { localElement: 'FlightPrice',  element: 'Price',        usage: #RESULT },
                                                               { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT }
                                                               ] } ]    
           @Search.defaultSearchElement: true                                                         
    CustomerId,
    _Customer.LastName as CustomerName,
      @ObjectModel.text.element: [ 'carrierName' ]
          @Consumption.valueHelpDefinition: [{entity.name: '/DMO/I_Carrier', entity.element: 'AirlineID'}]
    CarrierId,
    _Carrier.Name as carrierName,    
      @Consumption.valueHelpDefinition: [{entity.name: '/DMO/I_Flight', entity.element: 'ConnectionID',
                   additionalBinding: [{ localElement: 'CarrierID',    element: 'AirlineID' },
                                                               { localElement: 'FlightDate',   element: 'FlightDate',   usage: #RESULT},
                                                               { localElement: 'FlightPrice',  element: 'Price',        usage: #RESULT },
                                                               { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT }
                                                               ] } ]        
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
      @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_Currency', element: 'Currency'} }]
    CurrencyCode,
    
    /* Associations */
    _Carrier,
    _Connection,
    _Customer,
    _Flight,
    _Travel : redirected to parent ZC_RAP_TRAV_AW02_U
}
