--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 钢铁恶魔兽灵  (ID: 50705071)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 3000 | DEF 2300
--
-- Effect Text:
-- 这张卡不能通常召唤。把有「金属化·魔法反射装甲」装备的自己场上1只「恶魔兽灵」解放的场合可以从卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--メタル・デビルゾア
function c50705071.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCondition(c50705071.spcon)
	e1:SetTarget(c50705071.sptg)
	e1:SetOperation(c50705071.spop)
	c:RegisterEffect(e1)
end
function c50705071.spfilter(c,tp)
	return c:IsCode(24311372) and c:GetEquipGroup():IsExists(Card.IsCode,1,nil,68540058)
		and Duel.GetMZoneCount(tp,c)>0
end
function c50705071.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.CheckReleaseGroupEx(tp,c50705071.spfilter,1,REASON_SPSUMMON,false,nil,tp)
end
function c50705071.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetReleaseGroup(tp,false,REASON_SPSUMMON):Filter(c50705071.spfilter,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c50705071.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Release(g,REASON_SPSUMMON)
	Duel.ShuffleDeck(tp)
end
