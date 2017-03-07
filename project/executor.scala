package object executor{

  def apply(path: String) = {

    import java.lang.ProcessBuilder

    val builder = new ProcessBuilder(path)
    val environ = builder.environment
    builder.redirectInput (ProcessBuilder.Redirect.INHERIT)
    builder.redirectOutput(ProcessBuilder.Redirect.INHERIT)
    val process = builder.start()
    process.waitFor()
  }


}

