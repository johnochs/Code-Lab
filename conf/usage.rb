module RBPGDocs
  def self.man_page(opts)
    <<~USAGE
        NAME

          rbpg - work with examples and create new ones for the Ruby Playground.

        SYNOPSIS

          rbpg [-cqh] [-l [-t TOPIC [-e EXAMPLE]]]

        DESCRIPTION

          There is functionality built into this command to expand on the existing
          topics and examples (-c for create-mode which is an interactive mode),
          but the main intent of the tool is to help navigate the library.
          Options available:

          #{opts}
      USAGE
  end
end
