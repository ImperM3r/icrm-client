#= require env

c = window.ICRMClient.convead_client_controller = new @ICRMClient.ConveadController
  container: window.ICRMClient.container

window.ICRMClient.convead_informer = new @ICRMClient.InformerController c.start_visitor
