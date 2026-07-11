--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ojama Knight  (ID: 40391316)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Beast
-- Level: 5
-- ATK 0 | DEF 2500
-- Setcode: 0xf
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "Ojama" monsters
-- Choose up to 2 of your opponent's unused Monster Zones.
-- Those zones cannot be used.
--[[ __CARD_HEADER_END__ ]]

--おジャマ・ナイト
function c40391316.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xf),2,true)
	--disable field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetOperation(c40391316.disop)
	c:RegisterEffect(e2)
end
function c40391316.disop(e,tp)
	local c=Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)
	if c==0 then return end
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	if c>1 and Duel.SelectYesNo(tp,aux.Stringid(40391316,0)) then
		local dis2=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
		dis1=bit.bor(dis1,dis2)
	end
	return dis1
end
