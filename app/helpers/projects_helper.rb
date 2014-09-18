module ProjectsHelper

  def pledging_duration(project)
    if project.expired?
      content_tag(:strong, 'All Done!')
    else
      distance_of_time_in_words(Date.today, project.pledging_ends_on)
    end
  end
end
