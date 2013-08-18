require 'rspec'
require File.expand_path(File.join(__FILE__, '../../sort/insertion_sort.rb'))
require File.expand_path(File.join(__FILE__, '../../sort/quick_sort.rb'))

UNSORTED = [10, 13, 7, 13, 1]
SORTED = [1, 7, 10, 13, 13]
REVERSED = [13, 13, 10, 7, 1]

shared_examples 'sort' do
  it 'sorts a one element array' do
    expect(sort([1])).to eq([1])
  end

  it 'sorts an already sorted two element array' do
    expect(sort([1, 2])).to eq([1, 2])
  end

  it 'sorts an unsorted two element array' do
    expect(sort([2, 1])).to eq([1, 2])
  end

  it 'sorts a randomly distributed array' do
    expect(sort(UNSORTED)).to eq(SORTED)
  end

  it 'leaves an already sorted array alone' do
    expect(sort(SORTED)).to eq(SORTED)
  end

  it 'sorts a worst-case reversed array' do
    expect(sort(REVERSED)).to eq(SORTED)
  end

  def sort(array)
    array.dup.send(sort_method_name)
  end
end

describe 'Insertion Sort' do
  include_examples 'sort'
  let(:sort_method_name) { :insertion_sort! }

  describe '(private) insert_current_value' do
    it 'swaps the elements in a two element array that is out of order' do
      a = [10, 1]
      a.send(:insert_current_value, 1)
      expect(a).to eq([1, 10])
    end
  end
end

describe 'Quick Sort' do
  include_examples 'sort'
  let(:sort_method_name) { :quick_sort! }

  describe '(private) move_pivot_to_end' do
    it 'swaps the pivot location with the last element' do
      array = SORTED.dup
      array.send(:move_pivot_to_end, 1)
      expect(array).to eq([1, 13, 10, 13, 7])
    end
  end

  describe '(private) swap_with_smaller_value' do
    it 'swaps with the first smaller value and returns true' do
      a = [3, 1, 2]
      expect(a.send(:swap_with_smaller_value, 0, 2)).to be_true
      expect(a).to eq([1,3,2])
    end

    it 'returns false when no swap is made' do
      a = [1, 3, 4, 2]
      expect(a.send(:swap_with_smaller_value, 1, 2)).to be_false
      expect(a).to eq([1, 3, 4, 2])
    end
  end

  describe '(private) replace_pivot' do
    it 'swaps the last element with the provided index' do
      a = [3, 1, 8, 4]
      a.send(:replace_pivot, 2)
      expect(a).to eq([3, 1, 4, 8])
    end
  end

  describe '(private) find_index_of_value_smaller_than_pivot' do

    context 'nothing is found' do
      let(:first) { 0 }
      let(:last) { REVERSED.length - 1 }
      let(:pivot_value) { 0 }
      it 'returns nil' do
        val = REVERSED.dup.send(:find_index_of_value_smaller_than_pivot, first, last, pivot_value)
        expect(val).to be_nil
      end
    end

    context 'the pivot value is larger than all elements' do
      let(:first) { 0 }
      let(:last) { REVERSED.length - 1 }
      let(:pivot_value) { 15 }
      it 'returns the first index' do
        val = REVERSED.dup.send(:find_index_of_value_smaller_than_pivot, first, last, pivot_value)
        expect(REVERSED[val]).to eq(13)
      end
    end


    context 'the pivot value is equal to an element' do
      let(:first) { 0 }
      let(:last) { REVERSED.length - 1 }
      let(:pivot_value) { 10 }
      it 'returns the index that hold the same value' do
        val = REVERSED.dup.send(:find_index_of_value_smaller_than_pivot, first, last, pivot_value)
        expect(REVERSED[val]).to eq(10)
      end
    end


    context 'a subset is specified' do
      let(:first) { 2 }
      let(:last) { REVERSED.length - 1 }
      let(:pivot_value) { 15 }
      it 'indexes outside of the subset are not returned' do
        val = REVERSED.dup.send(:find_index_of_value_smaller_than_pivot, first, last, pivot_value)
        expect(REVERSED[val]).to eq(10)
      end
    end
  end
end