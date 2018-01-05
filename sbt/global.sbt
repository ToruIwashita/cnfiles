// .swp等.*なファイルが変更されてもコンパイル自動コンパイルさせない
watchSources ~= {
  _.filterNot {
    f =>
      f.isDirectory ||
        """^\..*""".r.findFirstIn(f.getName).isDefined
  }
}
