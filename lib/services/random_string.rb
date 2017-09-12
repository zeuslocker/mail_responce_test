class RandomString
  ABC = [('a'..'z'), ('A'..'Z')].flat_map(&:to_a)

  def self.call(min_length, max_length)
    string = (min_length...max_length).map { ABC[rand(ABC.length)] }.join
  end
end
