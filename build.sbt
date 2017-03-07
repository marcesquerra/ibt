
watchSources := {
  val finderIdris: PathFinder = file("src") ** "*.idr"
  val finderC: PathFinder = file("src") ** "*.c"
  val finderCPP: PathFinder = file("src") ** "*.cpp"
  finderIdris.get ++ finderC.get ++ finderCPP.get
}
