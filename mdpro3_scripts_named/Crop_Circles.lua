--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 麦田圈  (ID: 24082387)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上任意数量的怪兽送去墓地发动。从自己卡组选择1只送去墓地的怪兽的合计等级的名字带有「外星」的怪兽特殊召唤。召唤失败的场合，自己受到2000分的伤害。
--[[ __CARD_HEADER_END__ ]]

--ミステリーサークル
function c24082387.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetLabel(0)
	e1:SetCost(c24082387.cost)
	e1:SetTarget(c24082387.target)
	e1:SetOperation(c24082387.activate)
	c:RegisterEffect(e1)
end
function c24082387.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	return true
end
function c24082387.filter1(c,e,tp,cg,minc)
	return c:IsSetCard(0xc) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and cg:CheckWithSumEqual(Card.GetLevel,c:GetLevel(),minc,99)
end
function c24082387.cgfilter(c)
	return c:GetLevel()>0 and c:IsAbleToGraveAsCost() and bit.band(c:GetOriginalType(),TYPE_MONSTER)~=0
end
function c24082387.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local cg=Duel.GetMatchingGroup(c24082387.cgfilter,tp,LOCATION_MZONE,0,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local minc=-ft+1
	if minc<=0 then minc=1 end
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c24082387.filter1,tp,LOCATION_DECK,0,1,nil,e,tp,cg,minc)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local rg=Duel.SelectMatchingCard(tp,c24082387.filter1,tp,LOCATION_DECK,0,1,1,nil,e,tp,cg,minc)
	e:SetLabel(rg:GetFirst():GetLevel())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=cg:SelectWithSumEqual(tp,Card.GetLevel,e:GetLabel(),minc,99)
	Duel.SendtoGrave(sg,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c24082387.filter2(c,e,tp,lv)
	return c:IsSetCard(0xc) and c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c24082387.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then Duel.Damage(tp,2000,REASON_EFFECT) return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c24082387.filter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,e:GetLabel())
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	else Duel.Damage(tp,2000,REASON_EFFECT) end
end
