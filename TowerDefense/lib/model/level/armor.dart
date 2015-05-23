part of level;
/**
   * Enum for Armor Types
   */
class Armor{
	/**
   * Value of an Armor Type
   */
final value;
/**
   * Constant Constructor for Armor
   */
 const Armor(this.value);
 /**
   * writes the Value of an Armor Type as String
   */
 toString() => 'Enum.$value';

 /**
   * Define Enum for Light Armor Type
   */
 static const light = const Armor(1);
 /**
   * Define Enum for medium Armor Type
   */
 static const medium = const Armor(2);
 /**
   * Define Enum for heavy Armor Type
   */
 static const heavy = const Armor(3);
}