class Strategy
  def read(file_path)
    raise NotImplementedError, 'Method not implemented.'
  end

  def write(file_path, content)
    raise NotImplementedError, 'Method not implemented.'
  end
end
