--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 霞雾秃鹰  (ID: 65549080)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 4
-- ATK 1400 | DEF 400
--
-- Effect Text:
-- 这张卡可以让自己场上表侧表示存在的1只名字带有「霞之谷」的怪兽回到手卡，从手卡特殊召唤。这个方法特殊召唤的这张卡的攻击力变成1700。
--[[ __CARD_HEADER_END__ ]]

--ミスト・コンドル
function c65549080.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c65549080.spcon)
	e1:SetTarget(c65549080.sptg)
	e1:SetOperation(c65549080.spop)
	c:RegisterEffect(e1)
end
function c65549080.spfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x37) and c:IsAbleToHandAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function c65549080.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c65549080.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c65549080.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c65549080.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c65549080.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_SPSUMMON)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(1700)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
