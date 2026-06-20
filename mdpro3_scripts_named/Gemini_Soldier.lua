--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 二重士兵  (ID: 68366996)
-- Type: Monster / Effect / Gemini
-- Attribute: WIND
-- Race: Warrior
-- Level 2
-- ATK 500 | DEF 300
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡1回合只有1次不会被战斗破坏。这张卡进行战斗的场合，那次伤害计算后可以从自己卡组把「二重士兵」以外的1只4星以下的二重怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デュアル・ソルジャー
function c68366996.initial_effect(c)
	aux.EnableDualAttribute(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCondition(aux.IsDualState)
	e1:SetCountLimit(1)
	e1:SetValue(c68366996.valcon)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68366996,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(aux.IsDualState)
	e2:SetTarget(c68366996.target)
	e2:SetOperation(c68366996.operation)
	c:RegisterEffect(e2)
end
function c68366996.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c68366996.filter(c,e,tp)
	return not c:IsCode(68366996) and c:IsLevelBelow(4) and c:IsType(TYPE_DUAL) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68366996.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c68366996.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68366996.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68366996.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
