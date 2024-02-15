@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface CDS view for sales order item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAW_I_CDS_SI as select from zaws_00_si_table
association [1] to zaws_00_so_table as _SO on $projection.OrderId = _SO.order_id
{
    key item_id as ItemId,
    order_id as OrderId,
    product as Product,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    qty as Qty,
    uom as Uom,
    @Semantics.amount.currencyCode: 'Currency'
    amount as Amount,
    currency as Currency,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    
    _SO
}
