# -*- encoding : utf-8 -*-
module GitStats
  class Generator
    delegate :add_command_observer, to: :@repo
    delegate :render_all, to: :@view

    def initialize(repo_path, out_path, first_commit_sha = nil, last_commit_sha = "HEAD")
      validate_repo_path(repo_path)

      @repo = GitData::Repo.new(path: repo_path, first_commit_sha: first_commit_sha, last_commit_sha: last_commit_sha)
      view_data = StatsView::ViewData.new(@repo)
      @view = StatsView::View.new(view_data, out_path)

      yield self if block_given?
    end

    private


    def validate_repo_path(repo_path)
      raise ArgumentError, "#{repo_path} is not a git repository" unless Validator.new.valid_repo_path?(repo_path)
    end

  end

end
