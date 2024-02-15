@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection CDS view for Sales'
@Metadata.allowExtensions: true

@UI:{ headerInfo:{ typeName: 'Sales Order',
                    typeNamePlural: 'Sales Orders' }
    }

define root view entity ZAW_C_CDS_SO as select from ZAW_I_CDS_SO
{

@UI:{lineItem: [{ position: 10 }],
     selectionField: [{ position: 10 }]
     }
    key OrderId,
@UI:{lineItem: [{ position: 20 }],
     selectionField: [{ position: 20 }]
     }    
    OrderNo,
@UI:{lineItem: [{ position: 30 }],
     selectionField: [{ position: 30 }]
     }   
    Buyer,
@UI:{lineItem: [{ position:40 }],
     selectionField: [{ position:40 }]
     }    
    GrossAmount,
@UI:{lineItem: [{ position:50 }],
     selectionField: [{ position:50 }]
     }    
    Currency,
@UI:{lineItem: [{ position:60 }],
     selectionField: [{ position:60 }]
     }    
    CreatedBy,
@UI:{lineItem: [{ position:70 }],
     selectionField: [{ position:70 }]
     }    
    CreatedAt,
@UI:{lineItem: [{ position:80 }],
     selectionField: [{ position:80 }]
     }   
    LastChangedBy,
@UI:{lineItem: [{ position:90 }],
     selectionField: [{ position:90 }]
     }    
    LastChangedAt,
    
    /* Associations */
    _BP
}
