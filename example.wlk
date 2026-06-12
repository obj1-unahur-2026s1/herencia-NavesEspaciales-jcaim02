class Nave {
  var velocidad 
  var direccion 
  var combustible
  method velocidad() = velocidad
  method direccion() = direccion
  method combustible() = combustible
  method acelerar(unaCantidad){
    velocidad = 1000000.min(velocidad + unaCantidad)
  }
  method desacelerar(unaCantidad){
    velocidad = 0.max(velocidad - unaCantidad)
  }
  method irHaciaElSol(){
    direccion = 10
  }
  method escaparDelSol(){
    direccion = -10
  }
  method ponerseParaLeloAlSol(){
    direccion = 0
  }
  method acerCarseUnPocoAlSol(){
    direccion = 10.min(direccion + 1)
  }
  method alejarseUnPocoDelSol(){
    direccion = -10.max(direccion - 1)
  }
  method cargarCombustible(unaCantidad){
    combustible += unaCantidad
  }
  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method estaTranquila(){
    return (combustible >= 4000 and velocidad <= 12000)
  } 
  method recibirAmenaza(){
    self.avisar()
    self.escapar()
  }
  method escapar() {}
  method avisar() {}
  method estaDeRelajo(){
    return self.estaTranquila()
  }
}
class NaveBaliza inherits Nave{
  var baliza = "rojo"
  const coloresCambiados =[]
  method cambiarColorDeBaliza(unColor){
    coloresCambiados.add(unColor)
    baliza = unColor
  }
  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaLeloAlSol()
    super()
  }
  override method estaTranquila(){
    return (baliza != "rojo" and super())
  }
  override method escapar(){
    self.irHaciaElSol()
  }
  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
  override method estaDeRelajo(){
    return (coloresCambiados.isEmpty() and super())
  }
}
class NaveDePasajeros inherits Nave{
  const cantPasajeros
  var cantComida
  var cantBebida
  var racionesServidas 
  method racionesServidas(cant){
    racionesServidas += cant
  }
  method cargarComida(cant){
    cantComida = cantComida + cant
  }
  method cargarBebida(cant){
    cantBebida = cantBebida + cant
  }
  method descargarComida(cant){
    cantComida -= cant
  }
  method descargarBebida(cant){
    cantBebida -= cant
  }
  override method prepararViaje(){
    self.cargarComida(4 * cantPasajeros)
    self.cargarBebida(6 * cantPasajeros)
    self.acerCarseUnPocoAlSol()
    super()
  }
  override method escapar(){
    velocidad = velocidad * 2
  }
  override method avisar(){
    self.descargarBebida(2 * cantPasajeros)
    self.descargarComida(1 * cantPasajeros)
    self.racionesServidas(2 * cantPasajeros + 1 * cantPasajeros)
  }
  override method estaDeRelajo(){
    return (racionesServidas < 50 and super())
  }
}
class NaveDeCombate inherits Nave{
  var estaInvisible
  var misilesDesplegados
  const mensajesEmitidos = []
  method ponerseVisible(){
    estaInvisible = false
  }
  method ponerseInvisible(){
    estaInvisible = true
  }
  method estaInvisible(){
    return estaInvisible
  }
  method desplegarMisiles(){
    misilesDesplegados = true
  }
  method replegarMisiles(){
    misilesDesplegados = false
  }
  method misilesDesplegados(){
    return misilesDesplegados
  }
  method emitirMensaje(unMensaje){
    mensajesEmitidos.add(unMensaje)
    return(unMensaje)
  }
  method mensajesEmitidos(){
    return mensajesEmitidos
  }
  method primerMensajeEmitido(){
    return mensajesEmitidos.first()
  }
  method ultimoMensajeEmitido(){
    return mensajesEmitidos.last()
  } 
  method esEscueta(){}
  method emitioMensaje(unMensaje){
    return mensajesEmitidos.contains(unMensaje)
  }
  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("saliendoEnMision")
    super()
  }
  override method estaTranquila(){
    return (self.misilesDesplegados() and super())
  }
  override method escapar(){
    self.acerCarseUnPocoAlSol()
    self.acerCarseUnPocoAlSol()
  }
  override method avisar(){
    self.emitirMensaje("amenaza recibida")
  }
}
class NaveHospital inherits NaveDePasajeros{
  var quirofanoPreparados
  method estaElquirofanoPreparado() = quirofanoPreparados
  method quirofanoPreparado(){
    quirofanoPreparados = true
  }
  method quirofanoOcupado(){
    quirofanoPreparados = false
  }
  override method estaTranquila(){
    return ( not self.estaElquirofanoPreparado() and super())
  }
  override method recibirAmenaza(){
    super()
    self.quirofanoPreparado()
  }
}
class NaveDeCombateSigilosa inherits NaveDeCombate{
  override method estaTranquila(){
    return ( not self.estaInvisible() and super()) 
  }
  override method recibirAmenaza(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}
