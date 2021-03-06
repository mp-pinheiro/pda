import textwrap
import random
import time
import datetime

from ptype import PokeType
from pstats import PokeStats
from mysql import MySQL
from datetime import timedelta

class Pokemon:
	NUMBER_OF_POKEMON = 0

	def setNumberOfPokemon():
		cursor = MySQL.getCursor()
		cursor.execute("""SELECT COUNT(*) AS count FROM pokemon""")		
		row = cursor.fetchone()
		Pokemon.NUMBER_OF_POKEMON = row['count']

	def __init__(self, name, level, wild=1, iv=None, experience=0, pokemonId=0, ownId=0, currentHp=-1, healing=None, caughtWith=0, customHp=1, mega=False, inDayCare=None, dayCareLevel=None):
		cursor = MySQL.getCursor()

		self.wild = wild
		self.ownId = ownId
		self.healing = healing
		self.caughtWith = caughtWith
		self.mega = mega
		self.inDayCare = inDayCare
		self.dayCareLevel = dayCareLevel
		
		if pokemonId == 0:
			if mega and '-mega' not in name:
				name = name + "%mega%"
			cursor.execute("""SELECT * FROM pokemon WHERE pokemon.identifier LIKE %s""", (name,))
			row = cursor.fetchone()
			pId = row['id']
		else:
			cursor.execute("""SELECT * FROM pokemon WHERE pokemon.id = %s""", (pokemonId,))		
			row = cursor.fetchone()
			name = row['identifier']
			pId = pokemonId
			if mega and '-mega' not in name:
				name = name + "%mega%"
				cursor.execute("""SELECT * FROM pokemon WHERE pokemon.identifier LIKE %s""", (name,))
				row = cursor.fetchone()
				pId = row['id']
			

		self.name = row['identifier'].upper()
		self.captureRate = row['capture_rate']
		self.candyDrop = row['candy_drop']
		self.yieldEv = row['yield_ev']
		self.evolvedAtLevel = row['evolved_at_level']

		cursor.execute("""
			SELECT * FROM `type` JOIN pokemon_type 
			WHERE pokemon_type.pokemon_id = %s 
			AND `type`.id = pokemon_type.type_id
			""", (pId,))		
		rows = cursor.fetchall()
		
		self.types = []
		for row in rows:
			t = PokeType(row['type_id'], row['identifier'])
			self.types.append(t)

		cursor.execute("""
			SELECT * FROM pokemon_stat JOIN stat
			WHERE pokemon_stat.pokemon_id = %s 
			AND stat.id = pokemon_stat.stat_id
			""", (pId,))	
		rows = cursor.fetchall()
		
		stats = {}
		if not iv:
			iv = {}

		for row in rows:
			stats[row['identifier']] = row['base_stat']
			if row['identifier'] not in iv:
				iv[row['identifier']] = random.randint(1, 31)
		self.pokeStats = PokeStats(stats, level, iv, currentHp, customHp)

		self.pId = pId
		self.experience = experience if experience!=0 else self.calculateExp(level)

	def getAverageIV(self):
		ivAverage = 0
		for key, value in self.pokeStats.iv.items():
			ivAverage += value
		ivAverage = ivAverage // len(self.pokeStats.iv)

		return ivAverage

	def __str__(self):
		t = self.types[0].identifier
		caughtStrings = ['Starter','Poke Ball', 'Great Ball', 'Ultra Ball', 'Master Ball', '💸', 'Giveaway', '🎃', '🎅']
		try: 
			t = t + ', ' + self.types[1].identifier
		except IndexError:
			pass

		ivAverage = self.getAverageIV()

		isHealing, delta = self.isHealing()
		deltaStr = Pokemon.convertDeltaToHuman(delta)
		healingStr = '- **__Heals in *{}*__**'.format(deltaStr) if isHealing else ''

		evolvesStr = ''
		evolutions = self.getEvolutions()
		if evolutions:
			evolvesStr = '\n**Evolutions: **'
			for e in evolutions:
				evolvesStr += '{} at level {}, '.format(e.name, e.evolvedAtLevel)
			evolvesStr = evolvesStr[:-2] + '.'

		return textwrap.dedent("""
__Information:__

**ID:** %d
**Name:** %s
**Pokedex:** %d
**Level:** %s
**Types:** %s
**Caught with:** %s%s

__Stats and IV:__

**HP:** %d/%d (%d/31) %s
**Attack:** %d (%d/31)
**Defense:** %d (%d/31)
**Sp. Attack:** %d (%d/31)
**Sp. Defense:** %d (%d/31)
**Speed:** %d (%d/31)
**Average IV:** %d/31

__Experience:__

**Next level:** %d EXP""") % (
			self.ownId, 
			self.name, 
			self.pId, 
			self.pokeStats.level,
			t,
			caughtStrings[self.caughtWith],
			evolvesStr,
			self.pokeStats.hp,
			self.pokeStats.current['hp'], 
			self.pokeStats.iv['hp'],
			healingStr,
			self.pokeStats.fakeCurrent['attack'], 
			self.pokeStats.iv['attack'],
			self.pokeStats.fakeCurrent['defense'], 
			self.pokeStats.iv['defense'],
			self.pokeStats.fakeCurrent['special-attack'], 
			self.pokeStats.iv['special-attack'],
			self.pokeStats.fakeCurrent['special-defense'], 
			self.pokeStats.iv['special-defense'],
			self.pokeStats.current['speed'],
			self.pokeStats.iv['speed'],
			ivAverage,
			max(self.getNextLevelExp() - self.experience, 0) if self.pokeStats.level < 100 else 0)

	def damage(self, damage):
		if self.pokeStats.hp>damage:
			self.pokeStats.hp -= damage
			return False
		else:
			self.pokeStats.hp = 0
			return True

	def getNextLevelExp(self):
		return self.calculateExp(self.pokeStats.level + 1)

	def calculateExp(self, level):
		exp = (6/5) * (level**3) - 15*(level**2) + 100*level - 140
		return exp if exp>0 else 0

	def evolve(self, evolution):
		self.pId = evolution.pId
		self.name = evolution.name
		self.pokeStats = evolution.pokeStats
		self.types = evolution.types
		self.mega = evolution.mega

	megaTime = 300
	def getMegaTime(self):
		return (datetime.datetime.now().timestamp() - self.mega.timestamp())

	def canMegaEvolve(self):
		cursor = MySQL.getCursor()
		
		name = self.name + "%mega%"
		cursor.execute("""SELECT * FROM pokemon WHERE pokemon.identifier LIKE %s""", (name,))
		
		return cursor.fetchone() is not None

	def megaEvolve(self, pokemon=None):
		if not pokemon:
			pokemon = Pokemon(name=self.name, level=self.pokeStats.level, wild=self.wild, iv=self.pokeStats.iv)
		pokemon.mega = True

		self.evolve(pokemon)

	def hasEvolved(self):
		return self.getEvolutions(True)

	def getMegaEvolutions(self):
		cursor = MySQL.getCursor()
		
		name = self.name + "%mega%"
		cursor.execute("""
			SELECT * FROM pokemon 
			WHERE pokemon.identifier LIKE %s
		""", (name,))
		rows = cursor.fetchall()
		
		megaEvolutions = []
		for row in rows:
			megaEvolutions.append(Pokemon(row['identifier'], self.pokeStats.level, self.wild, self.pokeStats.iv))

		return megaEvolutions

	def getEvolutions(self, leveLimit=False):
		cursor = MySQL.getCursor()
		cursor.execute("""
			SELECT * FROM pokemon
			WHERE pokemon.evolves_from_species_id = %s
			""", (self.pId,))		
		rows = cursor.fetchall()

		evolutions = []

		if rows:
			for row in rows:
				evolveLevel = row['evolved_at_level']
				if not leveLimit or self.pokeStats.level >= evolveLevel:
					evolutions.append(Pokemon(row['identifier'], self.pokeStats.level, self.wild, self.pokeStats.iv))

		return evolutions

	def isWild(self):
		return self.wild==1

	ballRatios = [1, 1.5, 2, 255]
	def attemptCapture(self, ball, playerMod=1):
		chance = 1.5 * ((2*self.pokeStats.current['hp']) * self.captureRate * Pokemon.ballRatios[ball]) / (3*self.pokeStats.current['hp']) + random.randint(0, 225)*playerMod
		random.seed()
		dice = random.randint(0, 225)
		# print('Capture chance is: {}/{}'.format(dice, chance))
		return chance >= dice

	def setLevel(self, level):
		self.experience = self.calculateExp(level)
		self.pokeStats.level = level
		while True:
			if not self.hasEvolved():
				break

	def addExperience(self, experience):
		if self.pokeStats.level == 100 or self.isWild():
			return [False, False]

		self.experience += experience
		if self.experience >= self.getNextLevelExp():
			self.pokeStats.level += 1
			self.evolve(Pokemon(self.name, self.pokeStats.level, self.wild, self.pokeStats.iv))
			return [True, self.hasEvolved()]
		else:
			return [False, False]

	healingTimeMultiplier = 3 # k*level seconds
	def isHealing(self):
		healing = self.healing
		deltaHp = 1 - (self.pokeStats.hp/self.pokeStats.current['hp'])
		healTime = Pokemon.healingTimeMultiplier*self.pokeStats.level*deltaHp
		if healing:
			deltaTime = datetime.datetime.now().timestamp() - healing.timestamp()
			healed = deltaTime <= healTime
			if healed == False:
				self.pokeStats.hp = self.pokeStats.current['hp']
			return healed, round(healTime - deltaTime)
				
		return None, 0

	def convertDeltaToHuman(deltaTime):
		minutes = int(deltaTime/60)
		if minutes == 0:
			return '{} second(s)'.format(int(deltaTime))
		if minutes > 0:
			return '{} minute(s) and {} second(s)'.format(minutes, int(deltaTime - minutes*60))

	def isType(self, tId):
		if len(self.types)==1:
			return self.types[0].tId == tId
		else:
			return self.types[0].tId == tId or self.types[1].tId == tId

	def getMoves(self, leveLimit=False):
		cursor = MySQL.getCursor()
		
		if not leveLimit:
			cursor.execute("""
				SELECT * FROM pokemon_move JOIN move ON (pokemon_move.move_id = move.id)
				WHERE pokemon_id = %s
				AND enabled = True
			""", (self.pId, ))
		else:
			cursor.execute("""
				SELECT * FROM pokemon_move JOIN move ON (pokemon_move.move_id = move.id)
				WHERE pokemon_id = %s
				AND learned_at_level <= %s
				AND enabled = True
			""", (self.pId, self.pokeStats.level))
		rows = cursor.fetchall()

		return [row['move_id'] for row in rows]

	def getLatestNaturalMoves(self):
		cursor = MySQL.getCursor()

		cursor.execute("""
			SELECT * FROM pokemon_move JOIN move ON (pokemon_move.move_id = move.id)
			WHERE pokemon_id = %s
			AND learned_at_level <= %s
			AND enabled = True
			AND learned_at_level IS NOT NULL
			LIMIT 4
		""", (self.pId, self.pokeStats.level))
		rows = cursor.fetchall()

		if not rows:
			return [165]

		return [row['move_id'] for row in rows]

	def __repr__(self):
		return str([self.pId, self.name])