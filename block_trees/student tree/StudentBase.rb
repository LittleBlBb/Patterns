class StudentBase
  attr_accessor :id
  attr_reader :github

  def initialize(id: nil, github: nil)
    self.id = id if id
    self.github = github if github
  end

  def has_github?
    return true if self.github
    false
  end

  def github=(github)
    raise ArgumentError unless StudentBase.github_valid?(github)
    @github = github
  end

  # Валидация GitHub
  def self.github_valid?(github)
    github.match?(/\Ahttps:\/\/github.com\/[a-zA-Z0-9_-]+\z/)
  end

  protected

    def self.from_string()
    raise NotImplemetedError
  end

  def get_git_and_contact
    raise NotImplemetedError
  end

  def has_contact?
    raise NotImplemetedError
  end
end