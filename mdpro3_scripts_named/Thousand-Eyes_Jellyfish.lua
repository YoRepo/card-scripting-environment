--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 千眼卵鱼  (ID: 81434470)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: WATER
-- Race: Fish
-- Level 5
-- ATK 300 | DEF 2100
--
-- Effect Text:
-- 这张卡不能通常召唤，把自己场上存在的1只「海洋怪鱼卫士」解放的场合才能特殊召唤。只要这张卡在自己场上表侧表示存在，对方必须把手卡持续公开。
--[[ __CARD_HEADER_END__ ]]

--サウザンド・アイズ・フィッシュ
function c81434470.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c81434470.spcon)
	e2:SetTarget(c81434470.sptg)
	e2:SetOperation(c81434470.spop)
	c:RegisterEffect(e2)
	--public
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_PUBLIC)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_HAND)
	c:RegisterEffect(e3)
end
function c81434470.spfilter(c,tp)
	return c:IsCode(45045866)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c81434470.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c81434470.spfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c81434470.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c81434470.spfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c81434470.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
