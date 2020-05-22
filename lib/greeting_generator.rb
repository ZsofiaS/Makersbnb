class GreetingGenerator

  @@greetings = [
    "Inter-galactic greetings, ",
    "vjIjatlh, ",
    "Log date welcoming to ",
    "Hello Space Captain ",
    "May the force be with you, ",
    "I am your father, ",
    "Phone... home... ",
    "I'm sorry. I can't let you do that ",
    "Soylent Green is people... ",
    "Speak friend and enter, ",
    "Apes together strong! ",
    "Chewie! We're home with ",
    "You are a leaf on the wind ",
    "You are one with the force ",
    "There is no spoon, ",
    "To infinity and ",
    "Why so serious? ",
  ]

  def self.greet
    @@greetings.sample
  end
end