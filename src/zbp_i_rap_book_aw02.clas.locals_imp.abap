CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateBookingId FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateBookingId.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalPrice.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateBookingId.
  ENDMETHOD.

  METHOD calculateTotalPrice.
  ENDMETHOD.

ENDCLASS.
