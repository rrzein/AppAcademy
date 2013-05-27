# -*- coding: utf-8 -*-

class Card

  SUITS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  VALUES = {
    :two => "2",
    :three => "3",
    :four => "4",
    :five => "5",
    :six => "6",
    :seven => "7",
    :eight => "8",
    :nine => "9",
    :ten => "10",
    :jack => "J",
    :queen => "Q",
    :king => "K",
    :ace => "A"
  }

  POKER_VALUES = {
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13,
    :ace => 14
  }

  def self.suits
    SUITS.keys

  end

  def self.values
    VALUES.keys

  end

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit, @value = suit, value

  end

  def point_value
    POKER_VALUE[value]
  end


  def to_s
    SUITS[suit] + VALUES[value]

  end

end
