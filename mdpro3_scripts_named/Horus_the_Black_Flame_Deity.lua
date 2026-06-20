--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 荷鲁斯之黑炎神  (ID: 99307040)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 1800
-- Setcode: 413
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有「荷鲁斯」怪兽以及「王之棺」存在的场合，把手卡的这张卡给对方观看，把自己的手卡·场上1张卡送去墓地才能发动。场上1张卡送去墓地。
-- ②：「荷鲁斯之黑炎神」以外的自己场上的表侧表示的「荷鲁斯」怪兽或「王之棺」因对方的效果从场上离开的场合才能发动。这张卡从手卡特殊召唤。那之后，可以把场上的其他怪兽全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ホルスの黒炎神
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,16528181)
	--SendtoGrave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.tgcon)
	e1:SetCountLimit(1,id)
	e1:SetCost(s.tgcost)
	e1:SetOperation(s.tgop)
	c:RegisterEffect(e1)
	--Leave Field
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.sscon)
	e2:SetTarget(s.sstg)
	e2:SetOperation(s.ssop)
	c:RegisterEffect(e2)
end
function s.tgcfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x19d)
end
function s.tgcfilter2(c)
	return c:IsFaceup() and c:IsCode(16528181)
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.tgcfilter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.tgcfilter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function s.costfilter(c)
	return c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function s.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic()
		and Duel.IsExistingMatchingCard(s.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,s.costfilter,tp,LOCATION_ONFIELD+LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function s.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousPosition(POS_FACEUP)
		and ((c:IsPreviousSetCard(0x19d) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousCodeOnField()~=id) or c:GetPreviousCodeOnField()==16528181)
end
function s.sscon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,c)
		if sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.BreakEffect()
			Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
end
