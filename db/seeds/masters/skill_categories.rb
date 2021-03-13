skill_categories_array = %w[Web制作 Web開発 動画編集 デザイン ライティング マーケティング]

print 'Create SkillCategories'
skill_categories_array.each do |category|
  SkillCategory.find_or_create_by!(
    name: category
  )
  print '.'
end

puts 'done!'
