--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 陷阱吞噬者  (ID: 13821299)
-- Type: Monster / Effect / Tuner / SpecialSummon
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1900 | DEF 1600
--
-- Effect Text:
-- 这张卡不能通常召唤。把对方场上表侧表示存在的1张陷阱卡送去墓地的场合才能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--トラップ・イーター
function c13821299.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--spsummon proc
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c13821299.spcon)
	e2:SetTarget(c13821299.sptg)
	e2:SetOperation(c13821299.spop)
	c:RegisterEffect(e2)
end
function c13821299.spfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c13821299.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13821299.spfilter,c:GetControler(),0,LOCATION_ONFIELD,1,nil)
end
function c13821299.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c13821299.spfilter,tp,0,LOCATION_ONFIELD,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c13821299.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
end
