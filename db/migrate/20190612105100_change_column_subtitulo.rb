class ChangeColumnSubtitulo < ActiveRecord::Migration[7.1]
  def change
    change_table :posts do |t|
      t.change :subtitulo, :text
    end
  end
end
