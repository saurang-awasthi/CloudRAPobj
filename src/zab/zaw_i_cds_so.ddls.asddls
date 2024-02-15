@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface CDS view for sales order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZAW_I_CDS_SO as select from zaws_00_so_table
association[1] to zaws_00_bp_table as _BP on $projection.Buyer = _BP.bp_id
{
    key order_id as OrderId,
    order_no as OrderNo,
    buyer as Buyer,
    @Semantics.amount.currencyCode: 'Currency'
    gross_amount as GrossAmount,
    currency as Currency,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    _BP
}
