module UsersHelper
  def delete_all
    @tmp = User.all
    @tmp.each do |x|
      x.destroy
    end
  end
end
