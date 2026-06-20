--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 灵魂护送船  (ID: 33347467)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Fiend
-- Level 5
-- ATK 1900 | DEF 1000
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己墓地存在的1只光属性怪兽从游戏中除外的场合可以特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--霊魂の護送船
function c33347467.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c33347467.spcon)
	e1:SetTarget(c33347467.sptg)
	e1:SetOperation(c33347467.spop)
	c:RegisterEffect(e1)
end
function c33347467.spfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToRemoveAsCost()
end
function c33347467.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33347467.spfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c33347467.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c33347467.spfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c33347467.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
end
