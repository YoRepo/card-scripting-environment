--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Swift Gaia the Fierce Knight  (ID: 16589042)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 7
-- ATK 2300 | DEF 2100
-- Setcode: 0xbd
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this is the only card in your hand, you can Normal Summon this card without Tributing.
--[[ __CARD_HEADER_END__ ]]

--疾風の暗黒騎士ガイア
function c16589042.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16589042,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c16589042.ntcon)
	c:RegisterEffect(e1)
end
function c16589042.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)==1
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
