--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 究极完全态大飞蛾  (ID: 48579379)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: EARTH
-- Race: Insect
-- Level 8
-- ATK 3500 | DEF 3000
--
-- Effect Text:
-- 这张卡不能通常召唤。把有「进化之茧」装备的状态用自己回合计算经过6回合以上的自己场上1只「飞蛾宝宝」解放的场合可以特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--究極完全態・グレート・モス
function c48579379.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c48579379.spcon)
	e2:SetTarget(c48579379.sptg)
	e2:SetOperation(c48579379.spop)
	c:RegisterEffect(e2)
end
function c48579379.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=6
end
function c48579379.rfilter(c,tp)
	return c:IsCode(58192742) and c:GetEquipGroup():FilterCount(c48579379.eqfilter,nil)>0
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c48579379.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c48579379.rfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c48579379.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c48579379.rfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c48579379.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
end
