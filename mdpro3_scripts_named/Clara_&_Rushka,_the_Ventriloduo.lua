--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 副语术士克拉拉与洛希卡  (ID: 1482001)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Spellcaster
-- ATK 0 | LINK
--
-- Effect Text:
-- 通常召唤的怪兽1只
-- 这张卡的连接召唤不在主要阶段2不能进行。
--[[ __CARD_HEADER_END__ ]]

--副話術士クララ＆ルーシカ
function c1482001.initial_effect(c)
	c:EnableReviveLimit()
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsSummonType,SUMMON_TYPE_NORMAL),1,1)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_COST)
	e1:SetCost(c1482001.spcost)
	c:RegisterEffect(e1)
end
function c1482001.spcost(e,c,tp,st)
	if bit.band(st,SUMMON_TYPE_LINK)~=SUMMON_TYPE_LINK then return true end
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
