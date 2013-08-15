#= require env

c = window.ICRMClient.convead_client_controller = new @ICRMClient.ConveadController {}
window.ICRMClient.convead_informer = new @ICRMClient.InformerController c.start_visitor
