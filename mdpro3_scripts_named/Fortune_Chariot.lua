--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Fortune Chariot  (ID: 39299733)
-- Type: Monster / Effect / Union
-- Attribute: WIND
-- Race: Fairy
-- Level: 6
-- ATK 1000 | DEF 2000
-- Setcode: 0x122
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is also always treated as a "Valkyrie" card.)
-- Once per turn, you can either: Target 1 Fairy monster you control; equip this card to that target,
-- OR: Unequip this card and Special Summon it.
-- If the equipped monster would be destroyed by battle or card effect, destroy this card instead.
-- The equipped monster can attack directly, but when it does so using this effect, the battle damage
-- inflicted to your opponent is halved.
--[[ __CARD_HEADER_END__ ]]

--運命の戦車
function c39299733.initial_effect(c)
	aux.EnableUnionAttribute(c,c39299733.filter)
	--direct attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e5)
	--damage reduce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e6:SetCondition(c39299733.rdcon)
	e6:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
	c:RegisterEffect(e6)
end
function c39299733.filter(c)
	return c:IsRace(RACE_FAIRY)
end
function c39299733.rdcon(e)
	local c=e:GetHandler():GetEquipTarget()
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
