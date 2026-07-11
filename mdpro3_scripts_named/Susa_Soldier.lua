--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Susa Soldier  (ID: 40473581)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Thunder
-- Level: 4
-- ATK 2000 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Special Summoned.
-- This card returns to the owner's hand during the End Phase of the turn that this card is Normal
-- Summoned or flipped face-up.
-- The Battle Damage this card inflicts to your opponent's Life Points is halved.
--[[ __CARD_HEADER_END__ ]]

--雷帝神
function c40473581.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--half damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e4:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
	c:RegisterEffect(e4)
end
