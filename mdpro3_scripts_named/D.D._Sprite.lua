--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 异次元的精灵  (ID: 16638212)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fairy
-- Level 1
-- ATK 0 | DEF 100
--
-- Effect Text:
-- ①：这张卡可以把自己场上1只表侧表示怪兽除外，从手卡特殊召唤。
-- ②：这张卡的①的方法特殊召唤的场合，下次的准备阶段发动。为这张卡特殊召唤而除外的怪兽回到场上。
--[[ __CARD_HEADER_END__ ]]

--異次元の精霊
function c16638212.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c16638212.spcon)
	e1:SetTarget(c16638212.sptg)
	e1:SetOperation(c16638212.spop)
	c:RegisterEffect(e1)
end
function c16638212.spfilter(c,tp)
	return c:IsFaceup() and c:IsAbleToRemoveAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function c16638212.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c16638212.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c16638212.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c16638212.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c16638212.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,0,REASON_SPSUMMON+REASON_TEMPORARY)
	tc:RegisterFlagEffect(16638212,RESET_EVENT+RESETS_STANDARD,0,0)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16638212,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_EVENT+0xff0000+RESET_PHASE+PHASE_STANDBY)
	e1:SetOperation(c16638212.retop)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c16638212.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetFlagEffect(16638212)~=0 then
		Duel.ReturnToField(e:GetLabelObject())
	end
end
