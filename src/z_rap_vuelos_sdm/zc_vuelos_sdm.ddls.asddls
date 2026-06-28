@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'CDS de vuelos'
}
define view entity ZC_VUELOS_SDM
  as select from ZI_VUELOS_SDM
  association [1..1] to ZI_VUELOS_SDM as _BaseEntity on $projection.CARRIER_ID = _BaseEntity.CARRIER_ID
{
  @Endusertext: {
    Label: 'Airline ID', 
    Quickinfo: 'Flight Reference Scenario: Carrier ID'
  }
  key carrier_id,
  @Endusertext: {
    Label: 'Airline Name', 
    Quickinfo: 'Flight Reference Scenario: Carrier Name'
  }
  name,
  @Endusertext: {
    Label: 'Flight Number', 
    Quickinfo: 'Flight Reference Scenario: Connection ID'
  }
  connection_id,
  @Endusertext: {
    Label: 'Flight Date', 
    Quickinfo: 'Flight Reference Scenario: Flight Date'
  }
  flight_date,
  _BaseEntity
}
