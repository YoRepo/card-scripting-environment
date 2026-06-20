--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 异次元喷气机·大铁号  (ID: 15574615)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Machine
-- Level 10
-- ATK 4000 | DEF 0
--
-- Effect Text:
-- 这张卡不能通常召唤。从自己的手卡·场上把「异次元超能人·星斗罗宾」「野兽战士 豹人」「凤王兽 铠楼罗」「铁巨人
-- 大铁锤」各1只送去墓地的场合可以特殊召唤。此外，可以把自己场上的这张卡解放，选择自己墓地的「异次元超能人·星斗罗宾」「野兽战士 豹人」「凤王兽 铠楼罗」「铁巨人 大铁锤」各1只特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--異次元ジェット・アイアン号
function c15574615.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c15574615.spcon)
	e1:SetTarget(c15574615.sptg)
	e1:SetOperation(c15574615.spop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(15574615,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c15574615.cost)
	e2:SetTarget(c15574615.target)
	e2:SetOperation(c15574615.operation)
	c:RegisterEffect(e2)
end
c15574615.spchecks=aux.CreateChecks(Card.IsCode,{80208158,16796157,43791861,79185500})
function c15574615.spcostfilter(c)
	return (c:IsLocation(LOCATION_HAND) or c:IsFaceup()) and c:IsAbleToGraveAsCost()
		and c:IsCode(80208158,16796157,43791861,79185500)
end
function c15574615.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c15574615.spcostfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	return g:CheckSubGroupEach(c15574615.spchecks,aux.mzctcheck,tp)
end
function c15574615.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c15574615.spcostfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroupEach(tp,c15574615.spchecks,true,aux.mzctcheck,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c15574615.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c15574615.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c15574615.spfilter(c,e,tp)
	return c:IsCode(80208158,16796157,43791861,79185500) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function c15574615.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c15574615.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
		and g:CheckSubGroupEach(c15574615.spchecks)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:SelectSubGroupEach(tp,c15574615.spchecks)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,4,0,0)
end
function c15574615.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()>ft then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
