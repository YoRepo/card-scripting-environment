--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 触腕鲨  (ID: 71923655)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 6
-- ATK 2400 | DEF 2100
-- Setcode: 440
--
-- Effect Text:
-- 这张卡可以把自己场上1只水属性怪兽解放，从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--シャークラーケン
function c71923655.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c71923655.spcon)
	e1:SetTarget(c71923655.sptg)
	e1:SetOperation(c71923655.spop)
	c:RegisterEffect(e1)
end
function c71923655.spfilter(c,tp)
	return c:IsAttribute(ATTRIBUTE_WATER)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c71923655.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c71923655.spfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c71923655.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c71923655.spfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c71923655.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
