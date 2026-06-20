--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 胡萝卜人  (ID: 44928016)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 4
-- ATK 1900 | DEF 0
--
-- Effect Text:
-- 「胡萝卜人」的效果1回合只能使用1次。
-- ①：这张卡在墓地存在的场合，从手卡以及自己场上的表侧表示怪兽之中把「胡萝卜人」以外的1只植物族怪兽送去墓地才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--にん人
function c44928016.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44928016,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,44928016)
	e1:SetCost(c44928016.cost)
	e1:SetTarget(c44928016.target)
	e1:SetOperation(c44928016.operation)
	c:RegisterEffect(e1)
end
function c44928016.cfilter(c,ft)
	return c:IsRace(RACE_PLANT) and (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and not c:IsCode(44928016) and c:IsAbleToGraveAsCost()
		and (ft>0 or c:GetSequence()<5)
end
function c44928016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local loc=LOCATION_MZONE+LOCATION_HAND
	if ft==0 then loc=LOCATION_MZONE end
	if chk==0 then return ft>-1 and Duel.IsExistingMatchingCard(c44928016.cfilter,tp,loc,0,1,nil,ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c44928016.cfilter,tp,loc,0,1,1,nil,ft)
	Duel.SendtoGrave(g,REASON_COST)
end
function c44928016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c44928016.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
