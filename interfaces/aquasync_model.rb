class AquasyncModel
  def aq_deltas
    raise NotImplementedError, "Implement this method in a child class."
  end

  def aq_commit_deltas
    raise NotImplementedError, "Implement this method in a child class."
  end
end