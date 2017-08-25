watchSources ~= {
  _.filterNot {
    f =>
      f.isDirectory ||
        """^\..*""".r.findFirstIn(f.getName).isDefined
  }
}
