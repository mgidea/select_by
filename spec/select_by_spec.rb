require 'spec_helper'

describe SelectBy do
  it 'has a version number' do
    expect(SelectBy::VERSION).not_to be nil
  end

  context 'select_by' do
    it 'returns truthy elements with hash argument' do
      expect(["Chris", "Hill"].select_by(:size => 5)).to eq(["Chris"])
      expect(["Chris", "Hill"].select_by(:size => 5, &:upcase)).to eq(["CHRIS"])
    end

    it 'returns truthy elements with symbol or string argument' do
      expect(["Chris", "Hill"].select_by(:empty?)).to eq([])
      expect(["Chris", "Hill"].select_by("empty?", &:upcase)).to eq([])
    end

    it 'returns self when no argument or nil is given' do
      expect(["Chris", "Hill"].select_by).to eq(["Chris", "Hill"])
      expect(["Chris", "Hill"].select_by(nil, &:upcase)).to eq(["CHRIS", "HILL"])
    end
  end

  context 'reject_by' do
    it 'returns truthy elements with hash argument' do
      expect(["Chris", "Hill"].reject_by(:size => 5)).to eq(["Hill"])
      expect(["Chris", "Hill"].reject_by(:size => 5, &:upcase)).to eq(["HILL"])
    end

    it 'returns truthy elements with symbol or string argument' do
      expect(["Chris", "Hill"].reject_by(:empty?)).to eq(["Chris", "Hill"])
      expect(["Chris", "Hill"].reject_by("empty?", &:upcase)).to eq(["CHRIS", "HILL"])
    end

    it 'returns self when no argument or nil is given' do
      expect(["Chris", "Hill"].reject_by).to eq(["Chris", "Hill"])
      expect(["Chris", "Hill"].reject_by(nil, &:upcase)).to eq(["CHRIS", "HILL"])
    end
  end

  context 'detect_by' do
    it 'returns first truthy element with hash argument' do
      expect(["Chris", "Hill"].detect_by(:size => 5)).to eq("Chris")
      expect(["Chris", "Hill"].detect_by(:size => 5, &:upcase)).to eq("CHRIS")
    end

    it 'returns truthy elements with symbol or string argument' do
      expect(["Chris", "Hill"].detect_by(:empty?)).to eq(nil)
      expect(["Chris", "Hill", ""].detect_by("empty?", &:upcase)).to eq("")
    end

    it 'returns self when no argument or nil is given' do
      expect(["Chris", "Hill"].detect_by).to eq("Chris")
      expect(["Chris", "Hill"].detect_by(nil, &:upcase)).to eq("CHRIS")
    end
  end

  context 'partition_by' do
    it 'returns two arrays with hash argument' do
      expect(["Chris", "Hill"].partition_by(:size => 5)).to eq([["Chris"], ["Hill"]])
      expect(["Chris", "Hill"].partition_by(:size => 5, &:upcase)).to eq([["CHRIS"], ["HILL"]])
    end

    it 'returns two arrays with symbol or string argument' do
      expect(["Chris", "Hill"].partition_by(:empty?)).to eq([[],["Chris", "Hill"]])
      expect(["Chris", "Hill"].partition_by("empty?", &:upcase)).to eq([[],["CHRIS", "HILL"]])
    end

    it 'returns two arrays when no argument or nil is given' do
      expect(["Chris", "Hill"].partition_by).to eq([["Chris", "Hill"],[]])
      expect(["Chris", "Hill"].partition_by(nil, &:upcase)).to eq([["CHRIS", "HILL"],[]])
    end
  end

end
