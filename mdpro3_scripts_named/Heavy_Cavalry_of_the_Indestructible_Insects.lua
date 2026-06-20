--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 无死虫团的重骑兵  (ID: 50123605)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Insect
-- Level 7
-- ATK 2500 | DEF 1800
--
-- Effect Text:
-- 5星以上的昆虫族怪兽＋昆虫族怪兽
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡只要在怪兽区域存在，不会被对方的效果破坏。
-- ②：自己·对方回合，自己场上的表侧表示怪兽只有昆虫族怪兽的场合，以包含自己场上的昆虫族怪兽的场上2只怪兽为对象才能发动。那些怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--無死虫団の重騎兵
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	aux.AddFusionProcFun2(c,s.matfilter,aux.FilterBoolFunction(Card.IsRace,RACE_INSECT),true)
	c:EnableReviveLimit()
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(aux.indoval)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,id)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCondition(s.rmcon)
	e2:SetTarget(s.rmtg)
	e2:SetOperation(s.rmop)
	c:RegisterEffect(e2)
end
function s.matfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsLevelAbove(5)
end
function s.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,aux.NOT(Card.IsRace)),tp,LOCATION_MZONE,0,1,nil,RACE_INSECT)
end
function s.rmfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_INSECT) and c:IsAbleToRemove()
		and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function s.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(s.rmfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,s.rmfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,g1)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,2,0,0)
end
function s.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
	end
end
