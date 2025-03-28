class Character:
    def __init__(self, name, health, *enemy):
        self.name = name
        self.health = health
    def attack(self, enemy:):
        print(f'{self.name}이(가) {enemy.name}을(를) 공격합니다 !')
    def attacked(self, health):

class Warrior(Character):
    def __init__(self, name, health, armor)
        super().__init__
        self.armor = armor
    def attack(self):
        super().attack