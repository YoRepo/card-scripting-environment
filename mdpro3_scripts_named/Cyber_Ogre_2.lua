--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Cyber Ogre 2  (ID: 37057012)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Machine
-- Level: 7
-- ATK 2600 | DEF 1900
-- Setcode: 0x93
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Cyber Ogre" + "Cyber Ogre"
-- A Fusion Summon of this monster can only be conducted with the above Fusion Material Monsters.
-- When this card attacks, it gains ATK equal to half the ATK of the attack target, during damage
-- calculation only.
--[[ __CARD_HEADER_END__ ]]

--サイバー・オーガ・2
function c37057012.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,64268668,2,false,false)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c37057012.atkcon)
	e1:SetValue(c37057012.atkval)
	c:RegisterEffect(e1)
end
function c37057012.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
		and e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil
end
function c37057012.atkval(e,c)
	return math.ceil(Duel.GetAttackTarget():GetAttack()/2)
end
