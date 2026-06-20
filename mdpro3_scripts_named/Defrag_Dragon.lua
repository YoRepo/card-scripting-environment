--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 重整龙  (ID: 58582979)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Dragon
-- Level 3
-- ATK 1000 | DEF 600
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：这张卡可以把手卡1只其他怪兽送去墓地，从手卡特殊召唤。
-- ②：这张卡在墓地存在的场合，从自己墓地把这张卡以外的3只同名怪兽除外才能发动。这张卡从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デフラドラグーン
function c58582979.initial_effect(c)
	--special summon (hand)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,58582979+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c58582979.hspcon)
	e1:SetTarget(c58582979.hsptg)
	e1:SetOperation(c58582979.hspop)
	c:RegisterEffect(e1)
	--special summon (grave)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,58582980)
	e2:SetCost(c58582979.spcost)
	e2:SetTarget(c58582979.sptg)
	e2:SetOperation(c58582979.spop)
	c:RegisterEffect(e2)
end
function c58582979.hspcfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c58582979.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c58582979.hspcfilter,tp,LOCATION_HAND,0,1,c)
end
function c58582979.hsptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c58582979.hspcfilter,tp,LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c58582979.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
end
function c58582979.spcfilter1(c,tp,ec)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c58582979.spcfilter2,tp,LOCATION_GRAVE,0,2,Group.FromCards(ec,c),c:GetCode())
end
function c58582979.spcfilter2(c,code)
	return c:IsCode(code) and c:IsAbleToRemoveAsCost()
end
function c58582979.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c58582979.spcfilter1,tp,LOCATION_GRAVE,0,1,c,tp,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c58582979.spcfilter1,tp,LOCATION_GRAVE,0,1,1,c,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c58582979.spcfilter2,tp,LOCATION_GRAVE,0,2,2,Group.FromCards(c,g:GetFirst()),g:GetFirst():GetCode())
	g:Merge(g2)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c58582979.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c58582979.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
