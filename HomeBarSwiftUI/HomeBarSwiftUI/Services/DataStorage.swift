//
//  DataStorage.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 03.03.2023.
//

import Foundation

class IngredientDataStorage {
        
    let ingredients = ["Absinthe", "Absolut Citron", "Absolut Kurant", "Absolut Peppar", "Absolut Vodka", "Advocaat", "Agave Syrup", "Ale", "Almond flavoring", "Amaretto", "Amaro Montenegro", "Rum", "Angelica root", "Angostura bitters", "Anis", "Anise", "Anisette", "Aperol", "Apfelkorn", "Apple", "Apple brandy", "Apple cider", "Apple juice", "Apple schnapps", "Apple jack", "Apricot", "Apricot brandy", "Apricot Nectar", "Aqua vit", "Asafoetida", "Bacardi", "Bacardi Irish cream", "Bacardi Kahlua", "Bacardi Light rum", "Bacardi Limon", "Bacardi Amaretto", "Bacardiliano", "Baileys irish cream", "Banana", "Banana liqueur", "Basil", "Guinness stout", "Beaten Chocolate", "Beer", "Benedictine", "Berries", "Bitter lemon", "Bitters", "Black pepper", "Black Rum", "Black Sambuca", "Blackberries", "Blackberry brandy", "Blackcurrant cordial", "Blackcurrant squash", "Blended ", "Blended whiskey", "blue Almond flavoring", "Blue Curacao", "Blue Ice", "Blueberries", "Corn syrup", "Boone Strawberry Hill", "Bourbon", "Brandy", "Brown sugar", "Butter Scotch", "Butterscotch schnapps", "Cachaca", "Campari", "Candy", "Cantaloupe", "caramel sauce", "Carbonated soft drink", "Carbonated water", "Cardamom", "Carrot", "Cayenne pepper", "Celery salt", "Chambord raspberry liqueur", "Champagne", "Cherry", "Cherry brandy", "Cherry Grenadine", "Cherry Heering", "Cherry Juice", "Cherry liqueur", "Chilled", "Chilled Berries", "Chilled Maraschino cherry", "Chilled Orange juice", "Chilled Sugar", "Chocolate", "Chocolate ice-cream", "Chocolate liqueur", "Chocolate milk", "chocolate sauce", "Chocolate syrup", "Chopped", "Chopped Ginger", "Chopped Ginger Beer", "Cider", "Cinnamon", "CoarseTequila", "Coca-Cola", "Cocoa powder", "Coconut liqueur", "Coconut milk", "Coconut rum", "Coconut syrup", "Coffee", "Coffee brandy", "Coffee liqueur", "Cognac", "Cointreau", "Condensed milk", "Coriander", "Cornstarch", "Corona", "Cranberries", "Cranberry juice", "Cranberry vodka", "Cream", "Cream of coconut", "Creme de Banane", "Creme de Cacao", "Creme de Cacao white", "Creme de Cassis", "Creme de Mure", "Crown Royal", "Cucumber", "Cumin seed", "Curacao", "Daiquiri", "Dark Creme de Cacao", "Dark rum", "demerara Sugar", "Dr. Pepper", "Drambuie", "Dry Sweet Vermouth", "Dry Vermouth", "Dubonnet Rouge", "Egg", "Egg white", "Egg yolk", "Elderflower cordial", "Erin Cream", "Espresso", "Everear", "Falernum", "Fennel seeds", "Figs", "Dark rum", "Grenadine", "liano", "Southern Comfort", "Vanilla vodka", "Firewater", "Food coloring", "Frangelico", "Fresh Cream of coconut", "Fresh Gin", "Fresh leaves", "Fresh Lemon Juice", "Fresh Lime Juice", "Fruit", "Fruit juice", "Fruit punch", "Garnish ", "Garnish Blood Orange", "Garnish Campari", "Garnish Elder flower cordial", "Garnish Fresh Lime Juice", "Garnish Gin", "Garnish Lime", "Garnish Prosecco", "Garnish Rum", "Garnish Amaretto", "Gin", "Ginger", "Ginger ale", "Ginger Beer", "Sambuca", "Glycerine", "Godiva liqueur", "Gold rum", "Gold tequila", "Goldschlager", "Grain alcohol", "Grand Marnier", "Grape", "Grape juice", "Grape soda", "Grapefruit juice", "Grapes", "GratedGin", "Green Almond", "Green Chartreuse", "Green Creme de Menthe", "Green Ginger", "Green GingerLime", "Green GingerOrange juice", "Grenadine", "Ground All spice", "Ground Lime Juice", "Ground Milk", "Ground Sugar Syrup", "Guava juice", "Guinness stout", "Half-and-half", "Heavy cream", "Honey", "Hot chocolate", "Hot Damn", "Hot Sauce", "Hot Sugar", "Hpnotiq", "Ice", "Iced tea", "instantVanilla extract", "Irish cream", "Irish whiskey", "Jack Daniels", "Jägermeister", "Jamaican", "Jamaican Angostura bitters", "Jamaican Anisette", "Jamaican Red wine", "Jello", "Jim Beam", "Johnnie Walker", "Juice of Banana", "Juice of Cherry", "Juice of Cointreau", "Juice of Powdered sugar", "Kahlua", "Kiwi", "Kiwi liqueur", "Kool-Aid", "Kummel", "Lager", "Lemon", "Lemon juice", "Lemon peel", "Lemon vodka", "Lemonade", "LemonJuice ", "Lemon-lime soda", "Licorice root", "Light cream", "Light rum", "Lillet Blanc", "Lime", "Lime Juice ", "Lime peel", "Lime vodka", "Limeade", "Malibu rum", "Mango", "Maple syrup", "Maraschino cherry", "Maraschino liqueur", "Marjoram leaves", "Marshmallows", "Maui", "Melon liqueur", "Mezcal", "Midori melon liqueur", "Milk", "Mini-snickers bars", "Mint", "Mountain Dew", "Muscatel Sweet Vermouth", "Nutmeg", "Olive", "Olive Brine", "Orange", "Orange bitters", "Orange Curacao", "Orange juice", "Orange peel", "Orange spiral", "Oreo cookie", "Orgeat syrup", "Ouzo", "Papaya", "Passion fruit juice", "Passion fruit syrup", "Passoa", "Peach Bitters", "Peach brandy", "Peach nectar", "Peach schnapps", "Peach Vodka", "Peachtree schnapps", "Pepper", "Peppermint extract", "Pepsi Cola", "Pernod", "Peychaud bitters", "Piece Ginger", "Pina colada mix", "Pineapple", "Pineapple juice", "Pink lemonade", "Pisang Ambon", "Pomegranate juice", "Port", "Powdered sugar", "proof rum", "Prosecco", "Pure Water", "Raspberry Liqueur", "Raspberry syrup", "Raspberry vodka", "Red Chili Flakes", "Red Lemon peel", "Red wine", "Ricard", "Rimmed Lime", "Root beer", "Rose", "Rosemary", "Rosemary Syrup", "Roses sweetened lime juice", "Ruby Port", "Rum", "Rye whiskey", "Salt", "Salted Chocolate", "Sambuca", "Sarsaparilla", "Schweppes", "Schweppes ", "Scotch", "Sherry", "Slice Celery salt", "SliceTonic Water", "SliceVodka", "Sloe gin", "Smirnoff red label Everear", "Soda water", "Sour mix", "Southern Comfort", "Soy Sauce", "Spiced rum", "splashAbsolut Kurant", "Sprig Lime", " Sprig Tonic Water", "SprigAngostura Bitters", "SprigRaspberry Vodka", "Sprite", "Squeeze", "Stoli Ouzo", "Strawberries", "Strawberry liqueur", "Strawberry schnapps", "sub soda", "Sugar ", "Surge", "Sweet and sour", "Sweet Vermouth", "Tabasco sauce", "Tea", "Tea hot", "Tennessee whiskey", "Tequila", "Thyme", "Tia maria", "Tomato juice", "Tonic ", "Tonic water", "Triple sec", "Tropical Berry Orange juice", "Tropical proof rum", "Tropicana", "Turkish apple Absolut Kurant", "Up", "Vanilla", "Vanilla extract", "Vanilla ice-cream", "Vanilla syrup", "Vermouth", "Vodka", "Water", "Watermelon", "Wedges Rosso Vermouth", "Whipped cream", "Whipping cream", "Whiskey", "White Creme de Menthe", "White Light cream", "White rum", "White Wine", "Wild Turkey", "Wine", "Worcestershire sauce", "Wormwood", "Yellow Chartreuse", "Yoghurt", "Yukon Jack", "Zima"]
    
}