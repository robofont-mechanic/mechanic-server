require 'octokit'

class GitHub::User

  attr_reader :username

  def initialize username
    @username = username
  end

  def name
    user['name'].nil? ? user.login : user.name
  end

  private

    def user
      @user ||= Octokit.user username
    end


end
