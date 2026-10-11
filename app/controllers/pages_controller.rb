class PagesController < ApplicationController
  def dashboard
    @total_keys = TranslationKey.count
    @translated_keys = TranslationKey.where(state: :translated).count
    @pending_keys = TranslationKey.where(state: :pending).count

    @games_stats = Game.left_joins(:translation_keys)
                      .select('games.*, COUNT(translation_keys.id) as keys_count')
                      .group('games.id')
                      .order('games.name')

    @locales_stats = Translation.group(:locale).count
  end
end
