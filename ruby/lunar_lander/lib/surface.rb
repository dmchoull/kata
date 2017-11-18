class Surface < Chingu::GameObject
  trait :collision_detection

  def bounding_box
    Chingu::Rect.new([0, GameWindow::Y_RES - 25, GameWindow::X_RES, 25])
  end

  def draw
    Gosu::draw_rect(0, GameWindow::Y_RES - 25, GameWindow::X_RES, 25, Gosu::Color::GRAY)
  end
end