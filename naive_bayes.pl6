class NaiveBayes {
  has SetHash $.vocabularies is rw = SetHash.new;
  has Hash %.word_count is rw = Hash.new; # {'花粉症対策': {'スギ花粉': 4, '薬': 2,...} }
  has Int %.category_count is rw = Hash.new; # {'花粉症対策': 16, ...}

  method train(Str $doc, Str $category) {
    my @words = $doc.split(' ');
    @words.map({
      self.word_count_up($_, $category)
    });
  }

  method word_count_up(Str $word, Str $category) {
    self.word_count{$category}{$word}++;
    self.vocabularies<<$word>> = True;
  }

  method category_count_up(Str $category) {
    self.category_count{$category}++;
  }

}

my $nb = NaiveBayes.new;
$nb.train('a', 'cate1');
$nb.train('b', 'cate1');
$nb.train('c', 'cate1');
$nb.train('a', 'cate1');
$nb.category_count_up('c1');
$nb.category_count_up('c2');
$nb.category_count_up('c1');
$nb.say;
