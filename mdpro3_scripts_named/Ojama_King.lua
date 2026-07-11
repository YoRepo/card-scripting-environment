--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ojama King  (ID: 90140980)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Beast
-- Level: 6
-- ATK 0 | DEF 3000
-- Setcode: 0xf
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Ojama Green" + "Ojama Yellow" + "Ojama Black"
-- Choose up to 3 of your opponent's unused Monster Zones.
-- Those zones cannot be used.
--[[ __CARD_HEADER_END__ ]]

--おジャマ・キング
function c90140980.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode3(c,12482652,42941100,79335209,true,true)
	--disable field
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetOperation(c90140980.disop)
	c:RegisterEffect(e1)
end
function c90140980.disop(e,tp)
	local c=Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)
	if c==0 then return end
	local dis1=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	if c>1 and Duel.SelectYesNo(tp,aux.Stringid(90140980,0)) then
		local dis2=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
		dis1=bit.bor(dis1,dis2)
		if c>2 and Duel.SelectYesNo(tp,aux.Stringid(90140980,0)) then
			local dis3=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,dis1)
			dis1=bit.bor(dis1,dis3)
		end
	end
	return dis1
end
