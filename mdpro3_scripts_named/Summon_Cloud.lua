--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 召唤云  (ID: 55375684)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上没有怪兽存在的场合，可以从自己的手卡或者墓地把1只4星以下的名字带有「云魔物」的怪兽特殊召唤。这个效果1回合只有1次在自己的主要阶段才能使用。从墓地特殊召唤的场合这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--召喚雲
function c55375684.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(55375684,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c55375684.condition)
	e2:SetTarget(c55375684.target)
	e2:SetOperation(c55375684.operation)
	c:RegisterEffect(e2)
end
function c55375684.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c55375684.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x18) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c55375684.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c55375684.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c55375684.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c55375684.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		local grav=g:GetFirst():IsLocation(LOCATION_GRAVE)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		if grav then Duel.Destroy(e:GetHandler(),REASON_EFFECT) end
	end
end
