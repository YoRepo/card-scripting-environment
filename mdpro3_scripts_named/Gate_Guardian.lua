--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 门之守护神  (ID: 25833572)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Warrior
-- Level 11
-- ATK 3750 | DEF 3400
-- Setcode: 4178
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己场上的「雷魔神-桑迦」「风魔神-修迦」「水魔神-斯迦」各1只解放的场合可以特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ゲート・ガーディアン
function c25833572.initial_effect(c)
	aux.AddCodeList(c,25955164,62340868,98434877)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c25833572.spcon)
	e1:SetTarget(c25833572.sptg)
	e1:SetOperation(c25833572.spop)
	c:RegisterEffect(e1)
end
c25833572.spchecks=aux.CreateChecks(Card.IsCode,{25955164,62340868,98434877})
function c25833572.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON)
	return g:CheckSubGroupEach(c25833572.spchecks,aux.mzctcheckrel,tp,REASON_SPSUMMON)
end
function c25833572.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:SelectSubGroupEach(tp,c25833572.spchecks,true,aux.mzctcheckrel,tp,REASON_SPSUMMON)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c25833572.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
