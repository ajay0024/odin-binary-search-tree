require_relative "./script.rb"

def test1
    bt = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
    # bt = Tree.new(Array.new(15) { rand(1..100) })
    bt.pretty_print
    bt.insert(2)
    print("Printing Tree after inserting 2 \n")
    bt.pretty_print
    bt.insert(15264)
    print("Printing Tree after inserting 15264 \n")
    bt.pretty_print
    # bt.delete(8)
    bt.pretty_print
    # bt.find(9)
    puts bt.height
    p bt.level_order {|x| x*x}
    newbt = Tree.new(bt.level_order)
    newbt.pretty_print
    p newbt.level_order
    bt.pretty_print
    p "In Order With block", bt.inorder {|x| x*x}
    p "In Order Without block", bt.inorder
    p "Pre Order With block", bt.preorder {|x| x*x}
    p "Pre Order Without block", bt.preorder
    p "Post Order With block", bt.postorder {|x| x*x}
    p "Post Order Without block", bt.postorder

    nodex=bt.find(2)
    p bt.depth(nodex)
    p bt.balanced?
    bt.insert(-2)
    bt.insert(-1)
    bt.pretty_print
    p bt.balanced?
    bt.delete(-1)
    bt.pretty_print
    p bt.balanced?
    bt.delete(7)
    bt.delete(5)
    bt.pretty_print
    p bt.balanced?
    bt.rebalance
    bt.pretty_print
end

def test2
    bt = Tree.new(Array.new(15) { rand(1..100) })
    puts "Printing Tree"
    bt.pretty_print
    puts "Tree is #{"not" unless bt.balanced?} balanced."
    puts "Level Order : #{bt.level_order.join(", ")}"
    puts "In Order : #{bt.inorder.join(", ")}"
    puts "Pre Order : #{bt.preorder.join(", ")}"
    puts "Post Order : #{bt.postorder.join(", ")}"
    puts "Adding 5 random numbers above 100"
    5.times {bt.insert(rand(101..200))}
    bt.pretty_print
    puts "Tree is #{"not" unless bt.balanced?} balanced."
    puts "Balancing Tree and printing tree again"
    bt.rebalance
    bt.pretty_print
    puts "Now the tree is #{"not" unless bt.balanced?} balanced."
    puts "Level Order : #{bt.level_order.join(", ")}"
    puts "In Order : #{bt.inorder.join(", ")}"
    puts "Pre Order : #{bt.preorder.join(", ")}"
    puts "Post Order : #{bt.postorder.join(", ")}"

end

test2




