require 'faraday'
require 'json'
require 'pry'

class User < ActiveRecord::Base

	def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.avatar_url = auth.info.image
      user.username = auth.info.name
      user.oauth_token = auth.credentials.token
      user.repo_count = auth[:extra][:raw_info][:public_repos]
      user.repo_url = auth[:extra][:raw_info][:repos_url]
      user.commits_url = auth[:extra][:raw_info][:commits_url]
      user.save!
    end
  end

  def url_repo
    self.repo_url
  end

  def commit_url
    self.commits_url
  end

  # for getting repository information
  def get_repo_data
    res = Faraday.get(url_repo)
    @json_res = JSON.parse(res.body)
    repo_array = []
    @json_res.each do |res_repo|
      repo_array << [{"id" => res_repo["id"], "name" => res_repo["name"], "private_status" => res_repo["private"], "description"=> res_repo["owner"]["description"]}]
    end
    repo_array
  end

  # for getting commits information
    # def get_commit_data
    #   res = Faraday.get(commit_url)
    #   @json_res = JSON.parse(res.body)
    # end
end
