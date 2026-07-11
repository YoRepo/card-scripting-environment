--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Arcana Force IV - The Emperor  (ID: 61175706)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1400 | DEF 1400
-- Setcode: 0x5
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Summoned: Toss a coin.
-- ● Heads: All "Arcana Force" monsters you control gain 500 ATK.
-- ● Tails: All "Arcana Force" monsters you control lose 500 ATK.
--[[ __CARD_HEADER_END__ ]]

--アルカナフォースⅣ－THE EMPEROR
function c61175706.initial_effect(c)
	--coin
	aux.EnableArcanaCoin(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP_SUMMON_SUCCESS,EVENT_SPSUMMON_SUCCESS)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(aux.ArcanaCondition)
	e1:SetTarget(c61175706.atktg)
	e1:SetValue(c61175706.atkval)
	c:RegisterEffect(e1)
end
function c61175706.atktg(e,c)
	return c:IsSetCard(0x5)
end
function c61175706.atkval(e,c)
	if e:GetHandler():GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)==1 then
		return 500
	else
		return -500
	end
end
