require_relative 'tree' # rubocop:disable Lint/EmptyFile

new_tree = Tree.new(Array.new(15) { rand(1..100) })
p new_tree
p new_tree.balanced?
p new_tree.level_order
p new_tree.preorder
p new_tree.postorder
p new_tree.inorder
new_tree.insert(150)
new_tree.insert(160)
new_tree.insert(120)
new_tree.insert(135)
p new_tree.pretty_print
p new_tree.balanced?
new_tree.rebalance
p new_tree.balanced?
p new_tree.level_order
p new_tree.preorder
p new_tree.postorder
p new_tree.inorder
