--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 机皇兵 神空一型  (ID: 75733063)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1000
-- Setcode: 24595
--
-- Effect Text:
-- 这张卡的攻击力上升这张卡以外的场上表侧表示存在的名字带有「机皇」的怪兽数量×200的数值。这张卡被战斗破坏送去墓地时，可以从自己卡组把1只名字带有「机皇兵」的怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--機皇兵スキエル・アイン
function c75733063.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c75733063.val)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75733063,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c75733063.condition)
	e2:SetTarget(c75733063.target)
	e2:SetOperation(c75733063.operation)
	c:RegisterEffect(e2)
end
function c75733063.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x13)
end
function c75733063.val(e,c)
	return Duel.GetMatchingGroupCount(c75733063.atkfilter,0,LOCATION_MZONE,LOCATION_MZONE,c)*200
end
function c75733063.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c75733063.filter(c,e,tp)
	return c:IsSetCard(0x6013) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c75733063.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c75733063.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c75733063.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75733063.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
