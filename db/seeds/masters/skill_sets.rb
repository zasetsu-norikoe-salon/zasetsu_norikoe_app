# スキルセットを配列で用意
web_kaihatsu_skills =
  %w[Ruby\ on\ Rails PHP CakePHP Laravel Java JavaScript Python MySQL Figma PostgreSQL SQL\ Server Oracle Docker AWS GCP Linux Swift Flutter Kotlin Android\ Java React Vue.js Node.js Nuxt.js HTML/CSS jQuery Git 要件定義 基本設計 詳細設計 DB設計 ディレクター]

web_seisaku_skills =
  %w[WordPress LP ホームページ HTML/CSS HTML/CSS jQuery JavaScript Git 営業 XD figma Photoshop Illustrator PHP サイト設計 ディレクター SEO MEO]

web_design_skills =
  %w[XD figma Photoshop Illustrator ディレクター 営業 サイト設計 SEO UI/UX イラスト CG ゲーム ファッション バナー制作]

video_edit_skills =
  %w[Premiere\ Pro Final\ Cut\ Pro\ X After\ Effects ディレクター 営業 動画撮影 テロップ アニメーション Vyond YouTube TikTok 営業]

writing_skills =
  %w[SEO MEO WordPress ディレクター ブログ 自社メディア Twitter 営業 HTML/CSS]

marketing_skills =
  %w[SEO SNS YouTube Instagram Lステップ Twitter Webマーケティング ディレクター MEO リスティング広告 ディスプレイ広告 SNS広告 サイト設計 営業 クラウドファンディング]

skill_sets_array = []

# スキルセットのハッシュをまとめる
web_kaihatsu = SkillCategory.find_by(name: 'Web開発')
web_kaihatsu_skills.each do |skill|
  skill_sets_array << { name: skill, skill_category: web_kaihatsu }
end

web_seisaku = SkillCategory.find_by(name: 'Web制作')
web_seisaku_skills.each do |skill|
  skill_sets_array << { name: skill, skill_category: web_seisaku }
end

web_design = SkillCategory.find_by(name: 'デザイン')
web_design_skills.each do |skill|
  skill_sets_array << { name: skill, skill_category: web_design }
end

video_edit = SkillCategory.find_by(name: '動画編集')
video_edit_skills.each do |skill|
  skill_sets_array << { name: skill, skill_category: video_edit }
end

writing = SkillCategory.find_by(name: 'ライティング')
writing_skills.each do |skill|
  skill_sets_array << { name: skill, skill_category: writing }
end

marketing = SkillCategory.find_by(name: 'マーケティング')
marketing_skills.each do |skill|
  skill_sets_array << { name: skill, skill_category: marketing }
end

print 'Create SkillSet'
skill_sets_array.each do |skill_set|
  SkillSet.find_or_create_by!(skill_set)
  print '.'
end

puts 'done!'
