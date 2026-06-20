--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 龙王之圣刻印  (ID: 64514622)
-- Type: Monster / Effect / Gemini
-- Attribute: LIGHT
-- Race: Dragon
-- Level 6
-- ATK 0 | DEF 0
-- Setcode: 105
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。可以通过把场上表侧表示存在的这张卡当作通常召唤作再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●把这张卡解放才能发动。从自己的手卡·卡组·墓地选「龙王之圣刻印」以外的1只名字带有「圣刻」的怪兽表侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--龍王の聖刻印
function c64514622.initial_effect(c)
	aux.EnableDualAttribute(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(64514622,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(aux.IsDualState)
	e1:SetCost(c64514622.cost)
	e1:SetTarget(c64514622.target)
	e1:SetOperation(c64514622.operation)
	c:RegisterEffect(e1)
end
function c64514622.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c64514622.filter(c,e,tp)
	return c:IsSetCard(0x69) and not c:IsCode(64514622) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c64514622.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c64514622.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c64514622.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c64514622.filter),tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
