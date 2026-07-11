--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Linkerbell  (ID: 54635100)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Fairy
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 monsters
-- You cannot Link Summon this card unless you have at least 3 more cards in your Extra Deck than your
-- opponent's.
--[[ __CARD_HEADER_END__ ]]

--リンクルベル
function c54635100.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,2,2)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_COST)
	e1:SetCost(c54635100.spcost)
	c:RegisterEffect(e1)
end
function c54635100.spcost(e,c,tp,st)
	if bit.band(st,SUMMON_TYPE_LINK)~=SUMMON_TYPE_LINK then return true end
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)-Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)>=3
end
