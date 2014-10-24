defmodule ClientsRepository do
  @bucket :chated

  def create do
    :pg2.create @bucket
  end

  def add(pid) do
    :pg2.join @bucket, pid
  end

  def members do
    :pg2.get_members @bucket
  end
end
