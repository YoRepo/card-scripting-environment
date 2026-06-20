--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 叮当铃连接星  (ID: 54635100)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Fairy
-- ATK 1500 | LINK
--
-- Effect Text:
-- 怪兽2只
-- 这张卡的连接召唤不在自己的额外卡组的数量比对方多3张以上的场合不能进行。
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
