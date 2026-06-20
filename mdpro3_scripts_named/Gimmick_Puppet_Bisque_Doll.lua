--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 机关傀儡-素瓷人偶  (ID: 79086452)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 1000 | DEF 1000
-- Setcode: 4227
--
-- Effect Text:
-- ①：这张卡可以把手卡1只「机关傀儡」怪兽丢弃，从手卡特殊召唤。
-- ②：把墓地的这张卡除外才能发动。这个回合中，对方不能把自己场上的「机关傀儡」怪兽作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－ビスク・ドール
function c79086452.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79086452,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c79086452.spcon)
	e1:SetTarget(c79086452.sptg)
	e1:SetOperation(c79086452.spop)
	c:RegisterEffect(e1)
	--protection
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79086452,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c79086452.operation)
	c:RegisterEffect(e2)
end
function c79086452.spfilter(c)
	return c:IsSetCard(0x1083) and c:IsType(TYPE_MONSTER)
end
function c79086452.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c79086452.spfilter,tp,LOCATION_HAND,0,1,c)
end
function c79086452.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c79086452.spfilter,tp,LOCATION_HAND,0,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c79086452.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON+REASON_DISCARD)
end
function c79086452.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c79086452.efftg)
	e1:SetValue(aux.tgoval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c79086452.efftg(e,c)
	return c:IsSetCard(0x1083)
end
